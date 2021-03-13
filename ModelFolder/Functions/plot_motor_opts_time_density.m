close;

mot.plant.init.motor.trq_max.idx1_spd       = [0 500 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6000 6500 7000];% RPM
mot.plant.init.motor.trq_max.map         = [301.9 301.9 301.2 300 298.3 260.1 209.7 175.2 150.9 132.9 119.2 105.9 96.07 87.81 60];  % N-m - overtorque ratio is estimated

[C,h]= contour(mot.plant.init.eff_trq.idx1_spd,mot.plant.init.eff_trq.idx2_trq,mot.plant.init.eff_trq.map,60:5:95);
clabel(C,h)

xlabel('Motor Speed [RPM]','Fontsize',16,'fontweight','bold')
ylabel('Motor Torque [Nm]','Fontsize',16,'fontweight','bold')
title('Eff [%]','Fontsize',16,'fontweight','bold');hold on
plot(mot.plant.init.motor.trq_max.idx1_spd,mot.plant.init.motor.trq_max.map,'r','linewidth',3);

grid on

x=MotOpts(:,1)';
x = x*30/pi;
y=MotOpts(:,2)';

% Create grid
N_x=20;
N_y=20;
x_index=linspace(min(x),max(x),N_x);
y_index=linspace(min(y),max(y),N_y);

x_radius=(x_index(2)-x_index(1))/2;
y_radius=(y_index(2)-y_index(1))/2;
clear map_dens
for cpt_x=1:N_x
    for cpt_y=1:N_y
        idx_count=find((x>=(x_index(cpt_x)-x_radius)) & (x<(x_index(cpt_x)+x_radius))&(y>=(y_index(cpt_y)-y_radius)) & (y<(y_index(cpt_y)+y_radius)));
        map_dens(cpt_x,cpt_y)=numel(idx_count)/numel(x)*500;
    end
end


axis
grid on
hold on;
title('Motor Efficiency Map (Torque) - Density time','Fontsize',16,'fontweight','bold')

% Colors
cmap=colormap('hot');
cmap(1:end,:)=cmap(end:-1:1,:);
colormap(cmap);
color_bar_vals=[0.1:0.1:max(map_dens(:))+0.1];

% Density 
contourf(x_index,y_index,map_dens',color_bar_vals,'LineStyle','none');
grid on
% 
% legend('Mot Eff','WOT','Time Density')
% plot(x,y,'b*')
