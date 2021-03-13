%% File description
% Name : whl_plant_0341_ecocar3					
% Author : V.Freyermuth (ANL)		                          				
% Description : Initialize the P235/55 R18 - based on Toyota litterature
% Used for the Rx400h
% Rolling resistance coefficients are estimated

%Proprietary : Public
%Protected: false


% Model : whl_plant_2wd,whl_plant_2wd_f0f1f2
% Vehicle Type : Light

%% File content



whl.plant.init.inertia_per_wheel   = 1.0;				% kg-m^2
whl.plant.init.inertia = whl.plant.init.inertia_per_wheel*4;
whl.plant.init.radius   			= 0.341;				    % m - (18/2*25.4+.55*235)*.96
whl.plant.init.mass.total_per_wheel 		= 25;				    % kg

whl.plant.init.spd_thresh       =1;% Parameter for the blending block used in rolling resistance calculation. 

% To convert brake command from driver into braking engine torque 
% The curve is nomalized from -1*[0 200 1400 1550 1650 1700 1760 1800 2000] which obtained from TTR

whl.plant.init.trq_brake_max    	= 4000;				    % N-m
whl.plant.init.trq_brake_mech.idx1_brake_cmd = [ 0 .05 0.25 0.3 0.35 0.4 0.5 0.6 1];
whl.plant.init.trq_brake_mech.map = -[0 0.1000 0.7000 0.7750 0.8250 0.8500 0.8800 0.9000 1.0000]*whl.plant.init.trq_brake_max;


% Rolling Resistance Coefficient as a polynomial function of speed.
% whl.plant.init.coeff_roll1 + whl.plant.init.coeff_roll2*w + whl.plant.init.coeff_roll3*w^2 + whl.plant.init.coeff_roll4*w^3    
whl.plant.init.coeff_roll1 = 0.0075;
whl.plant.init.coeff_roll2 = 0.00012; % default value from other tires
whl.plant.init.coeff_roll3 = 0;
whl.plant.init.coeff_roll4 = 0;




