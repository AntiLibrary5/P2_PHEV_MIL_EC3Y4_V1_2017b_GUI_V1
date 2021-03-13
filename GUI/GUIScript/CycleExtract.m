% clearvars -except pathname filename
F_ind=size(filename_blf,2);
for i=1:1:F_ind
    [~,blfNm]=fileparts(char(filename_blf(i)));
    SourceMatFile=fullfile(char(pathname_blf),[blfNm,'.mat']);% get the files in the target path
    exp_Dt='^[LC]';
    CycDtNm_log=regexp(blfNm,exp_Dt,'split');
    CycDT_log=['D',CycDtNm_log{2}];
    DriveMatPath=what('DrivingCycleExtracted');
    pathname_cyc=DriveMatPath.path;
    DestPath_Cyc=char(fullfile(pathname_cyc,CycDT_log)); %
    %---------------drive cycle exist?
    if exist(DestPath_Cyc,'file')==2
        disp([CycDT_log,' is',' already converted'])
    elseif exist(DestPath_Cyc,'file')~=2
        %------
        % [~,blfNm]=fileparts(char(filename_blf));
        % SourceMatFile=fullfile(char(pathname_blf),[blfNm,'.mat']);% get the files in the target path
        % exp_Dt='^[DL]';
        % CycDtNm_log=regexp(blfNm,exp_Dt,'split');
        % CycDT_log=['D',CycDtNm{2}];
        
        TargetNm=CycDT_log;
        load(SourceMatFile);
        Sgn={'Time','VehSpdAvgDrvn','VehGrdSnsrBsd','SysPwrMd','TrnsShftLvrPos'};
        VarExist=0;
        for i=1:size(Sgn,2)
            if exist(Sgn{i})~=1
                disp([Sgn{i},' !!!NOT EXISTED!!!'])
            else
                disp([Sgn{i},' !EXISTED!'])
                VarExist=VarExist+1;
            end
            
        end
        if VarExist==size(Sgn,2)
            Sgnls=[Time,VehSpdAvgDrvn/3.6,VehGrdSnsrBsd,SysPwrMd,TrnsShftLvrPos];
            
            N_cyc=size(Sgnls,1);
            sch_cycle=zeros(N_cyc,46);
            sch_cycle(:,(1:5))=Sgnls;
            sch_key=sch_cycle(:,[1,4]);
            sch_grade=sch_cycle(:,[1,3]);
            sch_shifter=sch_cycle(:,[1,5]);
            % sch_cycle=zeros(N_cyc,46);
            % sch_cycle=Sgnls(:,[1,2]);
            % sch_grade=Sgnls(:,[1,3]);
            % sch_key=Sgnls(:,[1,4]);
            % sch_shifter=Sgnls(:,[1,5]);
            TargetNm1=[TargetNm,'.mat'];
            save(TargetNm1,'sch_cycle','sch_grade','sch_key','sch_shifter');
            % mkdir(TargetFolder)
            % movefile('sch*',TargetFolder)
            movefile(TargetNm1,'DrivingCycleExtracted')
        end
    end
end

