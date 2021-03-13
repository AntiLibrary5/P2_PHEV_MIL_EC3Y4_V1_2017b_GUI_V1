close all
clear all
clc
open Run_Simulator.slx;

%DriveCycle            = get_param('Run_Simulator/Inputs','DriveCyc');
DriveCycle            = 'EnEC_full.mat'
ess.plant.initial_soc = str2num(get_param('Run_Simulator/Inputs','init_soc'));
ess.plant.cd_soc_min  = str2num(get_param('Run_Simulator/Inputs','cd_soc_min'));
ess.plant.cs_soc_max  = str2num(get_param('Run_Simulator/Inputs','cs_soc_max'));
ess.plant.cs_soc_min  = str2num(get_param('Run_Simulator/Inputs','cs_soc_min'));
veh.init.mass         = str2num(get_param('Run_Simulator/Inputs','veh_mass'));
Tamb                  = str2num(get_param('Run_Simulator/Inputs','Tamb'));
ResFileName           = get_param('Run_Simulator/Inputs','ResFileName');

run  Main_Init.m
run  HCU_Calibration.m
run Fault_Clean.m
sportsmodesw = 0;
%open SIL_Model.slx
disp(' ')
disp('Running Drive Cycle: IVM_to_60mph')
disp('Please Wait......')

sim  P2_Parallel_MIL_withTrailer.slx

%Pack Energy Wh
min_batt_energy = 7250;
nom_batt_energy = 9700;
max_batt_energy = 10700;

% charge used in Cd mode
charge_used = (ess.plant.initial_soc - ess.plant.cs_soc_min)/100; %in decimal

%pack energy available for use
energy_available = charge_used*nom_batt_energy;

%Calculating VTS parameters

%calculating Cd to Cs Transition Point
x = find(BMS_SOC_hist<=(ess.plant.cs_soc_min/100),1);
%Last point of distance array
y = find(veh_dist_meter_hist, 1, 'last');
%last point of engine fuel consumption in Wh
eng_fule_comsump_gal=(distance_miles_hist./eng_fuel_consump_mpl)*0.264172;
eng_fule_comsump_gal(isinf(eng_fule_comsump_gal)) = 0;
z = find(eng_fule_comsump_gal>=9,1);

%Weighted Charge Deplition Energy Consumption in Wh/mi
EC_Cd_505_km = ess_wh_per_km(x)*0.29; 
%Weighted Charge Deplition Energy Consumption in Wh/Km
EC_Cd_505_mi = ess_wh_per_km(x)*0.29/1.6; 

%We calculate the diffrence between the Cd range and the total range.
%This diffrence value is then divided by the fuel consumption value.

% Calculating the Cd range
Cd_range_mi = distance_miles_hist(x); %in miles
Cd_range_km = distance_miles_hist(x)*1.60; %in Km

%Total range
total_range_mi_505 = distance_miles_hist(z); %in miles
total_range_km_505 = distance_miles_hist(z)*1.60; %in Km

% Calculating the Cs range
Cs_range_mi = total_range_mi_505 - Cd_range_mi; %in miles
Cs_range_km = total_range_km_505 - Cd_range_km; %in Km

%value of the engine fuel consumption
FC = eng_wh_per_mile_hist(z);

%Weighted Charge Sustaining Energy Consumption in Wh/mi
EC_Cs_505_mi = FC*0.29;
%Weighted Charge Sustaining Energy Consumption in Wh/Km
EC_Cs_505_km = (FC/1.6)*0.29;


clearvars -except EC_Cd_505_mi EC_Cd_505_km EC_Cs_505_mi EC_Cs_505_km...
    total_range_mi_505 total_range_km_505
