clear all;

subjdir=('E:\AdamData\SANS Data\');%subject folders
cd(subjdir)
subsname=dir('Sub*');
session_name='IPD';
sess='SR';

OUTPUT_FLDR=['E:\AdamData\SANS Data\2ND LEVELS\IPD\Choice_Models\Monochoice_basic_model'];
%monochoice basic:
dataFolders={'CoopVSDefect', 'DefectVSCoop','ChoiceALLVSBaseline', 'CoopVSDefect_SR', 'DefectVSCoop_SR', 'ChoiceALLVSBaseline_SR','CoopVSDefect_SD', 'DefectVSCoop_SD', 'ChoiceALLVSBaseline_SD'};
ConNum={'01','02','03','04','05','06','07','08','09'};

%bichoice basic:
%dataFolders = {'CoopVSDefect','DefectVSCoop','ChoiceALLVSBaseline','CoopVSDefect_SR','DefectVSCoop_SR','ChoiceALLVSBaseline_SR','CoopVSDefect_SD','DefectVSCoop_SD','ChoiceALLVSBaseline_SD', 'CoopVSBaseline', 'DefectVSBaseline', 'CoopVSBaseline_SR', 'DefectVSBaseline_SR', 'CoopVSBaseline_SD', 'DefectVSBaseline_SD'};
%ConNum={'01','02','03','04','05','06','07','08','09','10','11','12','13','14','15'};



for i=1:length(subsname)
    
    if (strcmp(subsname(i,1).name(1:3),'Sub') && subsname(i,1).isdir==1)  
                                                                                    %change this 
        open_path=[subjdir '\' subsname(i,1).name '\' sess '\fMRI\' session_name '\1st_level_analysis_Choice_2sessions_monochoice\']; %from where to open files for processing in subject folders
    if isdir(open_path)
        cd(open_path);
%       
        disp([ 'working on ', subsname(i,1).name '_' sess '_' session_name]);
%             
         for jj=1 : length(dataFolders) 
            
            cd(OUTPUT_FLDR);
            new_fold=cell2mat(dataFolders(1,jj));
            if ~isdir([OUTPUT_FLDR '\' new_fold])
                mkdir(new_fold)
            end
             outpath=[OUTPUT_FLDR '\' cell2mat(dataFolders(1,jj)) '\']; 
             cd(open_path);
            set_fl_nii = dir([open_path 'con_00' cell2mat(ConNum(1,jj)) '.nii']);
            if ~isempty(set_fl_nii)      
                copyfile([open_path , set_fl_nii.name], [outpath, '\',subsname(i,1).name(end-2:end), '_' set_fl_nii.name]);
            else
                disp([ 'Cant find cons for ', subsname(i,1).name '_' sess '_' session_name]);
            end
            clear outpath; clear set_fl_nii;
         end
    else disp(['No Folder for current model for ', subsname(i,1).name '_' sess '_' session_name]);
    end
    end
    
end