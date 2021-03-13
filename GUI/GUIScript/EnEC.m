
function A=EnEC(MAT,soc_min)

if isempty(MAT)~=1
    load(MAT)
    
    %------------------------------------------------------
    %Calculating VTS parameters
    %calculating Cd to Cs Transition Point
    if ismember(1,(BMS_SOC<=soc_min&BMS_SOC>0))==1
        x = find(BMS_SOC<=soc_min&BMS_SOC>0,1);% find the cs to cd point
    else
        x=length(BMS_SOC);
    end
    
    
    % fuel consumption in gal
    eng_fuel_comsump_gal_tot=sum(InstFuelConsmpRate)/3600*1/3.7829;% litter/hr to gal/s
    eng_fuel_comsump_gal_cd=sum(InstFuelConsmpRate(1:1:x))/3600*1/3.7829;
    eng_fuel_comsump_gal_cs=eng_fuel_comsump_gal_tot-eng_fuel_comsump_gal_cd;
    % fuel energy consumption Wh
    eng_fuel_comsump_energy_tot=eng_fuel_comsump_gal_tot*23.7*1000; %
    eng_fuel_comsump_energy_cd=eng_fuel_comsump_gal_cd*23.7*1000;
    eng_fuel_comsump_energy_cs=eng_fuel_comsump_energy_tot-eng_fuel_comsump_energy_cd;
    
    
    
    
    %%----------------Range calculation
    %Total range
    total_range_km = sum(VehSpdAvgDrvn/3.6)/1000;%in km
    total_range_mi = total_range_km*0.621;
    % Calculating the Cd range
    
    Cd_range_km =sum(VehSpdAvgDrvn(1:1:x)/3.6)/1000+1e-6; %in km
   
    Cd_range_mi = Cd_range_km*0.621;
    
    % Calculating the Cs range
    
    Cs_range_km = total_range_km - Cd_range_km+1e-6 ;%in Km
    
    
    Cs_range_mi = total_range_mi - Cd_range_mi+1e-6 ;%in miles
    
    
    
    
    %%-------------- AC Energy consumption calculation
    P_bat=-BMS_IstSpannung.*BMS_IstStrom/3600; % Wh/s
    
    % Total Electric Energy Consumption
    EC_total_km=sum(P_bat)/total_range_km;% Wh/km
    EC_total_mi=sum(P_bat)/total_range_mi;
    
    
    % CD Mode Electric Energy Consumption
    
    EC_Cd_km = sum(P_bat(1:1:x))/Cd_range_km;% Wh/km
    EC_Cd_mi = sum(P_bat(1:1:x))/Cd_range_mi;% Wh/mi
    if EC_Cd_km>1e4
        EC_Cd_km=0;
        EC_Cd_mi=0;
    end
    
    % CS Mode Electric Energy Consumption
    EC_Cs_km =(sum(P_bat)- sum(P_bat(1:1:x)))/Cs_range_km; % Wh/km
    EC_Cs_mi = (sum(P_bat)- sum(P_bat(1:1:x)))/Cs_range_mi ;% Wh/mi
    
    
    
    
    % CD Mode Fuel Energy Consumption
    FC_Cd_km =eng_fuel_comsump_energy_cd/Cd_range_km;  % wh/km
    FC_Cd_mi =eng_fuel_comsump_energy_cd/Cd_range_mi ; % wh/mile
    
    
    % CS Mode Fuel Energy Consumption
    FC_Cs_km =eng_fuel_comsump_energy_cs/Cs_range_km;  % wh/km
    FC_Cs_mi =eng_fuel_comsump_energy_cs/Cs_range_mi;  % wh/mile
    
    %%  total energy consumption
    % CD
    EC_Cd_total_km =FC_Cd_km+EC_Cd_km ; % wh/km
    EC_Cd_total_mi =FC_Cd_mi+EC_Cd_mi;  % wh/mi
    
    % CS
    EC_Cs_total_km =FC_Cs_km+EC_Cs_km ; % wh/km
    EC_Cs_total_mi =FC_Cs_mi+EC_Cs_mi  ;% wh/mi
    
    %%
    
    
    
    % %---------Emission calulation
    % UCE=FC_Cs_mi.*[0.0172,0.0078,0.0448]/1000 % g/mi,NOx,CO,THC
    %
    % % downstream emission calculation
    %
    % DCE=[NOx_mdl_Cs,CO_mdl_Cs,THC_mdl_Cs]/Cs_range_mi %   result in model to be verified
    %
    % % total CS emission
    % EmisionTotal=UCE+DCE
    
    %-----------------UF-Weighted Fuel Energy Consumption
    % if Cd_range_mi<=1e-5
    %          UF=0;
    % else
    % if ismember(1,(BMS_SOC<=soc_min&BMS_SOC>0))==1
    
    
    % Calculating the Utility Factor
    Dn = 399.9 ;
    al = zeros(6,1) ;
    C = [-10.52,7.282,26.37,-79.08,77.36,-26.07] ;%[-10.52,7.282,26.37,-79.08,77.36,-26.07]
    for n = 1:6
        al(n) = (C(n)*(Cd_range_mi/Dn)^n) ;
    end
    a = sum(al) ;
    UF = 1 - exp(a);  %utility Factor
    % else
    %
    %     UF=1 ;
    %
    % end
    
    % end
    %UF-Weighted Fuel Energy Consumption
    UF_weighted_FC_km=UF*FC_Cd_km+(1-UF)*FC_Cs_km; %Wh/km
    
    %UF-Weighted AC Energy Consumption
    
    UF_weighted_AC_km=UF*EC_Cd_km ;%Wh/km
    
    % %UF-Weighted Battery Energy Consumption
    UF_weighted_EC_km=UF*EC_Cd_km+(1-UF)*EC_Cs_km/0.25 ;%Wh/km, when unblanced, 0.25 is efficiency ,eq.20 pdf,when blanced, the later item is 0
    
    %UF-Weighted Total Energy Consumption
    UF_total_EC = UF_weighted_FC_km +UF_weighted_EC_km ;%Wh/km,
    
    UF_total_EC_mpg=1./(UF_total_EC*1.61/1000*1/23.7);
    
    % UF-Weighted PEU
    PEU_wtw_weighted=UF_weighted_FC_km*0.274+UF_weighted_AC_km*0.033; % Wh/km
    
    %UF-Weighted GHG
    
    GHG_wtw_weighted=(UF_weighted_FC_km*244+UF_weighted_AC_km*489)/1000; % g/km
    
    
    
    %UF-Weighted Criteria Emissions Score
    
    % UCE_upstream_weighted=UF_weighted_FC_km.*[0.0172,0.0078,0.0448]/1000 % g/km,[NOx,CO,THC]
    % UCE_downstream_weighted=[NOx_weighted,CO_weighted,THC_weighted]  % use result calculated from model, then weight the result
    % UCE_total_weighted=UCE_upstream_weighted+UCE_downstream_weighted
    % CriteriaEmissionsScore=((UCE_total_weighted(2)/10)^2+UCE_total_weighted(3)^2+UCE_total_weighted(1)^2)^(-1/2) % eq. 31 pdf
    
    
    % %%
    if Cd_range_km<1e-5
        Cd_range_km=0;
        Cd_range_mi=0;
        UF=0;
    end
    A=[eng_fuel_comsump_gal_tot,total_range_km,total_range_mi,Cd_range_km,Cd_range_mi,UF,EC_Cd_total_km, EC_Cd_km,FC_Cd_km, Cs_range_km,Cs_range_km,EC_Cs_total_km,FC_Cs_km,EC_Cs_km  ...
        UF_total_EC_mpg,UF_total_EC,UF_weighted_FC_km,UF_weighted_AC_km,PEU_wtw_weighted,GHG_wtw_weighted]';
else
    A=[];
end







%UF-Weighted Criteria Emissions Score

% UCE_upstream_weighted=UF_weighted_FC_km.*[0.0172,0.0078,0.0448]/1000;% g/km,[NOx,CO,THC];
% UCE_downstream_weighted=[NOx_weighted,CO_weighted,THC_weighted]; % use result calculated from model, then weight the result
% UCE_total_weighted=UCE_upstream_weighted+UCE_downstream_weighted;
% CriteriaEmissionsScore=((UCE_total_weighted(2)/10)^2+UCE_total_weighted(3)^2+UCE_total_weighted(1)^2)^(-1/2);% eq. 31 pdf







