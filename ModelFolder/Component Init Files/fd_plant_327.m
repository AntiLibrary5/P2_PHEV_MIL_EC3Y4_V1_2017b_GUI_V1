

%Proprietary : public
%Protected: false


%% File description
% Name : fd_plant_325
% Author : A.Rousseau - ANL		    DN - fd=3.27 for Same Veh Spd (fd=0.73*3.8/0.64) 7/15/08                     				
% Description : Initialize the final drive
% Ratio = 3.27
% Model : fd_plant_map_trqloss_funTW																
% Vehicle Type : Light, Heavy

%% File content


fd.plant.init.ratio   			= 2.77; % will be optimized in scaling algorithm
fd.plant.init.inertia 			= 0;
fd.plant.init.mass.total				= 25;
fd.plant.init.spd_thresh   		= 10;

fd.plant.init.eff_trq.idx1_trq        = [0 5000];
fd.plant.init.eff_trq.idx2_spd        = [0 1500];
fd.plant.init.eff_trq.map          = ones(size(fd.plant.init.eff_trq.idx1_trq,2),size(fd.plant.init.eff_trq.idx2_spd,2)).* 0.97;

fd.plant.init.trq_loss.idx1_trq       = fd.plant.init.eff_trq.idx1_trq;
fd.plant.init.trq_loss.idx2_spd       = fd.plant.init.eff_trq.idx2_spd;
fd.plant.init.trq_loss.map         = zeros(length(fd.plant.init.trq_loss.idx1_trq), length(fd.plant.init.trq_loss.idx2_spd));

% create final drive loss tables
for count=1:size(fd.plant.init.trq_loss.idx1_trq,2)
   for count2=1:size(fd.plant.init.trq_loss.idx2_spd,2)
      fd.plant.init.trq_loss.map(count,count2) = (1-fd.plant.init.eff_trq.map(count,count2))*fd.plant.init.trq_loss.idx1_trq(count);	
   end
   clear count2
end
clear count

% calculate the maximum efficiency 
fd.plant.init.eff_max=max(max(fd.plant.init.eff_trq.map));
