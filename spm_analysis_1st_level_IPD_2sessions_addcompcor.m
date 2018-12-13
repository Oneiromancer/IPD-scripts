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
subsname=dir('Sub*');
session_name='IPD';
EPIs='swvraf'; %if repaired use swvras


FLAG=0;

for i=1:length(subsname)
     if (strcmp(subsname(i,1).name(1:3),'Sub') && subsname(i,1).isdir==1)  
         open_path=[subjdir '\' subsname(i,1).name '\' sess '\fMRI\IPD\']; %from where to open files for processing
         SPMpath=[subjdir '\' subsname(i,1).name '\SR\fMRI\' session_name '\1st_level_analysis_Basic_2sessions\']; %from where to open files for processing

         SD_path= [subjdir '\' subsname(i,1).name '\SD\fMRI\IPD\'];
         physio_path=[subjdir '\' subsname(i,1).name '\SR\fMRI\anatomy\' session_name '\new_realign\'];

         cd(open_path);         
        new_fold='1st_level_analysis_Basic_2sessions_ARTTHRESH_CompCor';
         if ~isfolder([open_path '\' new_fold])
            mkdir(new_fold)
         end
         
         outpath = [subjdir '\' subsname(i,1).name '\' sess '\fMRI\' session_name '\' new_fold '\']; %%%The directory where the Analyis will be saved
         d='';Rpath='';
         disp([ 'working on ', subsname(i,1).name '_' sess '_' session_name]);
         
         matFile=dir([SPMpath subsname(i,1).name(end-2:end) '_1st_level_Basic_2sessions.mat']);

         if ~isempty(matFile)
            cd(SPMpath)
            load(matFile.name)
%             matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,1).scans=''; %clear previous files
            matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,1).multi_reg='';
%             matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,2).scans=''; %clear previous files
            matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,2).multi_reg='';
%             matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,3).scans=''; %clear previous files
            matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,3).multi_reg='';
%             matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,4).scans=''; %clear previous files
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
                SD_ind=1;SD_flag=0;
                
                 if (total_runs==4)
                     for run=1:total_runs %loop across task runs 
                        if run<=total_runs/2 && (strcmp(session_fold(run,1).name(1:4),'run_'))%only go to epi folders
                            file_path=([open_path '\' session_fold(run,1).name '\new_realign\']);
                            d=dir([file_path '\swvra*.nii']);    %load file names of files for preprocessing
                            Rpath=([open_path '\' session_fold(run,1).name '\new_realign\']);                           
                         elseif run>total_runs/2 && (strcmp(session_fold_SD(SD_ind,1).name(1:4),'run_'))
                             file_path=([SD_path '\' session_fold_SD(SD_ind,1).name '\new_realign\']);
                             
                             d=dir([file_path '\swvra*.nii']);    %load file names of files for preprocessing
                             Rpath=([SD_path '\' session_fold_SD(SD_ind,1).name '\new_realign\']);
                             SD_ind=SD_ind+1;SD_flag=1;
                        end
                        
                        if ~isempty(d)  %if finds niifiles 
                            files={d(1:end).name}';
                            matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,run).scans = ' ';
                            matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,run).scans=cellstr(strcat([file_path '\'], files, ',1'));
                        else
                            disp(['No files found on subject_' subsname(i,1).name '\' session_name '_run_' num2str(run) '!']);
                            FLAG=0;
                        end
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        %% %% Add movement regressor
%                          if FLAG
%                              dx=dir([Rpath  '\rp*.txt']);
%                              if ~isempty(dx) 
%                                 R=load([Rpath '\' dx.name]);
%                                  cd(Rpath)
%                                  save('R.mat')
%                                   matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,run).multi_reg={fullfile(Rpath,'R.mat')};
%                              else
%                                  FLAG=0; 
%                                  disp(['no movement parameters for_' subsname(i,1).name '\' session_name '_run_' num2str(run) '!'])
%                              end
%                          end
%                      end
%                  end

    
   %make sure onsets are there 
   for jj=1:length(matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,1).cond) %totl # of conds
      if ~(isnumeric(matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,run).cond(1,jj).onset)|| isnumeric(matlabbatch{1,1}.spm.stats.fmri_spec.sess(1,run).cond(1,jj).duration))
          FLAG=0;
      end
   end
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
                                disp(['no movement parameters for_' subsname(i,1).name '\' session_name '_run_' num2str(run) '!'])
                            end
                            cd(physio_path);
                            if SD_flag
                                wm=dir(['SD_WM_run' num2str(run-3) '_5PCs.mat']);
                                load(wm.name)
                                R=[R PCs];
                                cs= dir(['SD_CSF_run' num2str(run-3) '_5PCs.mat']);
                                load(cs.name);
                                R=[R PCs];
                                
                            else
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
                                disp(['no physio parameters for_' subsname(i,1).name '\' session_name '_run_' num2str(run) '!'])
                            end
                            
                        else
                            disp(['No files found on subject_' subsname(i,1).name '\' session_name '_run_' num2str(run) '!']);
                            FLAG=0;
                            
                        end
   
   
   
            end
                 end
            end
            else
            disp(['No SPM file found on subject_' subsname(i,1).name '\' session_name '!']);
            end
            
         
         %% creating the SPM with the model
           if FLAG
            cd(outpath)
            save([ subsname(i,1).name(end-2:end) '_1st_level_Basic_2sessions_repaired_CompCor.mat'],'matlabbatch')
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
        
%         %%% Adding contrasts %%*
%         if isempty(dir([outpath 'con*']))
%             
%             cd(outpath)
%             load([outpath 'SPM.mat'])
%            % SPM=add_contrasts_Thermal_2sessions(SPM,size(R,2));
%         else
%             disp('Contrasts already exist!');
%         end
    end
    clear SPM;
end

     