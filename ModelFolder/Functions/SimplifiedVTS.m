%%%%%%VTS Calculator%%%%%%
%% IVM to 60 mph acceleration time calculation
clear;
clc;
%DriveCycle            = get_param('Run_Simulator/Inputs','DriveCyc');
DriveCycle            = 'IVM_to_60mph.mat'
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
disp('Running Drive Cycle: IVM_to_60mph')
disp('Please Wait......')

sim  P2_Parallel_MIL_withTrailer.slx

DcyStart = find(veh_dist_meter_hist*3.28084>=1,1);
TimeStart = Time(DcyStart);
DcyEnd = find(veh_spd_mph_hist>60,1);
TimeEnd = Time(DcyEnd);
TimeCyc_IVMto60 = (TimeEnd - TimeStart);
%TimeCyc_IVMto60=(DcyEnd-DcyStart)/WORKSPACE_DECIMATION;
% save('Results/Results_IVM_to_60mph.mat','TimeCyc_IVMto60','-append')
ResFileName='Results_IVM_to_60mph';
 ResFileName=['Results/',ResFileName,'.mat'];
 save(ResFileName);
 VTSFile=['Results/Perf.mat'];
save(VTSFile,'TimeCyc_IVMto60')
%% 2. 50 to 70 mph acceleration time calculation
clear;
clc;

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
ResFileName='Results_TimeCyc_50to70';
 ResFileName=['Results/',ResFileName,'.mat'];
 save(ResFileName);
 VTSFile=['Results/Perf.mat'];
save(VTSFile,'TimeCyc_50to70')
%% 3. 60 to 0 mph breaking distance calculation
clear;
clc;

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
ResFileName='Results_BrakingCyc_60to0';
 ResFileName=['Results/',ResFileName,'.mat'];
 save(ResFileName);
 VTSFile=['Results/Perf.mat'];
save(VTSFile,'DistCyc_60to0')
%% 4. Highway Gradeability,@20 min, 60mph
clear;
clc;

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

%% 5. Total Vehicle Range Calculation
clear;
clc;

%for 505.mat drive cycle

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
%open SIL_Model.slx
disp(' ')
disp('Running Drive Cycle: EnEC_505')
disp('Please Wait......')
sim  P2_Parallel_MIL_withTrailer.slx
%-----
eng_fule_comsump_gal=(distance_miles_hist./eng_fuel_consump_mpl)*0.264172;
eng_fule_comsump_gal(isinf(eng_fule_comsump_gal)) = 0;
DcyEnd = find(eng_fule_comsump_gal>=9,1);
VTS_505_mile=distance_miles_hist(round(DcyEnd));


%for HwFET.mat drive cycle

%DriveCycle            = get_param('Run_Simulator/Inputs','DriveCyc');
DriveCycle            = 'EnEC_HwFET.mat'
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
disp('Running Drive Cycle: EnEC_HwFET')
disp('Please Wait......')
sim  P2_Parallel_MIL_withTrailer.slx

eng_fule_comsump_gal=(distance_miles_hist./eng_fuel_consump_mpl)*0.264172;
eng_fule_comsump_gal(isinf(eng_fule_comsump_gal)) = 0;
DcyEnd = find(eng_fule_comsump_gal>=9,1);
VTS_HwFET_mile=distance_miles_hist(round(DcyEnd));


%for US06City.mat drive cycle

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
%open SIL_Model.slx
disp(' ')
disp('Running Drive Cycle: EnEC_US06City')
disp('Please Wait......')
sim  P2_Parallel_MIL_withTrailer.slx
eng_fule_comsump_gal=(distance_miles_hist./eng_fuel_consump_mpl)*0.264172;
eng_fule_comsump_gal(isinf(eng_fule_comsump_gal)) = 0;
DcyEnd = find(eng_fule_comsump_gal>=9,1);
VTS_US06City_mile=distance_miles_hist(round(DcyEnd));

%for US06Hwy.mat drive cycle

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
%open SIL_Model.slx
disp(' ')
disp('Running Drive Cycle: EnECUS06Hwy')
disp('Please Wait......')
sim  P2_Parallel_MIL_withTrailer.slx
eng_fule_comsump_gal=(distance_miles_hist./eng_fuel_consump_mpl)*0.264172;
eng_fule_comsump_gal(isinf(eng_fule_comsump_gal)) = 0;
DcyEnd = find(eng_fule_comsump_gal>=9,1);
VTS_US06Hwy_mile=distance_miles_hist(round(DcyEnd));
disp(' ')
disp('Calculating Total Vehicle Range')
disp('Please Wait......')
VTS_5_result=((VTS_505_mile*.29)+(VTS_HwFET_mile*.12)+(VTS_US06City_mile*.14)+(VTS_US06Hwy_mile*.45));

fprintf('The total vehicle range is : %.2f miles.\n', VTS_5_result);

ResFileName='Results_Total_Range';
 ResFileName=['Results/',ResFileName,'.mat'];
 save(ResFileName);
 VTSFile=['Results/EnEC.mat'];
save(VTSFile,'VTS_5_result')
%% 6. CD Mode Range Calculation
clear;
clc;

%for 505.mat drive cycle

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
%open SIL_Model.slx
sim  P2_Parallel_MIL_withTrailer.slx
SOC_Range=ess.plant.init.initial_soc-ess.plant.cs_soc_min;
CD_End = find(BMS_SOC_hist<=(ess.plant.cs_soc_min/100),1);
EC_CD_505=-1*ess_wh_per_km(CD_End);

%for HwFET.mat drive cycle

%DriveCycle            = get_param('Run_Simulator/Inputs','DriveCyc');
DriveCycle            = 'EnEC_HwFET.mat'
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
sim  P2_Parallel_MIL_withTrailer.slx
SOC_Range=ess.plant.init.initial_soc-ess.plant.cs_soc_min;
CD_End = find(BMS_SOC_hist<=(ess.plant.cs_soc_min/100),1);
EC_CD_HwFET=-1*ess_wh_per_km(CD_End);

%for US06City.mat drive cycle

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
%open SIL_Model.slx
sim  P2_Parallel_MIL_withTrailer.slx
SOC_Range=ess.plant.init.initial_soc-ess.plant.cs_soc_min;
CD_End = find(BMS_SOC_hist<=(ess.plant.cs_soc_min/100),1);
EC_CD_US06City=-1*ess_wh_per_km(CD_End);


%for US06Hwy.mat drive cycle

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
%open SIL_Model.slx
sim  P2_Parallel_MIL_withTrailer.slx
SOC_Range=ess.plant.init.initial_soc-ess.plant.cs_soc_min;
CD_End = find(BMS_SOC_hist<=(ess.plant.cs_soc_min/100),1);
EC_CD_US06Hwy=-1*ess_wh_per_km(CD_End);

% weighted electric energy consumption
EC_weighted=(EC_CD_505*.29+EC_CD_HwFET*.12+EC_CD_US06City*.14+EC_CD_US06Hwy*.45)*1.60934;
Batt_max=ess.plant.init.initial_soc/100*31*4.115*104;
E_avail=SOC_Range/100*Batt_max;
VTS_CD_mile=E_avail/EC_weighted;
fprintf('The CD range is : %.2f miles.\n', VTS_CD_mile);

ResFileName='Results_CD_Range';
 ResFileName=['Results/',ResFileName,'.mat'];
 save(ResFileName);
 VTSFile=['Results/EnEC.mat'];
save(VTSFile,'VTS_CD_mile')
%% 7. CD Mode Total Energy Consumption Calculation
clear;
clc;

%for 505.mat drive cycle

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
%open SIL_Model.slx
sim  P2_Parallel_MIL_withTrailer.slx

syms VTS_7_505_total_steps VTS_7_505_stop_step VTS_7_505_result;

VTS_7_505_total_steps= Cycle_End*10+1;

for n=1:1:VTS_7_505_total_steps
    if(ess_soc_percent_hist(n)<18)
        VTS_7_505_stop_step=n-1;
        break;
    else
        continue;
    end
end

VTS_7_505_result=ess_wh_per_km(VTS_7_505_stop_step);


%for HwFET.mat drive cycle

%DriveCycle            = get_param('Run_Simulator/Inputs','DriveCyc');
DriveCycle            = 'EnEC_HwFET.mat'
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
sim  P2_Parallel_MIL_withTrailer.slx

syms VTS_7_HwFET_total_steps VTS_7_HwFET_stop_step VTS_7_HwFET_result;

VTS_7_HwFET_total_steps= Cycle_End*10+1;

for n=1:1:VTS_7_HwFET_total_steps
    if(ess_soc_percent_hist(n)<18)
        VTS_7_HwFET_stop_step=n-1;
        break;
    else
        continue;
    end
end

VTS_7_HwFET_result=ess_wh_per_km(VTS_7_HwFET_stop_step);


%for US06City.mat drive cycle

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
%open SIL_Model.slx
sim  P2_Parallel_MIL_withTrailer.slx

syms VTS_7_US06City_total_steps VTS_7_US06City_stop_step VTS_7_US06City_result;

VTS_7_US06City_total_steps= Cycle_End*10+1;

for n=1:1:VTS_7_US06City_total_steps
    if(ess_soc_percent_hist(n)<18)
        VTS_7_US06City_stop_step=n-1;
        break;
    else
        continue;
    end
end

VTS_7_US06City_result=ess_wh_per_km(VTS_7_US06City_stop_step);


%for US06Hwy.mat drive cycle

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
%open SIL_Model.slx
sim  P2_Parallel_MIL_withTrailer.slx

syms VTS_7_US06Hwy_total_steps VTS_7_US06Hwy_stop_step VTS_7_US06Hwy_result;

VTS_7_US06Hwy_total_steps= Cycle_End*10+1;

for n=1:1:VTS_7_US06Hwy_total_steps
    if(ess_soc_percent_hist(n)<18)
        VTS_7_US06Hwy_stop_step=n-1;
        break;
    else
        continue;
    end
end

VTS_7_US06Hwy_result=ess_wh_per_km(VTS_7_US06Hwy_stop_step);

VTS_7_result=(VTS_7_505_result*.29)+(VTS_7_HwFET_result*.12)+(VTS_7_US06City_result*.14)+(VTS_7_US06Hwy_result*.45);

fprintf('The CD Mode Total Energy Consumption is : %.2f Wh per km.\n', VTS_7_result);

