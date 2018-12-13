function SPM=add_contrasts_IPD_2sessions(SPM,N)
%% Add contrasts for conservative/basic CHOICE model
%This contains subs with variability in choice for both SR/SD and PRO/ANTI
%contrasts vectors are hard-coded for choice (all same length). 

%R=16 for compcor models 

%Coop_Choice > Baseline
%Coop, Defect, R16 (x4 for SR/SD PRO/ANTI)
% % SR AND SD
% CoopRTVSBaseline = [0 1 0 0 zeros(1,N) 0 1 0 0 zeros(1,N) 0 1 0 0 zeros(1,N) 0 1 0 0 zeros(1,N) zeros(1,length(SPM.Sess))];
% DefectRTVSBaseline = [0 0 0 1 zeros(1,N) 0 0 0 1 zeros(1,N) 0 0 0 1 zeros(1,N) 0 0 0 1 zeros(1,N) zeros(1,length(SPM.Sess))];
% 
% CoopRTVSDefectRT = [0 1 0 -1 zeros(1,N) 0 1 0 -1 zeros(1,N) 0 1 0 -1 zeros(1,N) 0 1 0 -1 zeros(1,N) zeros(1,length(SPM.Sess))];
% 
% % SR only 
% CoopRTVSBaseline_SR = [0 1 0 0 zeros(1,N) 0 1 0 0 zeros(1,N) zeros(1,N+4) zeros(1,N+4) zeros(1,length(SPM.Sess))];
% DefectRTVSBaseline_SR = [0 0 0 1 zeros(1,N) 0 0 0 1 zeros(1,N) zeros(1,N+4) zeros(1,N+4) zeros(1,length(SPM.Sess))];
% 
% CoopRTVSDefectRT_SR = [0 1 0 -1 zeros(1,N) 0 1 0 -1 zeros(1,N) zeros(1,N+4) zeros(1,N+4) zeros(1,length(SPM.Sess))];
% 
% % SD only 
% CoopRTVSBaseline_SD = [zeros(1,N+4) zeros(1,N+4) 0 1 0 0 zeros(1,N) 0 1 0 0 zeros(1,N) zeros(1,length(SPM.Sess))];
% DefectRTVSBaseline_SD = [zeros(1,N+4) zeros(1,N+4) 0 0 0 1 zeros(1,N) 0 0 0 1 zeros(1,N) zeros(1,length(SPM.Sess))];
% 
% CoopRTVSDefectRT_SD = [zeros(1,N+4) zeros(1,N+4) 0 1 0 -1 zeros(1,N) 0 1 0 -1 zeros(1,N) zeros(1,length(SPM.Sess))];

%temp edits for unique subjects with missing runs:
% SR AND SD
CoopRTVSBaseline = [0 1 0 0 zeros(1,N) 0 1 0 0 zeros(1,N) 0 1 0 0 zeros(1,N) zeros(1,length(SPM.Sess))];
DefectRTVSBaseline = [0 0 0 1 zeros(1,N) 0 0 0 1 zeros(1,N) 0 0 0 1 zeros(1,N) zeros(1,length(SPM.Sess))];

CoopRTVSDefectRT = [0 1 0 -1 zeros(1,N) 0 1 0 -1 zeros(1,N) 0 1 0 -1 zeros(1,N) zeros(1,length(SPM.Sess))];

% SR only 
CoopRTVSBaseline_SR = [0 1 0 0 zeros(1,N) 0 1 0 0 zeros(1,N) zeros(1,N+4) zeros(1,length(SPM.Sess))];
DefectRTVSBaseline_SR = [0 0 0 1 zeros(1,N) 0 0 0 1 zeros(1,N) zeros(1,N+4) zeros(1,length(SPM.Sess))];

CoopRTVSDefectRT_SR = [0 1 0 -1 zeros(1,N) 0 1 0 -1 zeros(1,N) zeros(1,N+4) zeros(1,length(SPM.Sess))];

% SD only 
CoopRTVSBaseline_SD = [zeros(1,N+4) zeros(1,N+4) 0 1 0 0 zeros(1,N) zeros(1,length(SPM.Sess))];
DefectRTVSBaseline_SD = [zeros(1,N+4) zeros(1,N+4) 0 0 0 1 zeros(1,N) zeros(1,length(SPM.Sess))];

CoopRTVSDefectRT_SD = [zeros(1,N+4) zeros(1,N+4) 0 1 0 -1 zeros(1,N) zeros(1,length(SPM.Sess))];

contrasts(1) = struct('names', {{...
    'CoopRTVSBaseline'...
    'DefectRTVSBaseline'...
    'CoopRTVSDefectRT'...
    'CoopRTVSBaseline_SR',...
    'DefectRTVSBaseline_SR'...
    'CoopRTVSDefectRT_SR'...
    'CoopRTVSBaseline_SD'...
    'DefectRTVSBaseline_SD'...
    'CoopRTVSDefectRT_SD'...
    }},...
    'types', {{'T','T','T','T','T','T','T','T','T'}}, ...
    'values',{{CoopRTVSBaseline,DefectRTVSBaseline,CoopRTVSDefectRT,CoopRTVSBaseline_SR,DefectRTVSBaseline_SR,CoopRTVSDefectRT_SR,CoopRTVSBaseline_SD,DefectRTVSBaseline_SD,CoopRTVSDefectRT_SD}} ...
    );

    if isempty(SPM.xCon)
        SPM.xCon=struct('name','','STAT','','c','','X0','','iX0','','X1o','','eidf',[],'Vcon',[],'Vspm',[]);
        end_index=0;
    else
        end_index=length(SPM.xCon);
    end
    for jj = 1:length(contrasts.values)
         SPM.xCon(end_index+jj) = spm_FcUtil('Set', contrasts.names{jj},contrasts.types{jj}, 'c', (contrasts.values{jj})', SPM.xX.xKXs);     
         idx = spm_FcUtil('~unique', SPM.xCon, SPM.xX.xKXs);
         if ~isempty(idx),
             end_index=end_index-1;
            fprintf(1,'The contrast {%03d} %s is already defined\n',jj,contrasts.names{jj});
            if length(SPM.xCon) > 1,
                SPM.xCon = SPM.xCon(1:end-1);
            else
                SPM.xCon = [];
            end
         end
    end

 % and evaluate
    %---------------------------------------------------------------------------
    if ~isempty(SPM.xCon),
        spm_contrasts(SPM);
    end
