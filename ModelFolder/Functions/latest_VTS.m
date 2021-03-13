%%%%%%VTS Calculator%%%%%%
%% 1. IVM to 60 mph acceleration time calculation
clear;
clc;
open Run_Simulator.slx;

%DriveCycle           = get_param('Run_Simulator/Inputs','DriveCyc');
DriveCycle            = 'IVM_to_60mph.mat';
ess.plant.initial_soc = str2num(get_param('Run_Simulator/Inputs','init_soc'));
ess.plant.cd_soc_min  = str2num(get_param('Run_Simulator/Inputs','cd_soc_min'));
ess.plant.cs_soc_max  = str2num(get_param('Run_Simulator/Inputs','cs_soc_max'));
ess.plant.cs_soc_min  = str2num(get_param('Run_Simulator/Inputs','cs_soc_min'));
veh.init.mass         = str2num(get_param('Run_Simulator/Inputs','veh_mass'));
Tamb                  = str2num(get_param('Run_Simulator/Inputs','Tamb'));
ResFileName           = get_param('Run_Simulator/Inputs','ResFileName');

run  Main_Init.m;
run  HCU_Calibration.m
run Fault_Clean.m
sportsmodesw = 1;
%open SIL_Model.slx
disp(' ')
disp('Running Drive Cycle: IVM_to_60mph')
disp('Please Wait......')

sim  P2_Parallel_MIL_withTrailer.slx

DcyStart = find(veh_spd_mph_hist>=1,1);
TimeStart = Time(DcyStart);
DcyEnd = find(veh_spd_mph_hist>60,1);
TimeEnd = Time(DcyEnd);
TimeCyc_IVMto60 = (TimeEnd - TimeStart);
%TimeCyc_IVMto60=(DcyEnd-DcyStart)/WORKSPACE_DECIMATION;
% save('Results/Results_IVM_to_60mph.mat','TimeCyc_IVMto60','-append')
% ResFileName='Results_IVM_to_60mph';
% ResFileName=['Results_',ResFileName,'.mat'];
% save(ResFileName);
 VTSFile=['Results/Results_Perf.mat'];
save(VTSFile,'TimeCyc_IVMto60')
%% 2. 50 to 70 mph acceleration time calculation
clear;
clc;
open Run_Simulator.slx;

%DriveCycle            = get_param('Run_Simulator/Inputs','DriveCyc');
DriveCycle            = '50_to_70mph.mat'
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
sportsmodesw = 1;
%open SIL_Model.slx
disp(' ')
disp('Running Drive Cycle: 50_to_70mph')
disp('Please Wait......')

sim  P2_Parallel_MIL_withTrailer.slx

DcyStart = find(veh_spd_mph_hist>51.3,1);
TimeStart = Time(DcyStart);
DcyEnd = find(veh_spd_mph_hist>70,1);
TimeEnd = Time(DcyEnd);
TimeCyc_50to70 =(TimeEnd - TimeStart);
% save('Results/Perf.mat','TimeCyc_50to70','-append')
% ResFileName='Results_TimeCyc_50to70';
%  ResFileName=['Results_',ResFileName,'.mat'];
%  save(ResFileName);
 VTSFile=['Results/Results_Perf.mat'];
save(VTSFile,'TimeCyc_50to70')
%% 3. 60 to 0 mph breaking distance calculation
clear;
clc;
open Run_Simulator.slx;

%DriveCycle            = get_param('Run_Simulator/Inputs','DriveCyc');
DriveCycle            = '60_to_0mph.mat'
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
%open SIL_Model.slx
disp(' ')
disp('Running Drive Cycle: braking_60_to_0 in CD Mode')
disp('Please Wait......')

sim  P2_Parallel_MIL_withTrailer.slx

% Calculation
N=Time(end);
for C = 2:(N*10);
if veh_spd_mph_hist(C-1)>60
     if veh_spd_mph_hist(C)<60
         TimeStart = Time(C-1)*10;
         Start_Decel= distance_miles_hist(C);
     end
 end 
 end
% 
N1=(TimeStart);
 for D = N1:N*10; 
 if veh_spd_mph_hist(D)<0.3
    TimeEnd = Time(D-1)*10;
    End_Decel = distance_miles_hist(D);
 end 
 end
% 
DistCyc_60to0 =(End_Decel - Start_Decel)*5280
% 
% save('Results/Perf.mat','DistCyc_60to0','-append');
% ResFileName='Results_BrakingCyc_60to0';
%  ResFileName=['Results_',ResFileName,'.mat'];
%  save(ResFileName);
 VTSFile=['Results/Results_Perf.mat'];
save(VTSFile,'DistCyc_60to0')
%% 4. Highway Gradeability,@20 min, 60mph
clear;
clc;
open Run_Simulator.slx;

%DriveCycle            = get_param('Run_Simulator/Inputs','DriveCyc');
DriveCycle            = 'Gradeability_20min_060.mat'
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
sportsmodesw = 1;
%open SIL_Model.slx
sim  P2_Parallel_MIL_withTrailer.slx

syms VTS_4_total_steps VTS_4_start_step VTS_4_stop_step VTS_4_flag VTS_4_result;

VTS_4_start_step=0;
VTS_4_stop_step=0;
VTS_4_flag=0;

VTS_4_total_steps= Cycle_End*10+1;

for n=1:1:VTS_4_total_steps
    if(veh_spd_mph_hist(n)>=60&&VTS_4_start_step==0)
        VTS_4_start_step=n;
        continue
    elseif(veh_spd_mph_hist(n)<60&&VTS_4_start_step~=0)
        if((Time(n)-Time(VTS_4_start_step))>=1200)
            VTS_4_flag=1;
            VTS_4_stop_step=n;
            break
        else
            VTS_4_start_step=0;
            continue;
        end
    else
        if(veh_spd_mph_hist(n)<60&&VTS_4_start_step==0)
            continue;
        else
            if(n==VTS_4_total_steps)
                VTS_4_flag=1;
                VTS_4_stop_step=n;
                break;
            else
                continue;
            end
        end
    end
end

if(VTS_4_flag==1)
    VTS_4_result=(Time(VTS_4_stop_step)-Time(VTS_4_start_step))/60;
    fprintf('The gradeablility of 6 percent for 20 min is achieved and is stays at 60mph or above for : %.2f min.\n', VTS_4_result);
else
    fprintf('The gradeablility of 6 percent for 20 min is not achieved');
end
VTSFile=['Results/Results_gradeability.mat'];
save(VTSFile,'VTS_4_result')

%% 5. Running The EnEC Drive cycle for calculating the VTS
% Running 505 drive cycle

close all
clear all
clc
open Run_Simulator.slx;

%DriveCycle            = get_param('Run_Simulator/Inputs','DriveCyc');
DriveCycle            = 'EnEC_505.mat'
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

% Running The EnEC_HWFET Drive cycle for calculating the VTS
clc
open Run_Simulator.slx;

%DriveCycle            = get_param('Run_Simulator/Inputs','DriveCyc');
DriveCycle            = 'EnEC_HWFET.mat'
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
EC_Cd_HWFET_km = ess_wh_per_km(x)*0.12; 
%Weighted Charge Deplition Energy Consumption in Wh/Km
EC_Cd_HWFET_mi = ess_wh_per_km(x)*0.12/1.6; 

%We calculate the diffrence between the Cd range and the total range.
%This diffrence value is then divided by the fuel consumption value.

% Calculating the Cd range
Cd_range_mi = distance_miles_hist(x); %in miles
Cd_range_km = distance_miles_hist(x)*1.6; %in Km

%Total range
total_range_mi_HWFET = distance_miles_hist(x); %in miles
total_range_km_HWFET = distance_miles_hist(x)*1.6; %in Km

% Calculating the Cs range
Cs_range_mi = total_range_mi_HWFET - Cd_range_mi; %in miles
Cs_range_km = total_range_km_HWFET - Cd_range_km; %in Km

%value of the engine fuel consumption
FC = eng_wh_per_mile_hist(z);

%Weighted Charge Sustaining Energy Consumption in Wh/mi
EC_Cs_HWFET_mi = FC*0.12;
%Weighted Charge Sustaining Energy Consumption in Wh/Km
EC_Cs_HWFET_km = (FC/1.6)*0.12;


clearvars -except EC_Cd_505_mi EC_Cd_505_km EC_Cs_505_mi EC_Cs_505_km...
    EC_Cd_HWFET_mi EC_Cd_HWFET_km EC_Cs_HWFET_mi EC_Cs_HWFET_km...
    total_range_mi_505 total_range_km_505 total_range_mi_HWFET...
    total_range_km_HWFET

% Running The EnEC_US06City Drive cycle for calculating the VTS

clc
open Run_Simulator.slx;

%DriveCycle            = get_param('Run_Simulator/Inputs','DriveCyc');
DriveCycle            = 'EnEC_US06City.mat'
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
EC_Cd_US06C_km = ess_wh_per_km(x)*0.14; 
%Weighted Charge Deplition Energy Consumption in Wh/Km
EC_Cd_US06C_mi = ess_wh_per_km(x)*0.14/1.6; 

%We calculate the diffrence between the Cd range and the total range.
%This diffrence value is then divided by the fuel consumption value.

% Calculating the Cd range
Cd_range_mi = distance_miles_hist(x); %in miles
Cd_range_km = distance_miles_hist(x)*1.6; %in Km

%Total range
total_range_mi_US06C = distance_miles_hist(x); %in miles
total_range_km_US06C = distance_miles_hist(x)*1.6; %in Km

% Calculating the Cs range
Cs_range_mi = total_range_mi_US06C - Cd_range_mi; %in miles
Cs_range_km = total_range_km_US06C - Cd_range_km; %in Km

%value of the engine fuel consumption
FC = eng_wh_per_mile_hist(z);

%Weighted Charge Sustaining Energy Consumption in Wh/mi
EC_Cs_US06C_mi = FC*0.14;
%Weighted Charge Sustaining Energy Consumption in Wh/Km
EC_Cs_US06C_km = (FC/1.6)*0.14;

clearvars -except EC_Cd_505_mi EC_Cd_505_km EC_Cs_505_mi EC_Cs_505_km...
    EC_Cd_HWFET_mi EC_Cd_HWFET_km EC_Cs_HWFET_mi EC_Cs_HWFET_km...
    EC_Cs_US06C_mi EC_Cs_US06C_km EC_Cd_US06C_mi EC_Cd_US06C_km...
    total_range_mi_505 total_range_km_505 total_range_mi_HWFET...
    total_range_km_HWFET total_range_mi_US06C total_range_km_US06C

% Running The EnEC_US06Hwy Drive cycle for calculating the VTS

clc
open Run_Simulator.slx;

%DriveCycle            = get_param('Run_Simulator/Inputs','DriveCyc');
DriveCycle            = 'EnEC_US06Hwy.mat'
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
EC_Cd_US06H_km = ess_wh_per_km(x)*0.45; 
%Weighted Charge Deplition Energy Consumption in Wh/Km
EC_Cd_US06H_mi = ess_wh_per_km(x)*0.45/1.6; 

%We calculate the diffrence between the Cd range and the total range.
%This diffrence value is then divided by the fuel consumption value.

% Calculating the Cd range
Cd_range_mi = distance_miles_hist(x); %in miles
Cd_range_km = distance_miles_hist(x)*1.6; %in Km

%Total range
total_range_mi_US06H = distance_miles_hist(x); %in miles
total_range_km_US06H = distance_miles_hist(x)*1.6; %in Km

% Calculating the Cs range
Cs_range_mi = total_range_mi_US06H - Cd_range_mi; %in miles
Cs_range_km = total_range_km_US06H - Cd_range_km; %in Km

%value of the engine fuel consumption
FC = eng_wh_per_mile_hist(z);

%Weighted Charge Sustaining Energy Consumption in Wh/mi
EC_Cs_US06H_mi = FC*0.45;
%Weighted Charge Sustaining Energy Consumption in Wh/Km
EC_Cs_US06H_km = (FC/1.6)*0.45;

clearvars -except EC_Cd_505_mi EC_Cd_505_km EC_Cs_505_mi EC_Cs_505_km...
    EC_Cd_HWFET_mi EC_Cd_HWFET_km EC_Cs_HWFET_mi EC_Cs_HWFET_km...
    EC_Cs_US06C_mi EC_Cs_US06C_km EC_Cd_US06C_mi EC_Cd_US06C_km...
    EC_Cd_US06H_mi EC_Cd_US06H_km EC_Cs_US06H_mi EC_Cs_US06H_km...
    total_range_mi_505 total_range_km_505 total_range_mi_HWFET...
    total_range_km_HWFET total_range_mi_US06C total_range_km_US06C...
    total_range_mi_US06H total_range_km_US06H

%Finding VTS parameter values of all the drive cycles

%Required Parameters
ess.plant.initial_soc = str2num(get_param('Run_Simulator/Inputs','init_soc')); % Maximum battery SOC
ess.plant.cd_soc_min  = str2num(get_param('Run_Simulator/Inputs','cd_soc_min')); % Minimum Battery SOC for transition to fuel
ess.plant.cs_soc_max  = str2num(get_param('Run_Simulator/Inputs','cs_soc_max')); % Maximum Battery SOC when charging on fule
ess.plant.cs_soc_min  = str2num(get_param('Run_Simulator/Inputs','cs_soc_min')); % Minimum Battery SOC when discharging on fule
veh.init.mass         = str2num(get_param('Run_Simulator/Inputs','veh_mass')); % Mass of vehicle
Tamb                  = str2num(get_param('Run_Simulator/Inputs','Tamb')); % Ambient Temperature of operation
% ResFileName           = get_param('Run_Simulator/Inputs','ResFileName'); % File name where results are stored

%Total Range (VTS 7)
total_range_mi = (total_range_mi_505*0.29 + total_range_mi_HWFET*0.12 + total_range_mi_US06C*0.14 + total_range_mi_US06H*0.45);
total_range_km = (total_range_km_505*0.29 + total_range_km_HWFET*0.12 + total_range_km_US06C*0.14 + total_range_km_US06H*0.45);

% Weighted Cd Energy Consumption Consumption (VTS 9)
weighted_Cd_EC_mi = EC_Cd_505_mi + EC_Cd_HWFET_mi + EC_Cd_US06C_mi + EC_Cd_US06H_mi;
weighted_Cd_EC_km = EC_Cd_505_km + EC_Cd_HWFET_km + EC_Cd_US06C_km + EC_Cd_US06H_km;


% Weighted Cs Fuel Consumption (VTS 10)
weighted_Cs_FC_mi = EC_Cs_505_mi + EC_Cs_HWFET_mi + EC_Cs_US06C_mi + EC_Cs_US06H_mi;
weighted_Cs_FC_km = EC_Cs_505_km + EC_Cs_HWFET_km + EC_Cs_US06C_km + EC_Cs_US06H_km;

%Pack Energy Wh
min_batt_energy = 7250;
nom_batt_energy = 9700;
max_batt_energy = 10700;

% charge used in Cd mode
charge_used = (ess.plant.initial_soc - ess.plant.cs_soc_min)/100; %in decimal

%pack energy available for use
energy_available = charge_used*nom_batt_energy;


%Cd mode Range (VTS 8)

Cd_range_mi = energy_available/weighted_Cd_EC_mi;
Cd_range_km = energy_available/weighted_Cd_EC_km;


% Calculating the Utility Factor
Dn = 399.9;
al = zeros(6,1);
C = [-10.52,7.28,26.37,-79.08,77.36,-26.07];
for n = 1:6
    al(n) = (C(n)*(Cd_range_mi/Dn)^n);
end
 a = sum(al);
UF = 1 - exp(a); %utility Factor

%Uf weighted fuel consumption (VTS 11)
UF_weighted_Cs_FC_km = weighted_Cs_FC_km*(1-UF);

%UF weighted Battery Consumption (VTS 12)
UF_weighted_Cd_FC_km = (weighted_Cd_EC_km*UF)/0.93;

%UF weighted Total energy consumption (VTS 13)
UF_total_EC = UF_weighted_Cs_FC_km + UF_weighted_Cd_FC_km;

%total energy in mpg (VTS 14)
UF_total_EC_mpg = 20715.22./UF_total_EC;

% ResFileName='Results_EnEC';
% ResFileName=['Results_',ResFileName,'.mat'];
% save(ResFileName);
% VTSFile='Results_VTS.mat';
% save(VTSFile,'VTS')
