clc
addpath(genpath('ResultData'));
cd ResultData

%----------------------------
%required signals from test data
B={'Vehicle_speed_1','Engine_output_torque_feedback_1','Motor_output_torque_feedback_1','HV_battery_voltage_1','HV_battery_current_1',...
    'Battery_state_of_charge_1','Engine_coolant_temperature_1','Motor_temperature_1','HV_ESS_Max_Cell_Temperature_1',...
    'Transmission_In_Shaft_Speed_1','Transmission_Out_Shaft_Speed_1','Transmission_Estimated_Gear_1'};


% C={'Vehicle_speed_2','Engine_output_torque_feedback_2','Motor_output_torque_feedback_2','HV_battery_voltage_2','HV_battery_current_2',...
%     'Battery_state_of_charge_2','Engine_coolant_temperature_2','Motor_temperature_2','HV_battery_max_cell_temperature_2',...
%     'Transmission_In_Shaft_Speed_2','Transmission_Out_Shaft_Speed_2','Transmission_Estimated_Gear_2'};
BlkVal=zeros(length(Time_1),1);
N_b=length(B);
for i=1:N_b
 if exist(B{i})==0
            eval([B{i},'=BlkVal;']);%km/hr
            disp([B{i},' is lost for Report !!!'])
 end
end
% N_c=length(C);
% for j=1:N_c
%  if exist(C{j})==0
%             eval([C{j},'=BlkVal;']);%km/hr
%             disp([C{j},' is lost for Report !!!'])
%  end
% end



% Plot 1 (Vehicle Speed):
figure('units','normalized','outerposition',[0 0 1 1])
figure(1)
eval(['plot(',B{1},')'])
% plot(s.(B{1}))
% hold on
% eval(['plot(',C{1},')'])
% plot(s.(C{1}))
xlabel('Time(sec)')
title('Vehicle Speed','FontAngle','italic')
legend('Vehicle Speed [kph]')
savefig('Vehicle Speed.fig')

% Plot 2 (Motor and Engine Torque)
figure('units','normalized','outerposition',[0 0 1 1])
figure(2)
subplot(2,1,1)
eval(['plot(',B{2},'-',B{3},')'])

% hold on
% eval(['plot(',C{2},')'])

xlabel('Time(sec)')
title('Motor and Engine Torque','FontAngle','italic')
legend('ICE torque feedback [Nm]')
subplot(2,1,2)
eval(['plot(',B{3},')'])

% hold on
% eval(['plot(',C{3},')'])

xlabel('Time(sec)')
legend('EM torque feedback  [Nm]')
savefig('WithClutch_Clutchless_Motor and Engine Torque.fig')

% Plot 3 (ESS)
figure('units','normalized','outerposition',[0 0 1 1])
figure(3)
subplot(3,1,1)
eval(['plot(',B{4},')'])

% hold on
% eval(['plot(',C{4},')'])

xlabel('Time(sec)')
title('ESS','FontAngle','italic')
legend('ESS Voltage [V]')
subplot(3,1,2)
eval(['plot(',B{5},')'])



xlabel('Time(sec)')
legend('ESS Current [Amp]')
subplot(3,1,3)
eval(['plot(',B{6},')'])

% hold on
% eval(['plot(',C{6},')'])

xlabel('Time(sec)')
legend('ESS SOC [%]')
savefig('WithClutch_Clutchless_ESS.fig')

% Plot 4 (Temperatures)
figure('units','normalized','outerposition',[0 0 1 1])
figure(4)
subplot(3,1,1)
eval(['plot(',B{7},')'])

% hold on
% eval(['plot(',C{7},')'])

xlabel('Time(sec)')
title('Temperatures','FontAngle','italic')
legend('ICE Temperature  (deg C)')
subplot(3,1,2)
eval(['plot(',B{8},')'])

% hold on
% eval(['plot(',C{8},')'])

xlabel('Time(sec)')
legend('EM Temperature (deg C)')
subplot(3,1,3)
eval(['plot(',B{9},')'])

% hold on
% eval(['plot(',C{9},')'])

xlabel('Time(sec)')
legend('ESS Temperature (deg C)')
savefig('WithClutch_Clutchless_Temperatures.fig')

% Plot 5 (Transmission Operation)
figure('units','normalized','outerposition',[0 0 1 1])
figure(5)
subplot(3,1,1)
eval(['plot(',B{10},')'])

% hold on
% eval(['plot(',C{10},')'])

xlabel('Time(sec)')
title('Transmission Operation','FontAngle','italic')
legend('Transmission Input Shaft Speed (rpm)')
subplot(3,1,2)
eval(['plot(',B{11},')'])

% hold on
% eval(['plot(',C{11},')'])

xlabel('Time(sec)')
legend('Transmission Output Shaft Speed  (rpm)')
subplot(3,1,3)
eval(['plot(',B{12},')'])

% hold on
% eval(['plot(',C{12},')'])

xlabel('Time(sec)')
legend('Transmission Estimated Gear')
savefig('WithClutch_Clutchless_Transmission Operation.fig')


fig2png
cd ..\




    