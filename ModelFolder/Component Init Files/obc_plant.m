% This is the On Board Charger Initialization file. 
% It loads all the Brusa charger specs necessary 
% for the simulation

OBC_desc='Brusa';

obc.plant.init.OutputPower = 3300;%Watts
obc.plant.init.Level1ChargerVoltage=110;    %Level 1 Voltage [VAC]
obc.plant.init.Level2ChargerVoltage=220;    %Level 2 Voltage [VAC]
obc.Minimum_Voltage_In = 100; %Volts
obc.Maximum_Voltage_In = 264; %Volts
obc.plant.init.Maximum_Current_Out = 12.5; %Maximum current out to battery in Amperes
obc.plant.init.Minimum_Voltage_Out = 200; %Volts
obc.plant.init.Maximum_Voltage_Out = 520; %Volts
obc.NLG5_ERR = 0; %Error signal
obc.Maximum_Power_In=3680; % in watts
obc.plant.init.Maximum_Mains_Current=16; %Maximum Allowed Current Draw on Mains
obc.ac_to_dc_conv_factor =0.707;
obc.plant.init.avergae_efficiency=0.93;
obc.plant.init.mass=6.2;    %Mass [kg]
obc.plant.init.specific_heat=900;       %Aluminum Specific Heat [J/kg/K]


%voltage and current from respective mains outlets
obc.US_Mains_voltage_I = 120; 
obc.US_Mains_voltage_II = 240;
obc.US_Mains_curent_I = 12;
obc.Us_Mains_current_II = 32;
obc.EUR_Mains_Voltage = 230;

%temperature info for OBC in deg C
obc.power_stage_temp=60;
obc.temp_extern_1_temp=60;
obc.temp_extern_2_temp=60;
obc.temp_extern_3_temp=60;

%OBC Diagnostic Limits
obc.Over_Voltage_In=251;
obc.Over_Voltage_Out=700;
obc.Under_Voltage_Out=0;

OBC_desc=[OBC_desc ' Max Load:' num2str(obc.plant.init.OutputPower/1000) ' kW'];
disp(['On-Board Charger: ' OBC_desc]);
