%Automatic Plots for Test Data
%The MATLAB script should produce the following plots:
% close all
clc
% load(CmpDT1)
%Signal names
%        Vehicle_speed_1=VehSpdAvgDrvn;%km/hr
%        Engine_output_torque_feedback_1=EngActStdyStTorq;
%        Motor_output_torque_feedback_1=INV_OutputTorque;
%        Battery_state_of_charge_1=BMS_SOC;
%        Motor_temperature_1=INV_ElectricMachineTemperature;
%        Engine_coolant_temperature_1=EngCltTmp;
%         Inverter_temperature_1=INV_ElectricMachineTemperature;
% %        Inverter_coolant_Temp_1=INV_TempCoolant;
% 
%        HV_battery_max_cell_temperature_1=BMS_Temperatur;
%        HV_battery_voltage_1=BMS_IstSpannung;
%        HV_battery_current_1=BMS_IstStrom;
%        HV_charger_AC_side_current_1=NLG5_OC_ACT;
%        HV_charger_AC_side_voltage_1=NLG5_OV_ACT;
%        Engine_instantaneous_fuel_flow_1=InstFuelConsmpRate/3600;%l/sec
%        Engine_speed_1=EngSpd; 
%         Motor_speed_1=INV_Speed;
%        Brake_pedal_pos_1=BrkPdlPos;
%        Time_sec=Time;

% cd ..\
%----------------------------------
RptSgNm={'Vehicle_speed_1','Engine_output_torque_feedback_1', 'Motor_output_torque_feedback_1','Battery_state_of_charge_1',...
    'Motor_temperature_1','Engine_coolant_temperature_1','Inverter_temperature_1','Inverter_coolant_Temp_1',...
     'HV_battery_max_cell_temperature_1','HV_battery_voltage_1','HV_battery_current_1','HV_charger_AC_side_current_1',...
     'HV_charger_AC_side_voltage_1','Engine_instantaneous_fuel_flow_1','Engine_speed_1,Motor_speed_1','Brake_pedal_pos_1'};
N_rpt=size(RptSgNm,2);
BlkVal=zeros(length(Time_1),1);
for k=1:N_rpt
 if exist(RptSgNm{k})==0
            eval([RptSgNm{k},'=BlkVal;']);%km/hr
            disp([RptSgNm{k},' is lost for Report !!!'])
 end
end
%Plot 1 (Torque and SOC) :
figure('units','normalized','outerposition',[0 0 1 1])

figure(1)
figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,1,1)
plot(Vehicle_speed_1)
hold on
plot(Battery_state_of_charge_1)
xlabel('Time(sec)')
title('Torque and SOC','FontAngle','italic')
legend('Vehicle Speed [kph]','Battery state of charge [%]')
subplot(2,1,2)
plot(Engine_output_torque_feedback_1)
hold on
plot(Motor_output_torque_feedback_1)
xlabel('Time(sec)')
legend('Engine output torque feedback [Nm]','Motor output torque feedback [Nm]')
savefig('Torque and SOC.fig')
%-----------------
fig=Figure();
 fig.Snapshot.Caption = 'Torque and SOC';
fig.Snapshot.Height = picsize;
add(rpt,fig);
%Plot 2 Temperature
figure('units','normalized','outerposition',[0 0 1 1])

figure(2)
figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,1,1)
plot(Vehicle_speed_1)
xlabel('Time(sec)')
title('Temperature','FontAngle','italic')
legend('Vehicle Speed [kph]')
subplot(3,1,2)
plot(Motor_temperature_1)
hold on
plot(Engine_coolant_temperature_1)
plot(Inverter_temperature_1)
plot(Inverter_coolant_Temp_1)
xlabel('Time(sec)'),ylabel('Degree Celcius')
legend('Motor temperature [Degree Celsius]','Engine coolant temperature [Degree Celsius]'...
    ,'Inverter Temperature [Degree Celusius]')
subplot(3,1,3)
plot(HV_battery_max_cell_temperature_1)
xlabel('Time(sec)')
legend('HV battery max cell temperature [Degree Celsius]')
savefig('Temperature.fig')
%--------
fig=Figure();
 fig.Snapshot.Caption = 'Temperature';
fig.Snapshot.Height = picsize;
add(rpt,fig);
% Plot 3 (ESS Behavior vs Time) :
figure('units','normalized','outerposition',[0 0 1 1])

figure(3)
subplot(4,1,1)
plot(HV_battery_voltage_1)
xlabel('Time(sec)')
title('ESS Behaviour vs Time','FontAngle','italic')
legend('HV battery voltage [V]')
subplot(4,1,2)
plot(Battery_state_of_charge_1)
xlabel('Time(sec)')
legend('Battery state of charge [%]')
subplot(4,1,3)
plot(HV_charger_AC_side_current_1)
xlabel('Time(sec)')
legend('HV charger AC side current [Amp]')
subplot(4,1,4)
plot(HV_charger_AC_side_voltage_1)
xlabel('Time(sec)')
legend('HV charger AC side voltage [V]')
savefig('ESS Behavior vs Time.fig')

fig=Figure();
fig.Snapshot.Caption = 'ESS Behaviour vs Time';
fig.Snapshot.Height = picsize;
add(rpt,fig);
% Plot 4 (Fuel Energy Consumption vs Time) :
figure('units','normalized','outerposition',[0 0 1 1])

figure(4)
subplot(4,1,1)
plot(Vehicle_speed_1)
xlabel('Time(sec)')
title('Fuel Energy Consumption vs Time','FontAngle','italic')
legend('Vehicle Speed [kph]')
subplot(4,1,2)
plot(Engine_instantaneous_fuel_flow_1)
xlabel('Time(sec)')
legend('Engine instantaneous fuel flow [l/sec]')
subplot(4,1,3)
plot(Engine_speed_1)
legend('Engine speed [rpm]')
subplot(4,1,4)
plot(Engine_output_torque_feedback_1)
xlabel('Time(sec)')
legend('Engine output torque feedback [Nm]')
savefig('Fuel Energy Consumption vs Time.fig')

fig=Figure();
fig.Snapshot.Caption = 'Fuel Energy Consumption vs Time';
fig.Snapshot.Height = picsize;
add(rpt,fig);
% Plot 5 (Electric Energy Consumption vs Time) :
figure('units','normalized','outerposition',[0 0 1 1])
figure(5)
subplot(2,1,1)
plot(HV_battery_voltage_1)
hold on
plot(HV_battery_current_1)
xlabel('Time(sec)')
title('Electric Energy Consumption vs Time','FontAngle','italic')
legend('HV battery voltage [V]','HV battery current [Amps]')
subplot(2,1,2)
plot(Battery_state_of_charge_1)
xlabel('Time(sec)')
legend('Battery state of charge [%]')
savefig('Electric Energy Consumption vs Time.fig')

fig=Figure();
fig.Snapshot.Caption = 'Electric Energy Consumption vs Time';
fig.Snapshot.Height = picsize;
add(rpt,fig);
% Plot 6 (Speed):
figure('units','normalized','outerposition',[0 0 1 1])

figure(6)
plot(Engine_speed_1)
hold on
plot(Motor_speed_1)
xlabel('Time(sec)')
title('Speed','FontAngle','italic')
legend('Engine speed [rpm]','Motor speed [rpm]')
savefig('Speed.fig')
fig=Figure();
fig.Snapshot.Caption = 'Speed';
fig.Snapshot.Height = picsize;
add(rpt,fig);
% Plot 7 (Regen):
figure('units','normalized','outerposition',[0 0 1 1])

figure(7)
plot(Engine_output_torque_feedback_1)
hold on
plot(Motor_output_torque_feedback_1)
plot(Brake_pedal_pos_1)
xlabel('Time(sec)')
legend('Engine output torque feedback [Nm]','Motor output torque feedback [Nm]')
savefig('Regen.fig')

fig=Figure();
fig.Snapshot.Caption = 'Regeneration';
fig.Snapshot.Height = picsize;
add(rpt,fig);
% close all
close(rpt);
movefile('*.fig',destfile)
copyfile('*.docx',destfile)
rptview(rpt);


