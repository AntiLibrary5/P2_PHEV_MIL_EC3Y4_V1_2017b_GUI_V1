close;
%%
Optorq=[83.7900000000000	136.760000000000	140	152.010000000000	171.590000000000	185.900000000000	198.400000000000	197.360000000000	200.550000000000	202.260000000000	215.080000000000	204.810000000000	204.520000000000	208.100000000000	211.520000000000	210.560000000000	214.100000000000	213.470000000000	208.730000000000	208.430000000000	208.670000000000	231.210000000000	228.310000000000	225.330000000000	220.520000000000	211.210000000000	204.190000000000	151.770000000000];
Mintorq=0.25*[83.7900000000000	136.760000000000	140	152.010000000000	171.590000000000	185.900000000000	198.400000000000	197.360000000000	200.550000000000	202.260000000000	215.080000000000	204.810000000000	204.520000000000	208.100000000000	211.520000000000	210.560000000000	214.100000000000	213.470000000000	208.730000000000	208.430000000000	208.670000000000	231.210000000000	228.310000000000	225.330000000000	220.520000000000	211.210000000000	204.190000000000	151.770000000000];
Motspd=[600	800	1000	1200	1400	1600	1800	2000	2200	2400	2600	2800	3000	3200	3400	3600	3800	4000	4250	4500	4750	5000	5250	5500	5750	6000	6250	6500];
x_map=[800 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2100 2200 2300 2400 2500 2600 2700 2800 2900 3000 3100 3200 3300 3400 3500 3600 3700 3800 3900 4000 4100 4200 4300 4400 4500 4600 4700 4800 4900 5000 5100 5200 5300 5400 5500 5600 5700 5800 5900 6000 6100 6200 6300 6400 6500 6600 6700 6800 6900 7000];
y_map=[0 0 10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200 210 220 230 240 250 260 270 280 290 300 310 320 330 340 350 360 370 380 390 400];
eng_trq_max=1.35581795*[0 100 110 120 127.8 130.2 133.3 136.4 138.5 142.1 147 149.3 151.2 152.6 153.8 154.6 154.7 154.7 154.7 154.7 154.1 153.1 152.3 152.3 154.2 156.6 158.6 159.9 161.6 163.8 165.2 166.3 166.3 166.3 166.3 166.3 166.3 170.4 173.8 175.4 175.6 173.9 171.6 170.5 168.9 166.7 164.3 161.7 159.6 157.8 156.1 154.2 152.4 150.3 148.6 146.4 143.5 141.5 139.9 0 0 0];
eng.eff.idx1_spd = Engine.Engine.FuelFlow.SPEED; %1x63
eng.eff.idx2_trq = [10 Engine.Engine.FuelFlow.TQ(2:12)]; %1x12
eng.fuelflow = Engine.Engine.FuelFlow.FuelFlow; %63x12
spd = eng.eff.idx1_spd*2*pi/60;
trq = eng.eff.idx2_trq;
pwr_matrix = spd'*trq/1000; %kw
eng.BSFC = eng.fuelflow*3600./pwr_matrix;% 63x12

[C,h]= contour(eng.eff.idx1_spd,[eng.eff.idx2_trq(1:11) 250],eng.BSFC',200:25:600);
clabel(C,h)

xlabel('Engine Speed [RPM]','Fontsize',16,'fontweight','bold')
ylabel('Engine Torque [Nm]','Fontsize',16,'fontweight','bold')
title('BSFC [%]','Fontsize',16,'fontweight','bold');hold on
plot(x_map,eng_trq_max,'r','linewidth',3);
hold on
plot(x_map,eng_trq_min,'b','linewidth',3);
grid on
plot(Motspd,Optorq,'b','linewidth',3);
hold on
plot(motorSpd(10000:end),Eng_trq_out(10000:end));
x=EngOpts(:,1)';
y=EngOpts(:,2)';


plot(Eng_Spd(300:10:end),Eng_trq(300:10:end),'.')


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
        map_dens(cpt_x,cpt_y)=numel(idx_count)/numel(x)*5000;
    end
end


axis
grid on
hold on;
title('Hot Efficiency Map (Torque) - Density time','Fontsize',16,'fontweight','bold')

% Colors
cmap=colormap('hot');
cmap(1:end,:)=cmap(end:-1:1,:);
colormap(cmap);
color_bar_vals=[1:1:max(map_dens(:))+1];

% Density 
contourf(x_index,y_index,map_dens',color_bar_vals,'LineStyle','none');
grid on

legend('BSFC','WOT','Time Density')

plot(x,y,'b*');
