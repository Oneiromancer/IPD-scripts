%Make 1st Level for IPD 
%files are already repaired, smoothed, normalized. 
%add durations and add to templates
clear all; close all;
TemplateFolder=('E:\spm8_templates_sleep');
spm fmri
subjdir=('E:\AdamData\SANS Data\');
sess='SR';
%subject folders
cd(subjdir)
% subsname=dir('Sub124*');
IDs = {'Sub103*'}
%IDs = {'Sub102*'; 'Sub103*'; 'Sub104*'; 'Sub105*'; 'Sub106*'; 'Sub107*';  'Sub108*'; 'Sub112*'; 'Sub113*';   'Sub114*'; 'Sub115*'; 'Sub117*'; 'Sub118*';  'Sub119*'; 'Sub120*';  'Sub121*'; 'Sub122*'; 'Sub123*'; 'Sub124*';'Sub126*';'Sub128*';};
% IDs = {'Sub102*'; 'Sub104*'; 'Sub105*'; 'Sub106*'; 'Sub108*'; 'Sub114*'; 'Sub115*'; 'Sub117*'; 'Sub119*'; 'Sub121*'; 'Sub128*';};
session_name='IPD';

FLAG=0;

for i=1:length(IDs)
    cd(subjdir)
    subsname = dir(IDs{i});
     if (strcmp(subsname(1,1).name(1:3),'Sub') && subsname(1,1).isdir==1)  
         open_path=[subjdir '\' subsname(1,1).name '\' sess '\fMRI\IPD\']; %from where to open files for processing
         SD_path= [subjdir '\' subsname(1,1).name '\SD\fMRI\IPD\'];
         
         cd(open_path);         
         new_fold='1st_level_analysis_Choice_2sessions_RT_paramod';
         if ~isdir([open_path '\' new_fold])
            mkdir(new_fold)
         end
         
         outpath = [subjdir '\' subsname(1,1).name '\' sess '\fMRI\' session_name '\' new_fold '\']; %%%The directory where the Analyis will be saved
         d='';Rpath='';
         disp([ 'working on ', subsname(1,1).name '_' sess '_' session_name]);
         
         if isempty(dir([outpath 'SPM.mat']));
            cd(TemplateFolder)
            load  1st_level_IPD_Choice_SRSD_joint_analysis_RT_paramod
            matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,1).scans=''; %clear previous files
            matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,1).multi_reg='';
            matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,2).scans=''; %clear previous files
            matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,2).multi_reg='';
            matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,3).scans=''; %clear previous files
            matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,3).multi_reg='';
            matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,4).scans=''; %clear previous files
            matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,4).multi_reg='';
            matlabbatch{1,1}.spm.stats.fmri_spec.dir = cellstr(outpath);
            
            session_fold=dir([open_path '\run_*' ]) ;    %look for task runs
            session_fold_SD=dir([SD_path '\run_*' ]) ;
            
            if isempty(session_fold) || isempty(session_fold_SD)
                FLAG=0;
            else
                run=0; FLAG=1;
            end
            
            if FLAG
                total_runs=length(session_fold)+length(session_fold_SD);
                SD_ind=1;
                
                 if (total_runs==4)
                     for run=1:total_runs %loop across task runs 
                        if run<=total_runs/2 && (strcmp(session_fold(run,1).name(1:4),'run_'))%only go to epi folders
                            file_path=([open_path '\' session_fold(run,1).name '\new_realign\']);
                            d=dir([file_path '\swvra*.nii']);    %load file names of files for preprocessing
                            Rpath=file_path;                            
                         elseif run>total_runs/2 && (strcmp(session_fold_SD(SD_ind,1).name(1:4),'run_'))
                             file_path=([SD_path '\' session_fold_SD(SD_ind,1).name '\new_realign\']);
                             
                             d=dir([file_path '\swvra*.nii']);    %load file names of files for preprocessing
                             Rpath=file_path;
                             SD_ind=SD_ind+1;
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
                         if FLAG
                             dx=dir([Rpath  '\rp*.txt']);
                             if ~isempty(dx) 
                                R=load([Rpath '\' dx.name]);
                                 cd(Rpath)
                                 save('R.mat')
                                  matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,run).multi_reg={fullfile(Rpath,'R.mat')};
                             else
                                 FLAG=0; 
                                 disp(['no movement parameters for_' subsname(1,1).name '\' session_name '_run_' num2str(run) '!'])
                             end
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
       if FLAG
           if run==1 %SR PRO
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(1).onset=' ';
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(2).onset=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(3).onset=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(4).onset=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(5).onset=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(6).onset=' ';            
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(1).duration=' ';
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(2).duration=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(3).duration=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(4).duration=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(5).duration=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(6).duration=' ';
                
                %CoopChoice onsets/durations
                if ~isnan(SR_PRO_onsets{1})
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(1).onset= SR_PRO_onsets{1};
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(1).duration= 6;
                else
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(1).onset= NaN(1,1);
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(1).duration= 6;
                end;

                %DefectChoice onsets/durations
                if ~isnan(SR_PRO_onsets{2})
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(2).onset= SR_PRO_onsets{2};
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(2).duration= 6;
                else
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(2).onset= nan(1,1);
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(2).duration= 6;
                end
%                 %CC-Outcome onset/duration
%                 if ~isnan(SR_PRO_onsets{3})
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(3).onset= SR_PRO_onsets{3};
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(3).duration= 6
%                 else
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(3).onset= nan(1,1);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(3).duration= 6
%                 end
%                 %DD-Outcome onset/duration
%                 if ~isnan(SR_PRO_onsets{4})
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(4).onset= SR_PRO_onsets{4};
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(4).duration= 6
%                 else
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(4).onset= nan(1,1);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(4).duration= 6
%                 end
%                 %CD-Outcome onset/duration
%                 if ~isnan(SR_PRO_onsets{5})
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(5).onset= SR_PRO_onsets{5};
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(5).duration= 6
%                 else
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(5).onset= nan(1,1);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(5).duration= 6
%                 end
%                 %DC-Outcome onset/duration
%                 if ~isnan(SR_PRO_onsets{6})
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(6).onset= SR_PRO_onsets{6};
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(6).duration= 6
%                 else
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(6).onset= nan(1,1);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(1).cond(6).duration= 6
%                 end
                
                run = run+1;
           end
           if run==2 %SR anti
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(1).onset=' ';
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(2).onset=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(3).onset=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(4).onset=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(5).onset=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(6).onset=' ';            
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(1).duration=' ';
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(2).duration=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(3).duration=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(4).duration=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(5).duration=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(6).duration=' ';
                
                %CoopChoice onsets/durations
                if ~isnan(SR_ANTI_onsets{1})
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(1).onset= SR_ANTI_onsets{1};
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(1).duration= 6;
                else
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(1).onset= nan(1,1);
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(1).duration= 6;
                end
                %DefectChoice onsets/durations
                if ~isnan(SR_ANTI_onsets{2})
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(2).onset= SR_ANTI_onsets{2};
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(2).duration= 6;
                else
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(2).onset= nan(1,1);
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(2).duration= 6;
                end
                %CC-Outcome onset/duration
%                 if ~isnan(SR_ANTI_onsets{3})
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(3).onset= SR_ANTI_onsets{3};
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(3).duration= 6;
%                 else
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(3).onset= nan(1,1);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(3).duration= 6;
%                 end
%                 %DD-Outcome onset/duration
%                 if ~isnan(SR_ANTI_onsets{4})
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(4).onset= SR_ANTI_onsets{4};
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(4).duration= 6;
%                 else
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(4).onset= nan(1,1);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(4).duration= 6;
%                 end
%                 %CD-Outcome onset/duration
%                 if ~isnan(SR_ANTI_onsets{5})
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(5).onset= SR_ANTI_onsets{5};
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(5).duration= 6;
%                 else
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(5).onset= nan(1,1);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(5).duration= 6;
%                 end
%                 %DC-Outcome onset/duration
%                 if ~isnan(SR_ANTI_onsets{6})
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(6).onset= SR_ANTI_onsets{6};
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(6).duration= 6;
%                 else
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(6).onset= nan(1,1);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(2).cond(6).duration= 6;
%                 end                
                
                run = run+1;
           end
           
           cd(SD_path);
           cd ../../Behavior/onsets_durations/IPD;
           load('SD_IPD_onsets_durations_file.mat')
if run==3 %SD PRO
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(1).onset=' ';
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(2).onset=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(3).onset=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(4).onset=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(5).onset=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(6).onset=' ';            
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(1).duration=' ';
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(2).duration=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(3).duration=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(4).duration=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(5).duration=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(6).duration=' ';
                
                %CoopChoice onsets/durations
                if ~isnan(SD_PRO_onsets{1})
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(1).onset= SD_PRO_onsets{1};
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(1).duration= 6;
                else
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(1).onset= nan(1,1);
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(1).duration= 6;
                end
                %DefectChoice onsets/durations
                if ~isnan(SD_PRO_onsets{2})
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(2).onset= SD_PRO_onsets{2};
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(2).duration= 6;
                else 
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(2).onset= nan(1,1);
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(2).duration= 6;
                end
                %CC-Outcome onset/duration
%                 if ~isnan(SD_PRO_onsets{3})
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(3).onset= SD_PRO_onsets{3};
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(3).duration= 6;
%                 else
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(3).onset= nan(1,1);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(3).duration= 6;
%                 end
%                 %DD-Outcome onset/duration
%                 if ~isnan(SD_PRO_onsets{4})
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(4).onset= SD_PRO_onsets{4};
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(4).duration= 6;
%                 else
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(4).onset= nan(1,1);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(4).duration= 6;
%                 end
%                 %CD-Outcome onset/duration;
%                 if ~isnan(SD_PRO_onsets{5})
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(5).onset= SD_PRO_onsets{5};
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(5).duration= 6;
%                 else
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(5).onset= nan(1,1);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(5).duration= 6;
%                 end
%                 %DC-Outcome onset/duration
%                 if ~isnan(SD_PRO_onsets{6})
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(6).onset= SD_PRO_onsets{6};
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(6).duration= 6;
%                 else
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(6).onset= nan(1,1);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(3).cond(6).duration= 6;
%                 end
                
                run = run+1;
           end
if run==4 %SD ANTI
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(1).onset=' ';
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(2).onset=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(3).onset=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(4).onset=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(5).onset=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(6).onset=' ';            
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(1).duration=' ';
                matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(2).duration=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(3).duration=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(4).duration=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(5).duration=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(6).duration=' ';
                
                %CoopChoice onsets/durations
                if ~isnan(SD_ANTI_onsets{1})
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(1).onset= SD_ANTI_onsets{1};
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(1).duration= 6;
                else 
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(1).onset= nan(1,1);
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(1).duration= 6;
                end
                %DefectChoice onsets/durations
                if ~isnan(SD_ANTI_onsets{2})
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(2).onset= SD_ANTI_onsets{2};
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(2).duration= 6;
                else
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(2).onset= nan(1,1);
                    matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(2).duration= 6;
                end
                %CC-Outcome onset/duration
%                 if ~isnan(SD_ANTI_onsets{3})
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(3).onset= SD_ANTI_onsets{3};
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(3).duration= 6;
%                 else
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(3).onset= nan(1,1);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(3).duration= 6;
%                 end
%                 %DD-Outcome onset/duration
%                 if ~isnan(SD_ANTI_onsets{4})
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(4).onset= SD_ANTI_onsets{4};
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(4).duration= 6;
%                 else
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(4).onset= nan(1,1);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(4).duration= 6;
%                 end
%                 %CD-Outcome onset/duration
%                 if ~isnan(SD_ANTI_onsets{5})
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(5).onset= SD_ANTI_onsets{5};
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(5).duration= 6;
%                 else
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(5).onset= nan(1,1);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(5).duration= 6;
%                 end
%                 %DC-Outcome onset/duration
%                 if ~isnan(SD_ANTI_onsets{6})
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(6).onset= SD_ANTI_onsets{6};
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(6).duration= 6;
%                 else
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(6).onset= nan(1,1);
%                     matlabbatch{1,1}.spm.stats.fmri_spec.sess(4).cond(6).duration= 6;
%                 end
                
end
       end
   end
   
   for jj=1:length(matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,1).cond) %totl # of conds
      if ~(isnumeric(matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,run).cond(1,jj).onset)|| isnumeric(matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,run).cond(1,jj).duration))
          FLAG=0;
      end
   end
            end
         end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%adding parametric modulators -- Choice RT (s)
cd(open_path)
cd ../../Behavior/onsets_durations/IPD;

%load in csv with RT data - second column
%SR 
filename_coop_run_1 = dir('*SR*PRO*Coop_RT.csv');
filename_coop_run_2 = dir('*SR*ANTI*Coop_RT.csv');

filename_defect_run_1 = dir('*SR*PRO*Defect_RT.csv');
filename_defect_run_2 = dir('*SR*ANTI*Defect_RT.csv');

SR_run_001_Coop_RTs = csvread(filename_coop_run_1.name,0,1);
SR_run_002_Coop_RTs = csvread(filename_coop_run_2.name,0,1);

SR_run_001_Defect_RTs = csvread(filename_defect_run_1.name,0,1);
SR_run_002_Defect_RTs = csvread(filename_defect_run_2.name,0,1);

 %run1 
matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,1).cond(1).pmod.param=SR_run_001_Coop_RTs;
matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,1).cond(2).pmod.param=SR_run_001_Defect_RTs;
 %run2 
matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,2).cond(1).pmod.param=SR_run_002_Coop_RTs;
matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,2).cond(2).pmod.param=SR_run_002_Defect_RTs;

%SD 
cd(SD_path)
cd ../../Behavior/onsets_durations/IPD
filename_coop_run_1 = dir('*SD*PRO*Coop_RT.csv');
filename_coop_run_2 = dir('*SD*ANTI*Coop_RT.csv');

filename_defect_run_1 = dir('*SD*PRO*Defect_RT.csv');
filename_defect_run_2 = dir('*SD*ANTI*Defect_RT.csv');

SD_run_001_Coop_RTs = csvread(filename_coop_run_2.name,0,1);
%SD_run_002_Coop_RTs = csvread(filename_coop_run_2.name,0,1);

SD_run_001_Defect_RTs = csvread(filename_defect_run_2.name,0,1);
%SD_run_002_Defect_RTs = csvread(filename_defect_run_2.name,0,1);

 %run1 
matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,3).cond(1).pmod.param=SD_run_001_Coop_RTs;
matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,3).cond(2).pmod.param=SD_run_001_Defect_RTs;
 %run2 
%matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,4).cond(1).pmod.param=SD_run_002_Coop_RTs;
%matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,4).cond(2).pmod.param=SD_run_002_Defect_RTs;

         %% creating the SPM with the model
           if FLAG
            cd(outpath)
            save([ subsname(1,1).name(end-2:end) '_1st_level_CHOICE_2sessions_RT_paramod.mat'],'matlabbatch')
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
           % SPM=add_contrasts_Thermal_2sessions(SPM,size(R,2));
           %SPM = add_contrasts_IPD_2sessions_CHOICE(SPM, 6)
        else
            disp('Contrasts already exist!');
        end
    end
    clear SPM;
end

     