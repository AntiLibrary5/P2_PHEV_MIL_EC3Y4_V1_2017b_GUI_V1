
%DriveCycle            = get_param('Run_Simulator/Inputs','DriveCyc');
% DriveCycle            = 'EnEC_505.mat';
% ess.plant.initial_soc = 90;
% ess.plant.cd_soc_min  = 50;
% ess.plant.cs_soc_max  = 23;
% ess.plant.cs_soc_min  = 18;
% veh.init.mass         = 1765;
% Tamb                  = 25;

%---
run  Main_Init.m
run  HCU_Calibration.m
run Fault_Clean.m
sportsmodesw = 0;

open P2_Parallel_MIL_withTrailer_2017a.slx
sim  P2_Parallel_MIL_withTrailer_2017a.slx
% %Pack Energy Wh
min_batt_energy = 7250;
nom_batt_energy = 9700;
max_batt_energy = 10700;
% 
% % charge used in Cd mode
% charge_used = (ess.plant.initial_soc - ess.plant.cs_soc_min)/100; %in decimal
% 
% %pack energy available for use
% energy_available = charge_used*nom_batt_energy;

%------------------------------------------------------
%Calculating VTS parameters

%calculating Cd to Cs Transition Point
x = find(BMS_SOC_hist<=(ess.plant.cs_soc_min/100),1);% find the first point approaching the lower boudary SOC
%Last point of distance array


%last point of engine fuel consumption in Wh
eng_fuel_comsump_gal=(distance_miles_hist./eng_fuel_consump_mpl)*0.264172;% litter to gallon,how to get eng_fuel_consump_mpl;fuel consumption integration
eng_fuel_comsump_gal(isinf(eng_fuel_comsump_gal)) = 0;
z = find(eng_fuel_comsump_gal>=10,1); %  10 gallon
engine_fule_consumption_final=eng_fuel_comsump_gal(z);
%----------------Range calculation
%Total range
total_range_mi = distance_miles_hist(z); %in miles
total_range_km = distance_miles_hist(z)*1.60; %in Km

% Calculating the Cd range
Cd_range_mi = distance_miles_hist(x); %in miles
Cd_range_km = distance_miles_hist(x)*1.60; %in Km

% Calculating the Cs range
Cs_range_mi = total_range_mi - Cd_range_mi; %in miles
Cs_range_km = total_range_km - Cd_range_km; %in Km

%%--------------CD mode calculation

% CD mode total energy consumption
EC_Cd_total_km = ess_wh_per_km(x)+eng_wh_per_mile_hist(x)/1.6; % wh/km
EC_Cd_total_mi = ess_wh_per_km(x)*1.6+eng_wh_per_mile_hist(x); % wh/mile


% CD Mode Electric Energy Consumption
EC_Cd_km = ess_wh_per_km(x); % wh/km
EC_Cd_mi = ess_wh_per_km(x)*1.6; % wh/mile

% CD Mode Fuel Energy Consumption
FC_Cd_km =eng_wh_per_mile_hist(x)/1.6; % wh/km
FC_Cd_mi =eng_wh_per_mile_hist(x); % wh/mile


%----CS enegy consumption-----------------


FC_time=eng_wh_per_mile_hist.*distance_miles_hist;% wh, engine

EC_time=ess_wh_per_km(x)*1.6.*distance_miles_hist;% wh, ess



% CS mode total energy consumption
EC_Cs_total_km =(FC_time(z)-FC_time(x)+(EC_time(z)-EC_time(x))/0.25)/Cs_range_km ; % wh/km

EC_Cs_total_mi =(FC_time(z)-FC_time(x)+(EC_time(z)-EC_time(x))/0.25)/Cs_range_mi ; % wh/mile


% CS Mode Electric Energy Consumption
EC_Cs_km = (EC_time(z)-EC_time(x))/Cs_range_km ; % wh/km
EC_Cs_mi = (EC_time(z)-EC_time(x))/Cs_range_mi ; % wh/mile
 
% CS Mode Fuel Energy Consumption
FC_Cs_km =(FC_time(z)-FC_time(x))/Cs_range_km ; % wh/km
FC_Cs_mi =(FC_time(z)-FC_time(x))/Cs_range_mi ; % wh/mile


%---------Emission calulation
UCE=FC_Cs_mi.*[0.0172,0.0078,0.0448]/1000;% g/mi,NOx,CO,THC;

% downstream emission calculation

DCE=[NOx_mdl_Cs,CO_mdl_Cs,THC_mdl_Cs]/Cs_range_mi;%   result in model to be verified

% total CS emission
EmisionTotal=UCE+DCE;

%-----------------UF-Weighted Fuel Energy Consumption

% Calculating the Utility Factor
Dn = 399.9;
al = zeros(6,1);
C = [-10.52,7.282,26.37,-79.08,77.36,-26.07];%[-10.52,7.282,26.37,-79.08,77.36,-26.07]
for n = 1:6
    al(n) = (C(n)*(Cd_range_mi/Dn)^n);
end
 a = sum(al);
UF = 1 - exp(a); %utility Factor

%UF-Weighted Fuel Energy Consumption
UF_weighted_FC_km=UF*FC_Cd_km+(1-UF)*FC_Cs_km;%Wh/km

%UF-Weighted AC Energy Consumption

UF_weighted_AC_km=UF*EC_Cd_km;%Wh/km

% %UF-Weighted Battery Energy Consumption
UF_weighted_EC_km=UF*EC_Cd_km+(1-UF)*EC_Cs_km/0.25;%Wh/km, when unblanced, 0.25 is efficiency ,eq.20 pdf,when blanced, the later item is 0

%UF-Weighted Total Energy Consumption
UF_total_EC = UF_weighted_FC_km +UF_weighted_EC_km;%Wh/km, 

% UF-Weighted PEU
PEU_wtw_weighted=UF_weighted_FC_km*0.274+UF_weighted_AC_km*0.033;% Wh/km

%UF-Weighted GHG

GHG_wtw_weighted=(UF_weighted_FC_km*244+UF_weighted_AC_km*489)/1000;% g/km

%UF-Weighted Criteria Emissions Score

UCE_upstream_weighted=UF_weighted_FC_km.*[0.0172,0.0078,0.0448]/1000;% g/km,[NOx,CO,THC];
UCE_downstream_weighted=[NOx_weighted,CO_weighted,THC_weighted]; % use result calculated from model, then weight the result
UCE_total_weighted=UCE_upstream_weighted+UCE_downstream_weighted;
CriteriaEmissionsScore=((UCE_total_weighted(2)/10)^2+UCE_total_weighted(3)^2+UCE_total_weighted(1)^2)^(-1/2);% eq. 31 pdf




%We calculate the diffrence between the Cd range and the total range.
%This diffrence value is then divided by the fuel consumption value.


% %value of the engine fuel consumption
% FC = eng_wh_per_mile_hist(z);
% 
% %Weighted Charge Sustaining Energy Consumption in Wh/mi
% EC_Cs_505_mi = FC*0.29;
% %Weighted Charge Sustaining Energy Consumption in Wh/Km
% EC_Cs_505_km = (FC/1.6)*0.29;
% 
% 
% clearvars -except EC_Cd_505_mi EC_Cd_505_km EC_Cs_505_mi EC_Cs_505_km...
%     total_range_mi_505 total_range_km_505