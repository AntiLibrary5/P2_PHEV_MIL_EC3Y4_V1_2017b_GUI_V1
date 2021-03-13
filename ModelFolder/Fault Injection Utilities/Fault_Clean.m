CycleLength=d1;
time= [0:1:CycleLength-1]';
APP_Mismatch=zeros(CycleLength,1);
APP1_OOR=zeros(CycleLength,1);
APP2_OOR=zeros(CycleLength,1);
Brk_Flt=zeros(CycleLength,1);
KeyPos_Flt=zeros(CycleLength,1);
PRNDL_Flt=zeros(CycleLength,1);
LossCAN=zeros(CycleLength,1);
MotTrqMismatch=zeros(CycleLength,1);
MotDirMismatch=zeros(CycleLength,1);
EngTrqMismatch=zeros(CycleLength,1);
MotOverTemp=zeros(CycleLength,1);
MCUOverTemp=zeros(CycleLength,1);
EngOverTemp=zeros(CycleLength,1);
ESSOverTemp=zeros(CycleLength,1);
ClutchEngag=zeros(CycleLength,1);

RegenFault=zeros(CycleLength,1);
% RegenFault(88:91)=ones(4,1);

