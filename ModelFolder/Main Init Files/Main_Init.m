% This is the main simulation Initiallization file 
% it calls all other inits and Cals
clc
mode=2;                                  %Enables SIL signals in variant subsystem
tloop=0.01;                             %Time step [sec]
WORKSPACE_DECIMATION=10;
air.init.specific_heat = 1006;          %Specific heat capacity of Air J/kg*C
max_vehicle_rad_air_flow=1.13;          %Max air flow of vehicle radiator in Kg/s

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
env.init.dens_air = 1.2;
env.init.gravity = 9.81;
env.init.T_ambiant = 25; %C


t_amb=25;                               %Ambient Temperature (degC)
g=9.81;                                 %Gravity [m/s^2]
rho=1.225;                              %Air Density [Kg/m^2]
eps=1e-6;                               %Very small number not a zero
%Conversions
gal2liter=3.785;                        %Gallons to liters 
rpm2radsec=2*pi/60;                     %Radians to seconds
mph2ms=1.6/3.6;                         %MPH to m/s
mph2kph=1.609;                          %MPH to KPH
max_vehicle_speed=200*mph2ms;           %Setting maximum vehicle speed to 200mph        
VDC2VAC=1/sqrt(2);
%Driver Gains
drv.p_gain=65;%35 %20
drv.i_gain=1;%9 %10
%
NextSpeedOffsetAhead=0.35;              % next speed offset (in seconds) to look ahead in speed trace
pedal_slew_rate=13000;                  % rate limiter so that APP/BPP can go from 0->100% in 0.3 sec or 100%->0% in 0.3 sec based on experimental data
drv.p_gain=50;                          % proportional gain based on current speed error
drv.p_next_gain=100;                    % proportional gain based on look ahead
drv.speed_gain=1.1;                     % gain times current speed (in m/s), used to reduce the amount of integral gain is needed, as more integral gain becomes more overshoot and more delay 
drv.i_gain=0.3;                         % integral gain 
drv.i_gain_windup_limiter=15;           % limit the integral gain, limited to 60% APP/BPP
drv.NoPedalDeadZone=1;                  % +/-1% deadband on pedal input to prevent toggle between APP & BPP
%drv.BPP.FrictionDeadPedal=20;          % no friction braking below 20%, only: engine/powertrain braking + coast regen

%%
%LoadDriveCycle                         %Load the chosen drive cycle

load(DriveCycle)

[d1,d2]=size(sch_cycle);
time=sch_cycle(:,1);
Speed=sch_cycle(:,2);
Grade_Per=sch_cycle(:,3);
KeyPosition=sch_cycle(:,4);
ShiftLeverPosition = sch_cycle(:,5);
BrkPdlOverride = sch_cycle(:,6);
OBC_Connected = sch_cycle(:,7);
CAN_Alive = sch_cycle(:,8);
CruiseControlEnable = sch_cycle(:,9);
ABSEnable = sch_cycle(:,10);
CD_RSwitch = sch_cycle(:,11);
CS_SSwitch = sch_cycle(:,12);
CS_FSwitch = sch_cycle(:,13);
if d2<14
    EVSE_Level=zeros(d1,1);
else
    EVSE_Level=sch_cycle(:,14);
end
if d2<15
    APP_Mismatch=zeros(d1,1);
else
    APP_Mismatch=sch_cycle(:,15);
end
if d2<16
    BrakeFault=zeros(d1,1);
else
    BrakeFault=sch_cycle(:,16);
end
if d2<17
    EngTrqMismatchType=zeros(d1,1);
else
    EngTrqMismatchType=sch_cycle(:,17);
end
if d2<18
    MotTrqMismatchType=zeros(d1,1);
else
    MotTrqMismatchType=sch_cycle(:,18);
end
if d2<19
    FuelCutoffFault=zeros(d1,1);
else
    FuelCutoffFault=sch_cycle(:,19);
end
if d2<20
    GFD=zeros(d1,1);
else
    GFD=sch_cycle(:,20);
end
if d2<21
    HVILFlt=zeros(d1,1);
else
    HVILFlt=sch_cycle(:,21);
end
if d2<22
    BCMNotRdy=zeros(d1,1);
else
    BCMNotRdy=sch_cycle(:,22);
end
if d2<23
    ContWeldOpen=zeros(d1,1);
else
    ContWeldOpen=sch_cycle(:,23);
end
if d2<24
    ContWeldClose=zeros(d1,1);
else
    ContWeldClose=sch_cycle(:,24);
end
if d2<25
    APM_Enable_Stuck=zeros(d1,1);
else
    APM_Enable_Stuck=sch_cycle(:,25);
end
if d2<26
    VehWakeStuck=zeros(d1,1);
else
    VehWakeStuck=sch_cycle(:,26);
end
if d2<27
    StartSOC=ess.plant.initial_soc;
else
    StartSOC=sch_cycle(1,27);
end
if d2<28
    ESSHighRes=zeros(d1,1);
else
    ESSHighRes=sch_cycle(:,28);
end
if d2<29
    APP1_OOR=zeros(d1,1);
else
    APP1_OOR=sch_cycle(:,29);
end
if d2<30
    APP2_OOR=zeros(d1,1);
else
    APP2_OOR=sch_cycle(:,30);
end
if d2<31
    MCUNotReady=zeros(d1,1);
else
    MCUNotReady=sch_cycle(:,31);
end
if d2<32
    MCUStuckOn=zeros(d1,1);
else
    MCUStuckOn=sch_cycle(:,32);
end
if d2<33
    MCUTempFault=zeros(d1,1);
else
    MCUTempFault=sch_cycle(:,33);
end
if d2<34
    MotorTempFault=zeros(d1,1);
else
    MotorTempFault=sch_cycle(:,34);
end
if d2<35
    ECM_LS_FAN_Fault=zeros(d1,1);
else
    ECM_LS_FAN_Fault=sch_cycle(:,35);
end
if d2<36
    Chg_Buffer_Fault=zeros(d1,1);
else
    Chg_Buffer_Fault=sch_cycle(:,36);
end
if d2<37
    MotorTrqCmd_Fault=zeros(d1,1);
else
    MotorTrqCmd_Fault=sch_cycle(:,37);
end
if d2<38
    APMLowVltLow_Fault=zeros(d1,1);
else
    APMLowVltLow_Fault=sch_cycle(:,38);
end
if d2<39
    APMLowVltHi_Fault=zeros(d1,1);
else
    APMLowVltHi_Fault=sch_cycle(:,39);
end
if d2<40
    APMHiVltInpCrnt_Fault=zeros (d1,1);
else
    APMHiVltInpCrnt_Fault=sch_cycle(:,40);
end
if d2<41
    APMLowVltOutCrnt_Fault=zeros(d1,1);
else
    APMLowVltOutCrnt_Fault=sch_cycle(:,41);
end
if d2<42
    OBCMaxInpVlt_Fault=zeros(d1,1);
else
    OBCMaxInpVlt_Fault=sch_cycle(:,42);
end
if d2<43
    OBCMaxOutVolt_Fault=zeros(d1,1);
else
    OBCMaxOutVolt_Fault=sch_cycle(:,43);
end
if d2<44
    OBCMinOutVolt_Fault=zeros(d1,1);
else
    OBCMinOutVolt_Fault=sch_cycle(:,44);
end
if d2<45
    OBCTemp_Fault=zeros(d1,1);
else
    OBCTemp_Fault=sch_cycle(:,45);
end
if d2<46
    EVSEVlt_Fault=zeros(d1,1);
else
    EVSEVlt_Fault=sch_cycle(:,46);
end

ess.plant.init.initial_soc=StartSOC;


Grade=rad2deg(atan(Grade_Per/100));
SinAlpha = sin(Grade);
CosAlpha = cos(Grade);
Grade_description=[num2str(mean(Grade_Per)) ' %'];
Cycle_End=time(end);
%Time=[0:0.01:time(end)]';

%%
%---Missing parameters
mot.plant.init.mcu_eff=0.8;
mot.plant.init.mcu_mass=30;
cal.Diag.ECM.EngTRQ_MSMCH=20;
eng.plant.eng_max_torque=240;
mot.plant.init.motor_mass=34.5;

CycleLength=d1;
SW_CS_ON=zeros(CycleLength,1);
SW_CS_ON(200:CycleLength)=1;
SW_Engine_ON=zeros(CycleLength,1);
SW_Engine_ON(200:CycleLength)=1;
RegenBrkDisable=zeros(CycleLength,1);
RegenBrkDisable(200:CycleLength)=1;

%%
%Call Components Initialization files

chas_plant_camaro_ecocar3
clutch_plant
dcdc_plant_800
eng_plant_LEA_E85
ESS_Bosch
fd_plant_327
gb_plant_8L45
Init_APM_GM_Voltec_2kW
%mot_plant_pm_IMG_old
mot_plant_pm_IMG
obc_plant
tc_plant_6L45
VehicleParams_10_19
whl_plant_0341_ecocar3
load('Variable.mat')
load('fuelcons.mat')
load('gear.mat')
load('throttle.mat')


