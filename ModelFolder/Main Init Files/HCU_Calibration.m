% % $Author: eo1000 $
% $Rev: 514 $
% $Date: 2014-01-13 20:23:35 -0500 (Mon, 13 Jan 2014) $

%Battery limits
% cal.ess.min_CD_soc=38; %Minimum SOC to run CD
% cal.ess.max_CS_soc=39; %Maximum SOC to run CS

% ess.plant.max_cont_charge=[0    0    0    0    0    0    0    0    0    0    0;
%                                 6    6    6    6    6    6    6    6    6    6    0;
%                                 19.8 19.8 19.8 19.8 19.8 19.8 19.8 19.8 19.8 19.8 0;
%                                 30   30   30   30   30   30   30   30   30   30   0;
%                                 60   60   60   60   60   60   60   60   60   60   0;
%                                 60   60   60   60   60   60   60   60   60   60   0; 
%                                 60   60   60   60   60   60   60   60   60   60   0;
%                                  0   0    0    0    0    0    0    0    0    0    0]';
% ess.plant.limit.idx1_soc=[0 10 20 30 40 50 60 70 80 90 100]; 
% ess.plant.limit.idx2_temp=[-30 -20 -10 0 20 40 50 60];
% ESS diagnostics calibrations
% cal.ess.pack_min_V=262.5;
% cal.ess.pack_max_V=378;
% cal.ess.cell_min_V=2.5;                  % Min Cell V
% cal.ess.cell_max_V=3.6;                  % Max Cell V 
% cal.ess.coolant_max_temp=40;
% cal.ess.cell_max_temp=40;
% cal.ess.cell_min_temp=0;
% cal.ess.isolationmin=189; % 378*500/1000 kohm/V;

%APP Calibrations
%cal.APP1.low = 0.195;
%cal.APP1.high = 0.845;
%cal.APP2.low = 0.097;
%cal.APP2.high = 0.421;
cal.APP1.IN_Min = 0.2;
cal.APP1.IN_Max = 0.839;
cal.APP2.IN_Min = 0.1;
cal.APP2.IN_Max = 0.417;
cal.APP1.Recast_Min = 0.2192;
cal.APP1.Recast_Max = 0.9437;
cal.APP2.Recast_Min = 0.1086;
cal.APP2.Recast_Max = 0.47294;
cal.APP.Mismatch_Value = 8; %percentage
cal.APP.IN_Max_SC = 0.1;
cal.APP1.IN_Max_SC_Prcnt=(cal.APP.IN_Max_SC+cal.APP1.IN_Max)/cal.APP1.IN_Max*100;
cal.APP2.IN_Max_SC_Prcnt=(cal.APP.IN_Max_SC+cal.APP2.IN_Max)/cal.APP2.IN_Max*100;

%Vehicle Wake Analog Calibration
cal.Veh_Wake.VoltageThreshold = 2.5;     %    2.5 Volts for determining not grounded

cal.PWM.UprateLimit = 50;  % 50% duty cycle uprate limit for PWM output.
cal.PWM.DerateLimit = -50;  % -50% duty cycle Derate limit for PWM output.

%%
%CAN Error Detection Calibrations - Cyclic Times for CAN Messages (sec)
cal.CAN_Cyclic.PPEI_Chassis_General_Status_1=0.020;    %
cal.CAN_Cyclic.Brake_Pedal_Driver_Status_HS=0.050;     %
cal.CAN_Cyclic.PPEI_Platform_General_Status=0.100;     %
cal.CAN_Cyclic.PPEI_Brake_Apply_Status=0.010;          %
cal.CAN_Cyclic.PPEI_Engine_General_Status_1=0.012;     %
cal.CAN_Cyclic.PPEI_Engine_General_Status_5=0.500;     %
cal.CAN_Cyclic.PPEI_Vehicle_Speed_and_Distance=0.100;  %
cal.CAN_Cyclic.ETEI_Engine_Torque_Status1=0.012;       %
cal.CAN_Cyclic.PPEI_Trans_General_Status_1=0.012;      %
cal.CAN_Cyclic.PPEI_Trans_General_Status_2=0.025;      %
cal.CAN_Cyclic.BCM_Data1=0.050;                        %
cal.CAN_Cyclic.BCM_Limits=0.100;                       %
cal.CAN_Cyclic.BCM_Status=0.050;                       %
cal.CAN_Cyclic.Accessory_Pwr_Mod_Gen_Status_1=0.025;   %
cal.CAN_Cyclic.NLG5_ACT_I=0.100;                       %
cal.CAN_Cyclic.NLG5_ST=0.100;                          %
cal.CAN_StartupDelay=2;                                 %
%%

%OBC Charger
cal.obc.MaxMainsCurrent = 16; %Max current from AC source, Amperes
%OBC Output Voltage Command [V]
cal.obc.MaxOutputVoltage = ess.plant.init.cell_max_V*ess.plant.init.series_cells;
cal.obc.MaxChargeCurrent_Level2=10; %Amp
cal.obc.MaxChargeCurrent_Level1=5;  %Amp
cal.obc.MaxShtdwnCurrent=0.5;       %Amp
cal.PD.Disconnected=4.5; %PD Voltage when not plugged
cal.PD.Connected_NoCharge=2.8; %PD Voltage when plugged with trigger depressed
cal.PD.Connected_ChargeRdy=1.5; %PD Voltage when plugged and trigger released
cal.PD.ErrorAllowed=0.6; %Voltage error allowed +/-


%Timers (sec)
cal.Time.PwrDwnWait = 10; 
cal.Time.DiagUSB = 2; 
cal.Time.CrankEngine = 2.5;      %Timer window for engine crank
cal.Time.BrkFlt = 0.010;
cal.Time.MismatchTrq = 1; 
cal.Time.HV.WaitForShtdwn=2;
cal.Time.HV.StartupFault=5;
cal.Time.HV.NoPlugShutdown=5;
cal.Time.HV.ReadyForShtdwn=5;
cal.Time.HV.OpenContact=1;
cal.Time.HV.Discharge=5;
cal.Time.HV.DisableBCM=2;
cal.Time.BCMSleep=2;
cal.Time.MCU.InvrtrRspns=1;
cal.Time.MCU.RestartTime=1;
cal.Time.Scvng=5;
cal.Time.DOMatureDelay=5;   %Ignore the DO request within 5secs
cal.Time.TrnsOvrllEstTrqRatioSwitch=1; %Ignore the "0" ratio within 1sec
cal.Time.ReleaseNDelay=1.5; %Wait for 2sec before releasing Neutral.
cal.Time.KeyOffShtdwnDelay=40; %Wait time after key off to shutdown the vehicle.

%APM Requests
cal.apm.LowVoltageSetpoint = 13.5; %V
cal.apm.MaxShtdwnCurrent=0.5; %Amp
cal.Low_volt_fault = 10000; %ms
cal.RPM_fault = 10000; %ms

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Thermal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fans
cal.ESSFanReq.Level1=40;
cal.ESSFanReq.Level2=60;
cal.ESSFanReq.Level3=80;

cal.RWDFanReq.Level1=40;
cal.RWDFanReq.Level2=60;
cal.RWDFanReq.Level3=80;

cal.RamFanReq.Spd=50;   %kph

%APM Blower
cal.APMBlwr.DtyCycl.idx1_temp=[25:10:95];
cal.APMBlwr.DtyCycl.map=[0 20 40 60 80 100 100 100];

%RWD Pumps
cal.RWDPmps.DtyCycl.idx1_spd=[0:1000:8000];
cal.RWDPmps.DtyCycl.map_1=[10 25 35 45 55 65 75 85 95];

cal.RWDPmps.DtyCycl.idx1_pwr=[0:15000:120000];
cal.RWDPmps.DtyCycl.map_2=[10 25 35 45 55 65 75 85 95];

cal.RWDPmps.DtyCycl.idx1_mottmp=[20:10:140];
cal.RWDPmps.DtyCycl.map_3=[10 25 35 45 55 65 75 85 95 95 95 95 95];

cal.RWDPmps.DtyCycl.idx1_MCUtmp=[40:6:70];
cal.RWDPmps.DtyCycl.map_4=[10 25 35 45 65 95];

cal.RWDPmps.DtyCycl.FeedScale=0.8;
cal.RWDPmps.DtyCycl.scvng_off=0;
cal.RWDPmps.DtyCycl.feed_off=0;
cal.RWDPmps.DtyCycl.MCU_off=10;
cal.RWDPmps.DtyCycl.scvng_on=70;
cal.RWDPmps.DtyCycl.feed_min = 40;
cal.RWDPmps.DtyCycl.scvng_min = 50;


cal.RWDPmps.ShtdwnTemp.Mtr=100;      %C
cal.RWDPmps.ShtdwnTemp.MCU=50;       %C

%ESS Pump
cal.ESSPmp.DtyCycl.idx1_temp=[29:2:45];
cal.ESSPmp.DtyCycl.map=[10 25 35 45 55 65 75 85 95];

cal.ESSPmp.DtyCycl.WEG_off=10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%-------------------------------
%DriverOption
%DriverOption = 0 if automode. 
% = 1 if CD_R
% = 2 if CS_S
% = 3 if CS_F
%DriverOption = 0;
pedal_slew_rate=13000;
drv.NoPedalDeadZone=1;

%DriverIntendedAxleTrq
eng.plant.trq_max_hot_point=230;   %Max engine rated trorque [Nm]
% trans.plant.ratio_max=4.584;       %Max trans gear ratio - is this 4.73?
% FFD.Ratio=2.64;
RFD.Ratio=7.12; 
% Tire.Radius =.343; 

%Regen
cal.Regen.MinMotSpd=200; %Minimum forward motor speed to allow regen RPM
cal.Regen.MaxBrakeTorque=-100*RFD.Ratio; %Maximum Regen Braking Torque [Nm]
cal.Regen.BrakeAxleTrq.idx1_BrkPdlPos=[0 20 50 100]; %Brake pedal position [%]
cal.Regen.BrakeAxleTrq.map=[0.56 0.75 1 1]*cal.Regen.MaxBrakeTorque; %Regen Braking Axle Torque [Nm] 
cal.Regen.EnableRPM=500; % High motor speed threshold to enable regen[RPM]
cal.Regen.DisableRPM=200; % Low motor speed threshold to disable regen[RPM]
cal.Regen.MaxCSAxlTrq=50*RFD.Ratio; % Maximum charge sustaining axle regen torque.
cal.Regen.CSRegenAxlTrqLmt.idx1_spd = [0 5 10 15 20]*1.60935;%Vehicle Speed[kph] 30kph = 200rad/s
cal.Regen.CSRegenAxlTrqLmt.map = [0 0 0.25 0.5 1]*cal.Regen.MaxCSAxlTrq;%CS Regen Axle Torque[Nm]
cal.Regen.EnableAPP=7; %Maximum APP to allow leg-off regen.
cal.Regen.DisableAPP=10; %Minimum APP to disable leg-off regen.
cal.Regen.LegOffSpdMax=10; %[kph]Maximum VehSpd to disable leg-off regen.
cal.Regen.LegOffSpdMin=3; %[kph]Minimum VehSpd to disable leg-off regen.
cal.Regen.EnableSpeed=10; %[kph]Minimum Speed to enable leg-off regen.

%Diagnostics Constants
cal.DegradedPerc = 0.7;
cal.LimpHPerc = 0.3;
%cal.DegradedPercM = (eng.plant.trq_max_hot_point*cal.DegradedPerc*trans.plant.ratio_max*FFD.Ratio)/(mot.plant.init.t_max_trq *RFD.Ratio);
%cal.LimpHPercM = (eng.plant.trq_max_hot_point*cal.LimpHPerc*trans.plant.ratio_max*FFD.Ratio)/(mot.plant.init.t_max_trq *RFD.Ratio);

%Trq Mismatch Error
cal.ENGTRQ_MSMCH.Degraded_CP = 40;
cal.ENGTRQ_MSMCH.LimpHome_CP = 70;
cal.ENGTRQ_MSMCH.ErrCritical_CP = 100; %Nm

cal.MOTTRQ_MSMCH.Degraded_CP = 40;
cal.MOTTRQ_MSMCH.LimpHome_CP = 70;
cal.MOTTRQ_MSMCH.ErrCritical_CP = 100;

%%
%Crank Engine
%SysPwrMd
Run = 2;
CrankRequest = 3;
Accessory = 1;
Off = 0;

%Transmission
IMS_out_Float = 1; %floating voltage
IMS_out_Zero = 0; 
cal.IMS_C.OpenThreshold = 2.5; % 2.5 Volts for determining not grounded 
cal.TransAuxPumpMinSpd=5; %Minimum vehicle speed to run the aux pump [kph]

%Shift Lever
Park = 1;
Reverse = 2;
Neutral = 3;
Driver = 4;

%Key Position Constants
KeyOFF = 0;
KeyAccessory = 1;
KeyIgnition = 2;
KeyCrank = 3;

cal.EngCrankMaxVehSpd = 1; %km/hr

%Transmission Estimated Gear Constants
NeutralGear = 13; %Hex D
ParkGear = 15; %Hex F
FirstGear = 1; 
SecondGear = 2;
ThirdGear = 3;
FourthGear = 4;
FifthGear = 5;
SixthGear = 6;
ReverseGear = 14; %Hex E

% APM Diagnostic Timers (hysterisis'):
cal.Time.APMOvrVltWait=.025;   %Hysterisis for APM Voltage fault
cal.Time.APMLwVltOtptCrntUnsWait=.025;   %Hysterisis for APM LowVlt Current fault
cal.Time.ACCPwrMdlHiVltInpCrntWait=.025;   %Hysterisis for APM HiVlt Current fault
cal.Time.ACCPwrMdlLowVltLowWait=.025;   %Hysterisis for APM LowVlt Voltage fault
cal.Time.ACCPwrMdlTempWait=.025;   %Hysterisis for APM High Temp faults (2 of them)

% APM Diagnostic calibrations:
cal.APM.LowVltOptVoltHi = 15.5; %ACM 12V High Voltage alarm limit*
cal.APM.LowVltOptVoltLow = 10; %APM 12V Low Voltage Driver warning limit*
cal.APM.LowVltOtptCrntHi = 120; %APM 12V High Current alarm Limit*
cal.APM.HighVoltInptCurrHi = 10; %APM HV High Current alarm limit*
cal.APM.AccPwrModTmp = 80; %APM temperature alarm limit*

%OBC Diagnostics
cal.obc.OBC_Eff_Fault = .85;    %minimum OBC efficiency to prevent fault
cal.obc.Max_Inpt_Volt = 250;    %max OBC InputVoltage
cal.obc.Otpt_volt_WtchDog = 5;    %max allowable differance b/w batt voltage and OBC output voltage
cal.obc.Wall_Brak_Prot_Fault_220V = 3650;    %max allowable power input (220V)
cal.obc.Wall_Brak_Prot_Fault_110V = 1850;    %max allowable power input (110V)
cal.obc.Temp_Fault = 40;    %max OBC InputVoltage

%OBC diagnostic Timers
cal.Time.obc.OBC_Eff_Fault = .5; %Hysterisis for OBC_EFF_Fault
cal.Time.obc.Max_Inpt_Volt = .5; %Hysterisis for Max_OBC_Inpt_Volt
cal.Time.obc.Otpt_volt_WtchDog = .5; %Hysterisis for Otput Voltage Watchdog
cal.Time.obc.Wall_Brak_Prot_Fault = .5; %Hysterisis wall breaker fault
cal.Time.obc.Temp_Fault = .5;    %Hysterisis wall breaker fault

%MCU_Diagnostics
cal.Diag.MCU.MotorTempLow = 155; %Calibration for low-level motor temp fault
cal.Diag.MCU.MotorTempHi = 155; %Calibration for High-level motor temp fault
cal.Diag.MCU.BoardTempLow = 75; %Calibration for low-level board temp fault
cal.Diag.MCU.BoardTempHi = 80; %Calibration for High-level board temp fault
cal.Diag.MCU.MOTTRQ_MSMCH = 5; % Calibration for declaring a fault between commanded torque to MCU vs. Actual from MCU [sec]
cal.Diag.MCU.COMMOTTRQ_MSMCH = 20; %Cal to determine whether HCU commanded torque is same as MCU defined mot_torque command [Nm]
cal.Diag.MCU.ESSVLT_MSMCH = 25; %Allowable differance b/w ESS reported and MCU reported Bus voltage
cal.Diag.MCU.WhlMtrMSMCH = 5; %Allowable differance between actural rear wheel speed and calulated rear wheel speed based on Motor speed

%MCU_Diagnostics Timers
cal.Time.Diag.MCU.MotorTempLow = .5; %Hysterisus for low-level motor temp fault
cal.Time.Diag.MCU.MotorTempHi = .5; %Hysterisus for High-level motor temp fault
cal.Time.Diag.MCU.BoardTempLow = .5; %Hysterisus for low-level board fault
cal.Time.Diag.MCU.BoardTempHi = .5; %Hysterisus for High-level board fault
cal.Time.Diag.MCU.MOTTRQ_MSMCH = .1; %Hysterisus for Torque Mismatch fault (command and actual)
cal.Time.Diag.MCU.DirectionMismatch = .1; %Hysterisus for direction Mismatch fault (command and actual)
cal.Time.Diag.MCU.ESSVLT_MSMCH = .1; %hysterious for ESSVLT_MSMCH fault
cal.Time.Diag.MCU.WhlMtrMSMCH = .5; %hysterious for WhlMtrMSMCH fault

%PTTR Diagnostics
cal.Time.Diag.PTTR.Whl_Dir_CMD_Msmatch = .1; %hysterious for Wheel Direction Command Mismatch fault
cal.Diag.PTTR.slip.max = 2; %Max allowable wheel slip (front to rear (kph))
cal.Time.Diag.PTTR.slip.max = .1; %hysterious for Wheel Slip fault
cal.Diag.PTTR.BrkPdlMsmch = 10; %determination of both pedals being pushed at same time
cal.Diag.PTTR.APPPdlMsmch = 10; %determination of both pedals being pushed at same time

%FWD Manager Constants
Wheel_TransOut_MismatchError = 90; %RPM
EngineMaxTrq = 1119;
EngineMinTrq = -847;
TrnsInShftAngVel_LowLimit = 0;
TrnsInShftAngVel_HighLimit = 16383;

%RWD 
cal.RWD.BffrDrtTbl.idx1_buffer=[0 50 100];
cal.RWD.BffrDrtTbl.idx2_frac=[0 1 1];
cal.RWD.MaxShtdwnCurrent=0.5; %Amp
cal.RWD.ForwardDirection=0;
cal.RWD.MotorDerate.idx1_temp=[-40 0 40 80 120 150 175 180 200]; %degC  GKN manual: no continuous operation above 170C
cal.RWD.MotorDerate.map=[1 1 1 1 1 1 0 0 0]*mot.plant.init.t_max_trq ; %Torque Fraction
cal.RWD.MCUDerate.idx1_temp=[-40 0 40 75 100]; %degC
cal.RWD.MCUDerate.map=[1 1 1 1 0]*mot.plant.init.t_max_trq ; %Torque Fraction
cal.RWD.CrntToTrqMinSpd=100; %Minimum speed to calculate torque from current limit [RPM]
cal.RWD.CrntToTrqMinSpdRPS= cal.RWD.CrntToTrqMinSpd * 2*pi/60; %Minimum speed to calculate torque from current limit [Rad/S]
cal.RWD.rpm2kph = 55.62; %[kph/rpm] Motor rpm to VehSpd
cal.RWD.MaxCreepMotTrq=400; %Creep torque in CD mode [Nm]
cal.RWD.CreepTrq.idx1_spd=[0 3.24 3.6 200];   %[kph]
cal.RWD.CreepTrq.idx2_trq=[1 0.5 0 0]*cal.RWD.MaxCreepMotTrq;
cal.RWD.CreepTrqEnableBPP=10; %[%]Minimum BPP to enable motor creep torque.

%Calibrations
cal.buffer_derate_index=[0   5   10  15  20   25   30   40  50  60  100];
cal.buffer_derate_tbl=  [0.2 0.3 0.3 0.3 0.32 0.35 0.38 0.4 0.5 1.0 1.0]; %Ratio of max limit 
cal.cs.lowspeed_mot_assist=10*mph2ms;   %Low speed where motor supply the torque in CS mode [mph]
cal.cs.s_low_timer=1500;                %ms
cal.cs.regen_trq_lim=-300;                %Maximum allowed regen torque for PTTR charging in CS mode [Nm]
cal.cs.APPregen_trq_lim = -100*6.4; %Mot Axle APP Regen
cal.mot2eng_index=[0 2 4];              %Switch Time [sec]
cal.mot2eng_mot_derate_tbl=[1 0.5 0];   %Derate Motor Torque
cal.eng2mot_index=[0 2 4];              %Switch Time [sec]
cal.eng2mot_eng_derate_tbl=[1 0.5 0];   %Derate Motor Torque
cal.min_gfd=250;                        %Minimum Isolation value allowed [kOhm]
cal.discharge_done_voltage=5000;        %Maximum voltage allowed after discharge [V]
cal.HVFaultTimer=5000;                  %HV Manager Fault Time [sec]
cal.DischargeTimer = 5000;              %Discharge Time [sec]
cal.EPOTimer = 6000;                    %EPO if requesting to open contactors is ignored.

%Wheel Slip Derate
cal.slip_derate_idx = [0,10];
cal.slip_derate_tbl = [1,0];
%%
%ACCM Requests
cal.ACCMSpeedRequest = 1000; %RPM

%Diagnostics
cal.BrkFlt_APP=1;   % [%]

cal.DecreaseTimer = 0.5;

DischargeTimer = 1;
cal.MotONTimer = 0.5;
USBFlightRecorderTimer = 0.003; 
DiagnosticsTimer = 0.003; 

%Regen BPP & APP Constants
RegAPP_Timer = 0.5;
APP_TORQUE_LIMIT  = 20;


%SCPD Constants
UA_Mismatch_Timer = 3;

%E2D2 Manager Constants

cal.CS_Min_Pwr = 15000;      %W lower bound used to determine requested power range
cal.CS_Max_Pwr = 80000;      %W upper bound used to determine requested power range
cal.CS_Min_Spd=50;           %kph 

cal.TransitionDelay = .1;  %s time for uprate/derate
cal.transTrqPercent = .1;  %percentage of available torque to uprate/derate

cal.EngUprtDrtTrqWndw = 60;     %Nm window to compare actual and commanded torque to see if they match

cal.Time.ModeSwitch =  1 ;    %s time for trusting a switched mode
cal.Time.MotUprtDrtWndw = 1;    %s time for uprating/derating motor torque during transition
cal.Time.EngSpdSync = 1;    %s time to wait for engine speed sync ready
cal.Time.EngEngg = 1;       %s time to wait for transmission gear being engaged

cal.EngShtdwnVehSpd = 1*mph2kph;     %kph maximum speed for vehicle to turn off the engine
cal.EngSpdSyncWndw = 200; %radsec minimum speed difference between EngSpd and TrnsInptShftSpd to releaseN. 

cal.EngSpdSync.p_gain = 0.85;

cal.EngSpdSyncTrqMax = 100;

cal.Mode4MaxSpd = 30;  %kph maximum speed for vehicle to stay in Mode 4

cal.SOCDeadBand = 0.5;  %[%] SOC dead band percentage
