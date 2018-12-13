clear all
close all;

% === Choose preprocessing steps ==================================

SLICE_TIMING =0;   
%pause for copy_nii files
REALIGN =0;   
% option. 1: we do slice timing, 0: we don't do slice timing.
                  % option. 1: we do realignment, 0: we don't do realignment.
COREGISTER =0;
SEGMENT=0;
%pause for art_global
%convert masks
%comp_cor_erosion
NORMALISATION_With_Segment= 1;              % option. 1: we do Normalisation, 0: we don't do normalisation.
% NORMALISATION_No_Segment =0;
SMOOTH =1;                     % option. 1: we do smoothing, 0: we don't do smoothing.

% ===============================================================


subjdir=('E:\AdamData\SANS Data\');%subject folders
cd(subjdir)
subsname=dir('Sub125*');

dataFolders={'IPD'}; %thermal IPD
sess='SR'; %this is ground zero and SD is added to it% leave as.

TemplateFolder=['E:\spm8_templates_sleep'];
spm fmri
spm('defaults', 'FMRI');
spm_jobman('initcfg');



%%
for i= 1:length(subsname)
    if (strcmp(subsname(i,1).name(1:3),'Sub') && subsname(i,1).isdir==1)
        open_path=[subjdir '\' subsname(i,1).name '\' sess '\fMRI\']; %from where to open files for processing
        cd(open_path);
        SD_path= [subjdir '\' subsname(i,1).name '\SD\fMRI\'];
        disp([ '....working on ',subsname(i,1).name '_' sess '....']);
        fileTemplate='f';   % prefix of *.nii files to be preprocessed
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %% Slice-timing correction
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 if(SLICE_TIMING)
    disp('SLICE TIMING');
    cd(TemplateFolder)
    fileTemplate='f';

    load slice_timing_IPD
    matlabbatch{1,1}.spm.temporal.st.scans{1} = '';
    matlabbatch{1,1}.spm.temporal.st.scans{2} = '';
    
    for j=1:length(dataFolders)
        session_name = cell2mat(dataFolders(1,j));
        cd(open_path);
        run=0;
        d=''; x='';
        session_fold = dir([open_path session_name '\run_00*']); %2 PRO / ANTI
        
        for k=1:length(session_fold)
            if strcmp(session_fold(k,1).name(1:4),'run_')
                run=run+1;
                d=dir([open_path '\' session_name '\' session_fold(k,1).name '\' fileTemplate '*.nii']);    %load file names of files for preprocessing
                x=dir([open_path '\' session_name '\' session_fold(k,1).name '\a' fileTemplate '*.nii']); %check that files are not already processed
                if ~isempty(d)
                    files={d.name}';
                    matlabbatch{1,1}.spm.temporal.st.scans{1,run} = cellstr(strcat([open_path '\' session_name '\' session_fold(k,1).name '\'] ,files,',1'));
                end
            end
        end
    end

    if ~isempty(d)        
        spm_jobman('run' , matlabbatch);
    end
    
    %slice time SD
    disp('SLICE TIMING');
    cd(TemplateFolder)
    load slice_timing_IPD
    cd(SD_path)
    session_fold_SD = dir([SD_path '/' session_name '\run_00*' ]) ;
    run=0;
    matlabbatch{1,1}.spm.temporal.st.scans=''; %clear preaviors values
    d=''; x='';%clear preaviors values
    
    for k=1:length(session_fold_SD)
        if strcmp(session_fold_SD(k,1).name(1:4),'run_')
            run=run+1;
            d=dir([SD_path '\' session_name '\' session_fold_SD(k,1).name '\' fileTemplate '*.nii']);    %load file names of files for preprocessing
            x=dir([SD_path '\' session_name '\' session_fold_SD(k,1).name '\a' fileTemplate '*.nii']); %check that files are not already processed
            
            if (~isempty(d) && isempty(x))
                files = {d.name}';
                matlabbatch{1,1}.spm.temporal.st.scans{1,run}=cellstr(strcat([SD_path '\' session_name '\' session_fold_SD(k,1).name '\'] ,files,',1'));
            end
        end
    end
    
    if (~isempty(d) && isempty(x))
        spm_jobman('run',matlabbatch); %run slice timing 
    end
 end
 

                

            


%do copying_nii_files after slice timing, before realign
 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% Realignment (and reslice)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  if (REALIGN)
      disp('REALIGNING');
      fileTemplate='af';
      cd(TemplateFolder)
      clear matlabbatch
      clear d; clear x;
      load realign_IPD_2sessions
      cd(open_path);
      P='';
      
      for j=1:length(dataFolders)
          session_name=cell2mat(dataFolders(1,j));
          disp([ 'working on ',subsname(i,1).name '_' sess '_' session_name]);
          
          cd(open_path);
          session_fold=dir([open_path '\' session_name '\run_*']);
          session_fold_SD=dir([SD_path '\' session_name '\run_*']);
          
          matlabbatch{1,1}.spm.spatial.realign.estwrite.data= ''; %clear previous files
          total_runs=length(session_fold)+length(session_fold_SD);
          SD_ind = 1;
          
          if total_runs==4
              for run=1:total_runs
                  if run<=total_runs/2 && (strcmp(session_fold(run,1).name(1:4), 'run_'))
                     file_path=([open_path '\' session_name '\' session_fold(run,1).name '\new_realign\']);
                     d=dir([file_path '\' fileTemplate '*.nii']);    %load file names of files for preprocessing
                     x=dir([file_path  '\r' fileTemplate '*.nii']);
                  elseif run>total_runs/2 && (strcmp(session_fold_SD(SD_ind,1).name(1:4), 'run_'))
                    file_path=([SD_path '\' session_name '\' session_fold_SD(SD_ind,1).name '\new_realign\']);
                    d=dir([file_path '\' fileTemplate '*.nii']);    %load file names of files for preprocessing
                    x=dir([file_path  '\r' fileTemplate '*.nii']);
                    SD_ind=SD_ind+1;
                  end
                  
                  if (~isempty(d) && isempty(x))
                      files = {d.name}';
                      matlabbatch{1,1}.spm.spatial.realign.estwrite.data{1,run}=cellstr(strcat([file_path '\'] ,files,',1'));
                  end
              end
          else
              disp(['not enough sessions for ', subsname(i,1).name])
              break
          end
          
          if (~isempty(d) && isempty(x))
              spm_jobman('run', matlabbatch);
          end
      end
  end    
                      
    
    
    
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%
 %% Coregister % 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%
 if COREGISTER
      disp('COREGISTER');
      cd(TemplateFolder);
      fileTemplate = 'raf';
      load coregister_IPD
      cd(open_path);
      
      for j=1:length(dataFolders)
          session_name = cell2mat(dataFolders(1,j));
          disp(['Working on ', subsname(i,1).name '_' sess '_' session_name]);
          
          reg_spgr=dir([open_path '\anatomy\' session_name  '\new_realign\SPGR_' session_name '.nii']);
          
          if isempty(reg_spgr)
              session_fold = dir([open_path '\' session_name '\run_*']);
              matlabbatch{1,1}.spm.spatial.coreg.estimate.ref= '';
              matlabbatch{1,1}.spm.spatial.coreg.estimate.source= '';%clear previous files
              imgFIND=0;
              
             for k=1:length(session_fold)
                 if (~imgFIND && strcmp(session_fold(k,1).name(1:4),'run_')) %looks for the first functional run
                     d=dir([open_path '\' session_name '\' session_fold(k,1).name '\new_realign\mean*.nii']);
                     imgFIND=1;
                     if ~isempty(d)
                         files={d(1).name}';
                         matlabbatch{1,1}.spm.spatial.coreg.estimate.ref=cellstr(strcat([open_path '\' session_name  '\' session_fold(k,1).name '\new_realign\'] ,files,',1'));
                     end
                 end
             end
             
             %load SPGR folder
             SPGRfolder = 'anatomy';
             session_fold=dir([open_path '\' SPGRfolder '\mp_r*' ]) ;
             imgFIND=0;
             for k=1:length(session_fold)
                            if  (~imgFIND && strcmp(session_fold(k,1).name(1:2),'mp')) 
                                 x=dir([open_path '\' SPGRfolder  '\' session_fold(k,1).name '\co*.nii']);
                                save_path= ([ open_path '\' SPGRfolder  '\' session_name '\new_realign\']);
                                if ~isdir(save_path)
                                    mkdir(save_path)
                                end
                                imgFIND=1;
                            end
             end
                    
             if ~isempty(x)
                        cd([open_path '\' SPGRfolder  '\' session_fold(k,1).name])
                        new_name=(['SPGR_' session_name '.nii']);
                        copyfile(x.name,new_name);
                        movefile(new_name, save_path);
                        x2=dir([save_path '\SPGR_*.nii']);
                        
                        %load SPGR
                        if ~isempty(x2)
                            files={x2(1).name}';
                            matlabbatch{1,1}.spm.spatial.coreg.estimate.source=cellstr(strcat([save_path '\' ] ,files,',1'));
                        end
                        
                        if ~isempty(x2)
                            spm_jobman('run', matlabbatch);
                        end
             end
          end
      end
 end
  
      
      
      
 %%%%%%%%%%%%%%%%%%%%%%%%%%
 %% Segment %%
 %%%%%%%%%%%%%%%%%%%%%%%%%%
 if SEGMENT
     disp('SEGMENT')
     cd(TemplateFolder)
     clear matlabbatch
     load segment_thermal;
     
     for j=1:length(dataFolders)
         session_name = cell2mat(dataFolders(1,j));
         disp([ 'working on ',subsname(i,1).name '_' sess '_' session_name]);
         matlabbatch{1,1}.spm.spatial.preproc.channel.vols=''; %clear previous
         
         d=dir([open_path '\anatomy\' session_name  '\new_realign\SPGR_' session_name '.nii']);     %load SPGR file
         x=dir([open_path '\anatomy\' session_name  '\new_realign\c1*.nii']);
         
         if (~isempty(d) && isempty(x)) %if finds SPGR files
                files={d(1).name}';
                matlabbatch{1,1}.spm.spatial.preproc.channel.vols=cellstr(strcat([open_path '\anatomy\' session_name '\new_realign\'] ,files,',1'));
         end
         if  (~isempty(d) && isempty(x)) %if segment files are not already there
                 spm_jobman('run' , matlabbatch);  %run segment
         end
     end
 end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Pause to do ARTrepair on realigned files
        %Make sure to check threshold in art_global
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%
 %% NORMALIZE %%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%
 
if NORMALISATION_With_Segment
    disp('NORMALIZE')
    cd(TemplateFolder)
    clear matlabbatch
    load Normalize_with_Segment_IPD
    fileTemplate = 'vraf';
    
     for j=1:length(dataFolders)
        session_name=cell2mat(dataFolders(1,j));
        disp([ 'working on ',subsname(i,1).name '_' sess '_' session_name]);
        matlabbatch{1,1}.spm.spatial.normalise.write.subj.resample=''; %clear previous
        matlabbatch{1,1}.spm.spatial.normalise.write.subj.def='';
        
        d=dir([open_path '\anatomy\' session_name '\new_realign\y_SPGR_' session_name '.nii']);
        
        if ~isempty(d)
            files={d(1).name}';
            matlabbatch{1,1}.spm.spatial.normalise.write.subj.def=cellstr(strcat([open_path '\anatomy\' session_name '\new_realign\'] ,files));%load file names of files for preprocessing
            
            P='';
            session_fold=dir([open_path '\' session_name '\run_*' ]) ;
            session_fold_SD=dir([SD_path '\' session_name '\run_*' ]) ;
            total_runs=length(session_fold)+length(session_fold_SD);
            SD_ind=1;
            
            if (total_runs==4)
                for run=1:total_runs
                    if (run<=total_runs/2)
                        file_path=([open_path '\' session_name '\' session_fold(run,1).name '\new_realign\']);
                        d=dir([file_path '\' fileTemplate '*.nii']);    %load file names of files for preprocessing
                        x=dir([file_path  '\w' fileTemplate '*.nii']);
                    elseif run>total_runs/2 
                        file_path=([SD_path  session_name '\' session_fold_SD(SD_ind,1).name '\new_realign\']);
                        d=dir([file_path '\' fileTemplate '*.nii']);    %load file names of files for preprocessing
                        x=dir([file_path  '\w' fileTemplate '*.nii']);
                        SD_ind=SD_ind+1;
                    end
                    
                    if (~isempty(d) && isempty(x))
                        files={d.name}';
                        P = [P;  cellstr(strcat([file_path '\'] ,files,',1'))];
                    end
                end
            else
                disp(['not enough sessions for ', subsname(i,1).name])
                break
            end
        end
        
        if (~isempty(d) && isempty(x))
            matlabbatch{1,1}.spm.spatial.normalise.write.subj.resample=P;
            spm_jobman('run' , matlabbatch);
        end %run normalise
     end
     
      %% NORMALIZE SPGR
        disp('normalising SPGR');
        cd(TemplateFolder)
        clear matlabbatch
        clear d;
        load Normalize_1;
        for j=1:length(dataFolders)
            session_name=cell2mat(dataFolders(1,j));
            def=dir([open_path '\anatomy\' session_name '\new_realign\y_SPGR_' session_name '.nii']);
            d=dir([open_path '\anatomy\' session_name '\new_realign\mSPGR_' session_name '.nii']);     % Add the bias corrected SPGR to be normalised %%
            x=dir([open_path '\anatomy\' session_name '\new_realign\wms*.nii']);
            
            if isempty(x)
                if (~isempty(def) && ~isempty(d))
                    files={def.name}';
                    matlabbatch{1,1}.spm.spatial.normalise.write.subj.def=cellstr(strcat([open_path '\anatomy\' session_name '\new_realign\'] ,files));%load file names of files for preprocessing
                    files={d(1).name}';
                    matlabbatch{1,1}.spm.spatial.normalise.write.subj.resample=cellstr(strcat([open_path '\anatomy\' session_name '\new_realign\'] ,files));%load file names of files for preprocessing
                end
                
                if ~isempty(d)
                    spm_jobman('run', matlabbatch);
                end
            end
        end
end

                    
               

                       
% %%NORMALIZE NO SEGMENT%%%%%%%%%%%%%
% if NORMALISATION_No_Segment
%     disp('Normalize without segment')
%     cd(TemplateFolder)
%     clear matlabbatch
%     load normalize_No_Segment_IPD
%     
%     matlabbatch{1,1}.spm.spatial.normalise.estwrite.subj.resample = '';
%     fileTemplate = 'arf';
%     
%     cd(run1path)
%     norm_funcs =  spm_select('FPlist', pwd, '^arf.*nii')
%     cd(run2path)
%     norm_funcs = [norm_funcs;  spm_select('FPlist', pwd, '^arf.*nii')];
%    
%     
%     cd([run1path])
%     mean_image = spm_select('FPlist', pwd, '^mean.*nii');
%     
%     matlabbatch{1,1}.spm.spatial.normalise.estwrite.subj.vol = cellstr(mean_image);
%     matlabbatch{1,1}.spm.spatial.normalise.estwrite.subj.resample = cellstr(norm_funcs);
%     
% 
%      
%     
%     spm_jobman('run', matlabbatch); 
% end 

%%%%%%%%%%%%%%%%%%%%%%%
%% SMOOTH %%
%%%%%%%%%%%%%%%%%%%%%%%
if SMOOTH
    disp('SMOOTHING')
    cd(TemplateFolder)
    clear matlabbatch
    load smooth_thermal_6mm
    
    fileTemplate = 'wvraf';
    cd(open_path);
    
    for j=1:length(dataFolders) %collecting EPI files from all sessions
        matlabbatch{1,1}.spm.spatial.smooth.data='';
        session_name=cell2mat(dataFolders(1,j));
        P=''; run=0;d='';x='';
        disp([ 'working on ',subsname(i,1).name '_' sess '_' session_name]);
        session_fold=dir([open_path '\' session_name '\run_*' ]) ;    %look for task runs
        session_fold_SD=dir([SD_path '\' session_name '\run_*' ]) ; 
        total_runs=length(session_fold)+length(session_fold_SD);
        SD_ind=1;
        
        if total_runs==4
            for run=1:total_runs
                 if (run<=total_runs/2 && strcmp(session_fold(run,1).name(1:4),'run_'))%only go to epi folders
                    file_path=([open_path '\' session_name '\' session_fold(run,1).name '\new_realign\']);
                    d=dir([file_path '\' fileTemplate '*.nii']);    %load file names of files for preprocessing
                    x=dir([file_path  '\s' fileTemplate '*.nii']);
                elseif run>total_runs/2 && (strcmp(session_fold_SD(SD_ind,1).name(1:4),'run_'))
                    file_path=([SD_path '\' session_name '\' session_fold_SD(SD_ind,1).name '\new_realign\']);
                     d=dir([file_path '\' fileTemplate '*.nii']);    %load file names of files for preprocessing
                     x=dir([file_path  '\s' fileTemplate '*.nii']);
                    SD_ind=SD_ind+1;
                 end%check that files are not already processed
                
                 if (~isempty(d) && isempty(x)) %if finds niifiles but not processed files
                     files={d.name}';
                     P = [P;  cellstr(strcat([file_path '\'] ,files,',1'))];
                 end
                 
            end
        else
            disp(['not enough sessions for ', subsname(i,1).name])
            return
        end
           
    
    if ~isempty(d) && isempty(x)
        matlabbatch{1,1}.spm.spatial.smooth.data=P;
        spm_jobman('run', matlabbatch);
    end
    
     % *%%% Estimating the model %%*
%         if FLAG
%             if isempty(dir([outpath 'beta*']))
%                 cd(TemplateFolder)
%                 load  estimate_1st_level_adam
%                 matlabbatch{1,1}.spm.stats.fmri_est.spmmat=' ';
%                 matlabbatch{1,1}.spm.stats.fmri_est.spmmat=cellstr([outpath 'SPM.mat']);
%                 spm_jobman('run',matlabbatch);
%             else
%                 disp('SPM.mat already exists! Only adding contrasts');
%             end
%             clear matlabbatch
%    
%             %% Adding contrasts %%*
%             if isempty(dir([outpath 'con*']))
%                 
%                 cd(outpath)
%                 load([outpath 'SPM.mat'])
%                 SPM=add_contrasts_IPD_2sessions(SPM, size(R,2));
%                 
%             else
%                 disp('Contrasts already exist!');
%             end
%         end
        clear SPM;
    end
end
    end
end


    
    
    
    
    
    
    