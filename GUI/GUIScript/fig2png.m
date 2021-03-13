% clear
clc
% addtopath('')
% cd P2_PHEV_MIL_EC3Y4_V1_2017a\

import mlreportgen.report.* 
import mlreportgen.dom.*;
% [~,rptname]=fileparts(rptname);
clk=fix(clock);
clk1=[num2str(clk(4)),num2str(clk(5))];
reportNm=[rptname,'_Report_',clk1];
reportNm1=[rptname,'_Result_',clk1];
dirNm=reportNm1;
% addpath(genpath(ResultData));
% cd('ResultData')

if exist(dirNm)~=7
    
mkdir(dirNm);
addpath(dirNm);
end

destfile=dirNm;

cd(destfile)
rpt = Report(reportNm,'docx');
% rpt.OutputPath=destfile;
rpt.Layout.Landscape=1;
add(rpt,TitlePage('Title',reportNm));
cd ..\
%-------------
D=dir('*.fig');
N_D=size(D,1);
for i=1:N_D
   filename = D(i).name;
   fig = openfig(filename, 'new', 'invisible');
   pngNm=[filename,'.png'];
   saveas(fig, pngNm);
%    close;
end
%------------
D1=dir('*.png');
N_D1=size(D1,1);
for j=1:1:N_D1
%     fig=Figure();
    imagenm=D1(j).name;
   
    image = FormalImage();
image.Image = imagenm;
image.ScaleToFit=1;
add(rpt,image)
end


table_gen
table=BaseTable(T);
table.Title = tab_title;

add(rpt,table);

%0------------


close(rpt)
rptview(rpt)
delete *.png
movefile('*.fig',destfile)



