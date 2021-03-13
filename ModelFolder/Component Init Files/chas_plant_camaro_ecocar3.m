%% File description
% Name : chas_plant_camaro_ecocar3					
% Author : Mathworks		                          				
% Description : Initialize the default midsize vehicle
%Proprietary : ecocar3
%Protected: false
% Model : chas_plant_veh_equation_losses
% Vehicle Type : Light

%% File content

veh_desc='Chevrolet Camaro 2016';
chas.plant.init.mass.body 				= 1365; %vehicle mass without powertrain
chas.plant.init.mass.epa_test           = 1817.3;
chas.plant.init.coeff_drag 				= 0.344;
chas.plant.init.cg_height      			= 0.5; % Vehicle CG height, (m) unknown
chas.plant.init.ratio_weight_front 	    = 0.64;%ratio of the weight to the front wheels
chas.plant.init.ratio_weight_rear   	= (1-chas.plant.init.ratio_weight_front);
chas.plant.init.mass.cargo 			= 0;
chas.plant.init.axle_base   			= 105.1*2.54/100;                 % Vehicle wheel base, (m) 
chas.plant.init.height                  = 57.1*2.54/100;                   % Vehicle height from website in (inches) converted to (meters)       
chas.plant.init.trackwidth              = 61.1*2.54/100;                   % (Front Tack width) in inches converted to meters
chas.plant.init.frontal_area            = 2.222; %Equation from website pdf document http://www.performancetrends.com/PDFs/DRAMan4.pdf
chas.plant.init.area_drag = chas.plant.init.coeff_drag *chas.plant.init.frontal_area; %[m2] Drag area of the vehicle, product of Cd (drag coefficient) and A (Frontal area)
