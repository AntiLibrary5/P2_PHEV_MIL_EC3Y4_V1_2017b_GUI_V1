%% File description
% Name : mot_plant_pm_25_50_prius					
% Author : F.Bourry - ANL		                          				
% Description : Initialize the permanent magnet electric motor of the IMG
% Toyota Prius
% Mobility - Continuous Power = 35kW, Peak Power = 71kW
% Data provided by Bosch extrapolated IMG map

%Proprietary : public
%Protected: false


% Model : mot_plant_map_Pelec_motor_inverter_separate_funTW_volt_in, mot_plant_map_Pelec_funTW_volt_in,mot_plant_map_Pelec_funTW_pwr_in
% Technology : pm																		
% Vehicle Type : Light, Heavy

%% File content

mcu.plant.init.trq_uprate               = 20000;  %Nm/sec
mcu.plant.init.trq_derate               = -20000;  %Nm/sec

mot.plant.init.trq_posmax = 365; %Nm
mot.plant.init.trq_negmax = -365;%Nm

mot.plant.init.time_response	    = 0.1; 
mot.plant.init.t_max_trq           = 2; % Time the motor can remain at max torque - estimated 
mot.plant.init.inertia 			= 0.0681;% kg-m^2 
mot.plant.init.mass.motor       = 34.5; %kg
mot.plant.init.specific_heat    = 200; %J/kg/K

% From Bosch extrapolated map:

mot.plant.init.motor.trq_max.idx1_spd       = [0 500 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6000 6500 7000];% RPM
mot.plant.init.motor.trq_max.map         = [337 330 325 315 300 295 243 208 175 156 132 125 100 80 50];  % N-m - overtorque ratio is estimated
mot.plant.init.motor.trq_max.points.trq  = max(mot.plant.init.motor.trq_max.map);

mot.plant.init.motor.trq_cont.idx1_spd      = mot.plant.init.motor.trq_max.idx1_spd;% RPM
mot.plant.init.motor.trq_cont.map        = [275 270 268.6 260.6 250 249 237 200 171.3 150.2 131.4 118.7 104 96.3 89.2];% N-m - overtorque ratio is estimated

mot.plant.init.regen.trq_max.idx1_spd       = [0 500 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6000 6500 7000];% RPM
mot.plant.init.regen.trq_max.map         = [-300 -275 -262 -250 -225 -200 -175 -165 -150 -125 -112 -100 -75 -50 -25];  % N-m - overtorque ratio is estimated

mot.plant.init.regen.trq_cont.idx1_spd      = mot.plant.init.motor.trq_max.idx1_spd;% RPM
mot.plant.init.regen.trq_cont.map        = [-272 -270.8 -270 -268.2 -253 -251.4 -249.5 -231.5 -213.7 -185 -159.8 -144.5 -132.7 -118.3 -104.3];% N-m - overtorque ratio is estimated

mot.plant.init.eff_trq.idx1_spd       = [0 500 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6000 6500 7000];
mot.plant.init.eff_trq.idx2_trq       = [0 50 100 150 200 250 300 350 400];
mot.plant.init.eff_trq.idx2_trq       = [-fliplr(mot.plant.init.eff_trq.idx2_trq(2:end)) 0 mot.plant.init.eff_trq.idx2_trq(2:end)];
mot.plant.init.eff_trq.map = ...
                                [60 62.1 58.7 61.7 58.6 69.5 63.3 60 60 60 60 60 60 60 60;
                                 60 77.7 86.6 91.1 90.4 90.4 90.1 89.8 88.7 87 85.3 84.8 84.1 83.4 60;
                                 60 79.5 85.6 88.9 90.7 91.3 91.3 91.3 90.9 91.1 85.1 85.1 85 60 60;
                                 60 78.7 84.4 86.9 89.2 90.3 90.9 90.4 85 85 85 60 60 60 60;
                                 60 71.8 83.4 84.7 87.4 88.3 86.9 84.2 85 60 60 60 60 60 60;
                                 60 67.8 81.2 82.8 85.6 85.5 85 60 60 60 60 60 60 60 60;
                                 60 63.5 74.3 60 60 60 60 60 60 60 60 60 60 60 60;
                                 60 60 60 60 60 60 60 60 60 60 60 60 60 60 60
                                 60 60 60 60 60 60 60 60 60 60 60 60 60 60 60]; %consider motor and inverter already
                             
mot.plant.init.eff_trq.map =   [flipud(mot.plant.init.eff_trq.map(2:end,:)); mot.plant.init.eff_trq.map];

mot.plant.init.moteff_trq.map = ...
    [60 60 60 60 60 60 60 60 60 60 60 60 60 60 60;
     60 60 60 60 60 60 60 60 60 60 60 60 60 60 60
     60 65 76 84 86 60 60 60 60 60 60 60 60 60 60
     60 65 76 84 86 60 60 60 60 60 60 60 60 60 60
     60 69 78 84 86 60 60 60 60 60 60 60 60 60 60
     60 69 81 84 86 60 60 60 60 60 60 60 60 60 60
     60 76 83 86 89 90 60 60 60 60 60 60 60 60 60
     60 78 84 88 89 90 92 60 60 60 60 60 60 60 60
     60 80 86 89 90 92 92 92 92 90 90 60 60 60 60
     60 82 88 90 90 92 92 92 92 92 60 60 60 60 60
     60 86 88 90 92 92 94 94 96 96 94 90 60 60 60
     60 86 88 90 92 92 92 94 96 96 94 92 90 60 60
     60 86 88 90 92 92 92 92 92 96 92 92 90 88 60
     60 86 88 90 92 92 92 92 92 92 92 92 90 88 60
     60 92 96 92 92 92 90 90 88 88 88 88 88 86 60];
 
mot.plant.init.geneff_trq.map = ... 
    [45 45 45 45 45 45 45 45 45 45 45 45 45 45 45
     45 69 73 82 87 90 92 60 60 60 60 60 60 60 45
     45 69 73 82 87 90 94 60 60 60 60 60 60 60 45
     45 69 78 81 90 90 88 94 60 60 60 60 60 60 45
     45 74 81 84 90 90 94 88 60 60 60 60 60 60 45
     45 76 81 86 90 90 92 92 94 60 60 60 60 60 45
     45 78 81 90 90 90 92 92 92 94 90 60 60 60 45
     45 78 82 88 90 90 92 92 92 94 94 90 60 60 45
     45 80 86 90 90 92 92 94 94 94 94 92 60 60 45
     45 86 88 90 92 94 94 94 94 94 94 94 94 94 45
     45 88 90 82 94 94 94 94 94 94 94 94 94 94 45
     45 88 90 94 94 94 94 94 94 94 94 94 94 94 45
     45 88 90 94 94 94 94 94 94 94 90 90 90 90 45
     45 92 92 94 94 92 92 92 92 90 88 88 86 86 45
     45 92 90 88 88 88 84 84 84 82 80 78 78 76 45];
 
 
%  contour(mot.plant.init.eff_trq.idx1_spd,mot.plant.init.eff_trq.idx2_trq,mot.plant.init.eff_trq.map);
%  hold on
%  plot(mot.plant.init.motor.trq_max.idx1_spd,mot.plant.init.motor.trq_max.map);
%  plot(mot.plant.init.motor.trq_cont.idx1_spd,mot.plant.init.motor.trq_cont.map);
%  plot(mot.plant.init.regen.trq_max.idx1_spd,mot.plant.init.regen.trq_max.map);
%  plot(mot.plant.init.regen.trq_cont.idx1_spd,mot.plant.init.regen.trq_cont.map);