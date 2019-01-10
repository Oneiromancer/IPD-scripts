%Make 1st Level for IPD 
%files are already repaired, smoothed, normalized. 
%add durations and add to templates
%bichoice_basic model - basic (no RT) for 103 (SRPRO SRANTI SDANTI)

clear all; close all;
TemplateFolder=('E:\spm8_templates_sleep');
spm fmri
subjdir=('E:\AdamData\SANS Data\');
sess='SR';
%subject folders
cd(subjdir)
%All_IDs = {'Sub102*'; 'Sub103*'; 'Sub104*'; 'Sub105*'; 'Sub106*'; 'Sub107*';  'Sub108*'; 'Sub112*'; 'Sub113*';   'Sub114*'; 'Sub115*'; 'Sub117*'; 'Sub118*';  'Sub119*'; 'Sub120*';  'Sub121*'; 'Sub122*'; 'Sub123*'; 'Sub124*';'Sub126*';'Sub128*';};
%FullModel_IDs = {'Sub102*'; 'Sub104*'; 'Sub105*'; 'Sub106*'; 'Sub108*'; 'Sub114*'; 'Sub115*'; 'Sub117*'; 'Sub119*'; 'Sub121*'; 'Sub128*';};
%UniqueModel_IDs = {'Sub103';'Sub107*';'Sub112*';'Sub113*';'Sub118*';'Sub120*';'Sub122*';'Sub123*';'Sub124*';'Sub126*';};
IDs = {'Sub103*';};
session_name='IPD';

FLAG=0;

for i=1:length(IDs)
    cd(subjdir)
    subsname = dir(IDs{i});
     if (strcmp(subsname(1,1).name(1:3),'Sub') && subsname(1,1).isdir==1)  
         open_path=[subjdir '\' subsname(1,1).name '\' sess '\fMRI\IPD\']; %from where to open files for processing
         SD_path= [subjdir '\' subsname(1,1).name '\SD\fMRI\IPD\'];
         physio_path=[subjdir '\' subsname(1,1).name '\SR\fMRI\anatomy\' session_name '\new_realign\'];

         
         cd(open_path);         
         new_fold='1st_level_analysis_biChoice_2sessions_VariableDur'; %include R_16 by default
         if ~isdir([open_path '\' new_fold])
            mkdir(new_fold)
         end
         
         outpath = [subjdir '\' subsname(1,1).name '\' sess '\fMRI\' session_name '\' new_fold '\']; %%%The directory where the Analyis will be saved
         d='';Rpath='';
         disp([ 'working on ', subsname(1,1).name '_' sess '_' session_name]);
         
         if isempty(dir([outpath 'SPM.mat']));
             cd(TemplateFolder) %need templates for unique subjs 
             
                load 103_1st_level_IPD_Choice_SRSD_joint_analysis_VariableDur  
            
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,1).scans=''; %clear previous files
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,1).multi_reg='';
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,2).scans=''; %clear previous files
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,2).multi_reg='';
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,3).scans=''; %clear previous files
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,3).multi_reg='';
                %matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,4).scans=''; %clear previous files
                %matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,4).multi_reg='';
                matlabbatch{1,1}.spm.stats.fmri_spec.dir = cellstr(outpath);
            
                session_fold=dir([open_path '\run_*' ]) ;    %look for task runs
                session_fold_SD=dir([SD_path '\run_*' ]) ;
            
            if isempty(session_fold) || isempty(session_fold_SD)
                FLAG=0;
            else
                run=0; FLAG=1;
            end
            
            if FLAG
                %total_runs=length(session_fold)+length(session_fold_SD);
                total_runs = 3; %103 excludes SD1-PRO
                SD_ind=1;SD_flag=0; %ajk edited from SD_ind=1;
                
                     for run=1:total_runs %loop across task runs 
                         %SR1-PRO and SR2-ANTI
                        if run<=2 && (strcmp(session_fold(run,1).name(1:4),'run_'))%only go to epi folders
                            file_path=([open_path '\' session_fold(run,1).name '\new_realign\']);
                            d=dir([file_path '\swvra*.nii']);    %load file names of files for preprocessing
                            Rpath=file_path;                            
                         elseif run>2 && (strcmp(session_fold_SD(SD_ind,1).name(1:4),'run_'))
                             file_path=([SD_path '\' session_fold_SD(SD_ind,1).name '\new_realign\']);
                             
                             d=dir([file_path '\swvra*.nii']);    %load file names of files for preprocessing
                             Rpath=file_path;
                             SD_ind=SD_ind+1;SD_flag=SD_flag+1;
                        end
                        
                        if ~isempty(d)  %if finds niifiles 
                            files={d(1:end).name}';
                            matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,run).scans=cellstr(strcat([file_path '\'] ,files,',1'));
                        else
                            disp(['No files found on subject_' subsname(1,1).name '\' session_name '_run_' num2str(run) '!']);
                            FLAG=0;
                        end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       %% %% Add movement regressor
                         if ~isempty(matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,run).scans)  %if finds niifiles
                             
                            %% Add physio regressors
                            
                            dx=dir([Rpath  '\rp*.txt']);
                            rx=([Rpath  '\R_6.mat']);
                            if ~isempty(dx)
                                R=load([Rpath '\' dx.name]);
                                cd(Rpath)
                                if isempty(rx)
                                    save('R_6.mat' ,'R')
                                end
                                %matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,run).multi_reg={fullfile(Rpath,'R.mat')};
                                
                                clear PCs;
%                                 cd(file_path);
                            else
                                FLAG=0;
                                disp(['no movement parameters for_' subsname(1,1).name '\' session_name '_run_' num2str(run) '!'])
                            end
                            cd(physio_path);
                            if SD_flag
                                if run==3; %103-SD ANTI
                                    wm=dir(['SD_WM_run' num2str(2) '_5PCs.mat']);
                                    load(wm.name)
                                    R=[R PCs];
                                    cs= dir(['SD_CSF_run' num2str(2) '_5PCs.mat']);
                                    load(cs.name);
                                    R=[R PCs];
                                end
                                
                                else %SR
                                wm=dir(['SR_WM_run' num2str(run) '_5PCs.mat']);
                                load(wm.name)
                                R=[R PCs];
                                cs= dir(['SR_CSF_run' num2str(run) '_5PCs.mat']);
                                load(cs.name);
                                R=[R PCs];
                            end
                            
                            if  ~isempty(wm) && ~isempty(cs)
                                cd(Rpath)
                                save('R.mat','R');
                                save('R_16.mat' ,'R')
                                matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,run).multi_reg={fullfile(Rpath,'R.mat')};
                            else
                                FLAG=0;
                                disp(['no physio parameters for_' subsname(1,1).name '\' session_name '_run_' num2str(run) '!'])
                            end
                            
                        else
                            disp(['No files found on subject_' subsname(1,1).name '\' session_name '_run_' num2str(run) '!']);
                            FLAG=0;
                         end
                         
                     end
                 end
                 

    %% Add personalized condition onset
     %do SR  
   run=0;
   for run=1:total_runs
       cd(open_path);
       cd ../../Behavior/onsets_durations/IPD; %up 2 levels to find BEHAVIOR
       load('SR_IPD_onsets_durations_file.mat');
       %load durations based on ChoiceRT
       %SR
       %SR PRO,ANTI
        filename_coop_run_1 = dir('*SR*PRO*Coop_RT.csv');
        filename_coop_run_2 = dir('*SR*ANTI*Coop_RT.csv');

        filename_defect_run_1 = dir('*SR*PRO*Defect_RT.csv');
        filename_defect_run_2 = dir('*SR*ANTI*Defect_RT.csv');

        SR_run_001_Coop_RTs = csvread(filename_coop_run_1.name,0,1);
        SR_run_002_Coop_RTs = csvread(filename_coop_run_2.name,0,1);

        SR_run_001_Defect_RTs = csvread(filename_defect_run_1.name,0,1);
        SR_run_002_Defect_RTs = csvread(filename_defect_run_2.name,0,1);
       if FLAG
           if run==1 %SR PRO
               matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(1).onset=' '; %Coop
               matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(2).onset=' '; %Defect
               
               matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(1).duration=' ';
               matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(2).duration=' ';

                
                %CoopChoice onsets/durations
                if ~isnan(SR_PRO_onsets{1})
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(1).onset= SR_PRO_onsets{1};
                    %matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(1).duration= 6;
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(1).duration = SR_run_001_Coop_RTs;
                else
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(1).onset= NaN(1,1);
                    %matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(1).duration= 6;
                end;                
               
               %DefectChoice onsets/durations
                if ~isnan(SR_PRO_onsets{2})
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(2).onset= SR_PRO_onsets{2};
                    %matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(2).duration= 6;
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(2).duration= SR_run_001_Defect_RTs;
                else
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(2).onset= nan(1,1);
                    %matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(2).duration= 6;
                end    
                
                run = run+1;
           
           end

           if run==2 %SR anti
               matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(1).onset=' ';
               matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(2).onset=' ';
               
               matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(1).duration=' ';
               matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(2).duration=' ';

                
                %CoopChoice onsets/durations
                if ~isnan(SR_ANTI_onsets{1})
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(1).onset= SR_ANTI_onsets{1};
                    %matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(1).duration= 6;
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(1).duration= SR_run_002_Coop_RTs;
                else
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(1).onset= nan(1,1);
                    %matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(1).duration= 6;
                end
                
                %DefectChoice onsets/durations
                if ~isnan(SR_ANTI_onsets{2})
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(2).onset= SR_ANTI_onsets{2};
                    %matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(2).duration= 6;
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(2).duration= SR_run_002_Defect_RTs;
                else
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(2).onset= nan(1,1);
                    %matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(2).duration= 6;
                end
                
                run = run+1;
           end
           
           cd(SD_path);
           cd ../../Behavior/onsets_durations/IPD;
           load('SD_IPD_onsets_durations_file.mat')
           %load RTs for variable choice duration
            filename_coop_run_1 = dir('*SD*PRO*Coop_RT.csv');
            filename_coop_run_2 = dir('*SD*ANTI*Coop_RT.csv');

            filename_defect_run_1 = dir('*SD*PRO*Defect_RT.csv');
            filename_defect_run_2 = dir('*SD*ANTI*Defect_RT.csv');

            %SD_run_001_Coop_RTs = csvread(filename_coop_run_1.name,0,1);
            SD_run_002_Coop_RTs = csvread(filename_coop_run_2.name,0,1);

            %SD_run_001_Defect_RTs = csvread(filename_defect_run_1.name,0,1);
            SD_run_002_Defect_RTs = csvread(filename_defect_run_2.name,0,1);
            
            if run==3 %SD ANTI - for 103 only; exclude SD1-PRO
               matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(1).onset=' ';
               matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(2).onset=' ';
               matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(1).duration=' ';
               matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(2).duration=' ';

                
                %CoopChoice onsets/durations
                if ~isnan(SD_ANTI_onsets{1})
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(1).onset= SD_ANTI_onsets{1};
                    %matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(1).duration= 6;
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(1).duration= SD_run_002_Coop_RTs;
                else
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(1).onset= nan(1,1);
                    %matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(1).duration= 6;
                end
                
                %DefectChoice onsets/durations
                if ~isnan(SD_ANTI_onsets{2})
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(2).onset= SD_ANTI_onsets{2};
                    %matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(2).duration= 6;
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(2).duration= SD_run_002_Defect_RTs;
                else 
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(2).onset= nan(1,1);
                    %matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(2).duration= 6;
                end
                %run = run+1; %ajk commented
end
           %103 -- EXCLUDE SD2-ANTI, WHICH IS NOW RUN3 (SD1)
% if run==4 %SD ANTI
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(1).onset=' ';
%                 %matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(2).onset=' ';
% %                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(3).onset=' ';
% %                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(4).onset=' ';
% %                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(5).onset=' ';
% %                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(6).onset=' ';            
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(1).duration=' ';
%                %matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(2).duration=' ';
% %                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(3).duration=' ';
% %                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(4).duration=' ';
% %                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(5).duration=' ';
% %                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(6).duration=' ';
% 
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(1).pmod.param=' ';
% 
%                 
%                 %monoChoice onsets/durations
%                 if ~isnan([SD_ANTI_onsets{1}; SD_ANTI_onsets{2}]);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(1).onset= [SD_ANTI_onsets{1}; SD_ANTI_onsets{2}];
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(1).duration= 6;
%                     %ChoiceType ParaMod vector 
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(1).pmod.param=[ones(length(SD_ANTI_onsets{1}),1); -1*ones(length(SD_ANTI_onsets{2}),1)];
%                 else 
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(1).onset= nan(1,1);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(1).duration= 6;
%                 end
%                 
% end
       end
   end
   
   for jj=1:length(matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,1).cond) %totl # of conds
      if ~(isnumeric(matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,run).cond(1,jj).onset)|| isnumeric(matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,run).cond(1,jj).duration))
          FLAG=0;
      end
   end
            end
         end
         
         %% creating the SPM with the model
           if FLAG
            cd(outpath)
            save([ subsname(1,1).name(end-2:end) '_1st_level_analysis_basicChoice_VariableDur.mat'],'matlabbatch')
            spm_jobman('run',matlabbatch);
           end
     end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%     % *%%% Estimating the model %%*
if FLAG
        if isempty(dir([outpath 'beta*']))
            cd(TemplateFolder)
            load  estimate_1st_level_adam
            matlabbatch{1,1}.spm.stats.fmri_est.spmmat=' ';
            matlabbatch{1,1}.spm.stats.fmri_est.spmmat=cellstr([outpath 'SPM.mat']);
            spm_jobman('run',matlabbatch);
        else
            disp('SPM.mat already exists! Only adding contrasts');
        end
        clear matlabbatch
        
        %%% Adding contrasts %%*
        if isempty(dir([outpath 'con*']))
            
            cd(outpath)
            load([outpath 'SPM.mat'])
           SPM=add_contrasts_IPD_2sessions_bichoice_basic(SPM, size(R,2), subsname(1,1).name);
        else
            disp('Contrasts already exist!');
        end
end
    clear SPM;


     