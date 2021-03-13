% clear
% filename = 'EC3 Y3 Drive Trace - MPGCityHighway Rev 0.xlsx';
% sch_cycle = xlsread(filename);
% sch_cycle(:,2)=sch_cycle(:,2)*0.44704;
% save EnEC_ToTrack.mat;

clear
clc
load('EnEC_ToTrack');
[d1,d2]=size(sch_cycle);
E1=d1;
ToTrack=sch_cycle;
load('EnECCityHighway');
[d1,d2]=size(sch_cycle);
E2=d1;
OnTrack=sch_cycle;
load('EnEC_FromTrack');
[d1,d2]=size(sch_cycle);
E3=d1;
FromTrack=sch_cycle;
E4=E1+E2*7+E3;
cycle=zeros(E4,d2);

cycle(:,1)=[0:E4-1];
for i=2:13
    cycle(1:E1,i)=ToTrack(:,i);
end

% for i=2:13
%     cycle(E1:((E1+E2)-1),i)=OnTrack(:,i);
% end
% 
% for i=2:13
%     cycle(E1+E2:((E1+2*E2)-1),i)=OnTrack(:,i);
% end

for j=1:7
    for i=2:13
    cycle(E1+(j-1)*E2:((E1+j*E2)-1),i)=OnTrack(:,i);
    end

end


for i=2:13
    cycle(E1+7*E2:E4-1,i)=FromTrack(:,i);
end

cycle(13:end,4)=ones(length(cycle(13:end,4)),1)*2;
cycle(13:end,5)=ones(length(cycle(13:end,5)),1)*4;

    




