
clc
% SourcePath= fullfile(pathname, filename);
% SourceMatFile=fullfile(pathname,'*.mat'));% get the files in the target path
NmTime=fix(clock);
NmTime=[num2str(NmTime(1)),num2str(NmTime(2)),num2str(NmTime(3))];

TargetNm=['DriveCycle_',NmTime,'_Blended.mat'];% to be automated
% TargetFolder='Drive Cycles EC3';% tba
% if exist(TargetNm)~=2
% movefile('data.mat',TargetNm)
% end
% load(TargetNm)
% SourceMatFiles=dir(fullfile(pathname,'*.mat'));


Sgnls=[Time,VehSpdAvgDrvn,VehGrdSnsrBsd,SysPwrMd,TrnsShftLvrPos];
Sgnls=Sgnls((1:10:end),:);
N_cyc=size(Sgnls,1);
sch_cycle=zeros(N_cyc,46);
sch_cycle(:,(1:5))=Sgnls;
sch_key=sch_cycle(:,[1,4]);
sch_grade=sch_cycle(:,[1,3]);
sch_shifter=sch_cycle(:,[1,5]);
save(TargetNm,'sch_cycle','sch_grade','sch_key','sch_shifter');
% mkdir(TargetFolder)
% movefile('sch*',TargetFolder)
% movefile(TargetNm,TargetFolder)