% This is the DC-DC converter Initialization file. 
% It loads all the DC-DC converter specs necessary 
% for the simulation

APM_desc='GM Voltec';

APM.plant.init.MinHV=260;               %Minimum Operating HV [V] 
%APM.plant.init.accload=800;            %12V Accessory loads [W]
APM.plant.init.accload=1020;            %12V Accessory loads [W], this 1020 W will end up being 1,150 W on average after conversion efficiencies
APM.plant.init.RatedLoad=2200;          %Max unit load [W]
APM.plant.init.SLI_NoCharge_Voltage=12; %SLI voltage when APM is off [V]
APM.plant.init.mass=5.5;                %Mass [kg]
APM.plant.init.specific_heat=900;       %Aluminum Specific Heat [J/kg/K]
APMBlwr.plant.init.max_speed=6000;          %Blower max RPM
APMBlwr.plant.init.max_heat_rejection=300;  %Blower max heat rejection [W]
%APM Efficiency Load vector [W]
APM.plant.init.EffLoadIdx=...
    [0.1  0.2  0.3  0.4  0.5  0.6  0.7  0.8  0.9  1.0]...
    *APM.plant.init.RatedLoad;
%APM Efficiency based on GM PCE002 Efficiency Requirement
APM.plant.init.Efficiency=...
    [0.65 0.85 0.89 0.90 0.90 0.90 0.89 0.88 0.87 0.87]; 
%APM Diagnostic Limits
APM.LV_Under_Voltage_Out= 9;  %[V]
APM.LV_Over_Voltage_Out= 16;  %[V]
APM.LV_Over_Current_Out= 125; %[A]
APM.HV_Over_Current_In= 41;   %[A]

APM_desc=[APM_desc ' Max Load:' num2str(APM.plant.init.RatedLoad/1000) ' kW'];
disp(['DCDC Converter: ' APM_desc]);
