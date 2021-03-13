%% File description
% Name : tc_plant_torqconv_6L45					
% Author : A.Rousseau - ANL		                          				
% Description : Initialize the parameters used in the torque converter
% model for engines over 150Nm torque

%Proprietary : EcoCAR3
%Protected: false
															
% Vehicle Type : Light

%% File content


tc.plant.init.spd_idle 			= 0;				% starting engine speed set to 0 or fc_spd_idle
tc.plant.init.lock_thresh 		= 40.0; 			% [rad/s] spd difference < thresh enables lock up
tc.plant.init.inertia_in 		= 0.08; 			% factor of 20 introduced to conform to data provided by Joe Steiber 
tc.plant.init.inertia_out 		= 0.025; 			% same as above
tc.plant.init.pump_spd_thresh 	= 10;
tc.plant.init.mass.total               = 25; 

tc.plant.init.diameter = 0.220; %For cost model. Diameter in meters.

% load steady-state test data for 150K
tc.plant.init.spd_ratio = [0 0.1 0.2 0.3 0.4 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.82 0.84 0.86 0.88 0.893 0.9 0.92 0.94 0.95 0.97];	% Speed ratio
tc.plant.init.trq_ratio = [1.995	1.881	1.772	1.654	1.532	1.417	1.365	1.313	1.262	1.212	1.158	1.103	1.082	1.059	1.036	1.014	1	1	1	1	1	1]; % Torque ratio

tc.plant.init.k_factor.idx1_spd_ratio  = tc.plant.init.spd_ratio;
tc.plant.init.k_factor.map           = [15.75299276	15.5936093	15.48333939	15.34982171	15.11818161	14.81501792	14.78978046	14.76464771	15.02068752	15.38071403	15.90483641	16.51242043	16.76165344	17.02366227	17.31991446	17.74256339	18.05368578	19.05344528	21.83040375	25.93583703	28.93846657	38.47477107];
% K=N/sqrt(T) %rad/s/(N*m)^0.5

%% Torque Converter Generic Lockup Map Calculation

% Torque converter lockup threshold  as a function of gear number
% and accelerator pedal demand. The threshold is vehicle speed in kph
cpl.ctrl.init.trqconv_lockup.idx2_gear = (1:max(gb.plant.init.ratio.idx1_gear));
cpl.ctrl.init.trqconv_lockup.idx1_lin_accel = [0	5	10	15	20	25	30	35	40	50	60	70	80	90	93	100	120];
cpl.ctrl.init.trqconv_lockup.map = 1.606*... 
    [37.286  42.268;
    37.286	42.268;
    37.286	42.268;
    37.286	47.86;
    37.286	55.929;
    39.761	65.25;
    44.743	74.572;
    49.725	86.98;
    56.54	105.623;
    71.454	124.266;
    83.893	124.266;
    83.893	124.266;
    83.893	124.266;
    83.893	124.266;
    83.893	124.266;
    83.893	124.266;
    83.893	124.266;]; %kph

cpl.ctrl.init.trqconv_lockup.map = [100*ones(length(cpl.ctrl.init.trqconv_lockup.idx1_lin_accel),length(cpl.ctrl.init.trqconv_lockup.idx2_gear)-2),cpl.ctrl.init.trqconv_lockup.map];

%Torque converter unlock threshold  as a function of gear number and accelerator
%pedal demand. The threshold is vehicle speed in kph.
cpl.ctrl.init.trqconv_unlock.idx2_gear =  (1:max(gb.plant.init.ratio.idx1_gear));
cpl.ctrl.init.trqconv_unlock.idx1_lin_accel = [0 5 10 15 20	25	30	35	40	50	60	70	80	90	93 100 120];
cpl.ctrl.init.trqconv_unlock.map = 1.606*...
    [34.169      36.033;
    34.169      36.033;
    34.169      36.033;
    34.169      36.033;
    34.169      36.033;
    34.169      36.033;
    34.169      36.033;
    34.169      36.033;
    34.169      39.150;
    34.169      46.607;
    42.268      62.133;
    54.065      77.659;
    72.708      77.659;
    109.352     77.659;
    152.23      77.659;
    152.23      77.659;
    152.23  	77.659;];

cpl.ctrl.init.trqconv_unlock.map = [50*ones(length(cpl.ctrl.init.trqconv_lockup.idx1_lin_accel),length(cpl.ctrl.init.trqconv_unlock.idx2_gear)-2),cpl.ctrl.init.trqconv_unlock.map];
