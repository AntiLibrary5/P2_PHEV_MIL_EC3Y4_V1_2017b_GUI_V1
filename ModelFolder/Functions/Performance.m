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
%ResFileName='Results_IVM_to_60mph';
%ResFileName=['Results_',ResFileName,'.mat'];
%save(ResFileName);
VTSFile='Results/Results_ivmto60.mat';
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
 VTSFile=['Results/Results_50to70.mat'];
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
 VTSFile=['Results/Results_60to0.mat'];
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