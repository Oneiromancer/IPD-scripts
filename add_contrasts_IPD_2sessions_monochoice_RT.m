function SPM=add_contrasts_IPD_2sessions_monochoice_RT(SPM,N, subsname)
Excl_SDPRO_IDs = {'Sub103'};
Excl_SRANTI_IDs = {'Sub107';'Sub118';'Sub124';};
Excl_SRSDPRO_IDs = {'Sub112';'Sub120';'Sub122';};
Excl_SRPRO_IDs = {'Sub123';'Sub126';};
Excl_SDANTI_IDs = {'Sub113';};

%contrasts vectors are hard-coded for choice (all same length). 

%R=16 for compcor models 
%dealing out UniqueIDs
    if ismember(subsname, Excl_SDPRO_IDs) %103
        %%ChoiceALL, ChoiceType_paramod, R16 (x3 SRPRO SRANTI SDANTI)        
        % SR AND SD
        CoopVSDefect = [0 1 zeros(1,N) 0 1 zeros(1,N) 0 1 zeros(1,N) zeros(1,length(SPM.Sess))];
        DefectVSCoop = [0 -1 zeros(1,N) 0 -1 zeros(1,N) 0 -1 zeros(1,N) zeros(1,length(SPM.Sess))];
        ChoiceALLVSBaseline = [1 0 zeros(1,N) 1 0 zeros(1,N) 1 0 zeros(1,N) zeros(1,length(SPM.Sess))];
        
        %SR only 
        CoopVSDefect_SR = [0 1 zeros(1,N) 0 1 zeros(1,N) 0 0 zeros(1,N) zeros(1, length(SPM.Sess))];
        DefectVSCoop_SR = [0 -1 zeros(1,N) 0 -1 zeros(1,N) 0 0 zeros(1,N) zeros(1, length(SPM.Sess))];
        ChoiceALLVSBaseline_SR = [1 0 zeros(1,N) 1 0 zeros(1,N)  0 0 zeros(1, N) zeros(1, length(SPM.Sess))];
        
        %SD only 
        CoopVSDefect_SD = [0 0 zeros(1,N) 0 0 zeros(1,N) 0 1 zeros(1,N) zeros(1, length(SPM.Sess))];
        DefectVSCoop_SD = [0 0 zeros(1,N) 0 0 zeros(1,N) 0 -1 zeros(1,N) zeros(1, length(SPM.Sess))];
        ChoiceALLVSBaseline_SD = [0 0 zeros(1, N) 0 0 zeros(1, N) 1 0 zeros(1,N) zeros(1, length(SPM.Sess))];
       
        %SR vs SD 
        %CoopVSDefect_SRvsSD = [1 1 zeros(1,N) 1 1 zeros(1,N) -1 1 zeros(1,N) zeros(1, length(SPM.Sess))];
        %DefectVSCoop_SRvsSD = [1 -1 zeros(1,N) 1 -1 zeros(1,N) -1 -1 zeros(1,N) zeros(1, length(SPM.Sess))];
        %ChoiceALLVSBaseline_SRvsSD = [1 0 zeros(1,N) 1 0 zeros(1,N) -1 0 zeros(1,N) zeros(1, length(SPM.Sess))];
        
        contrasts(1) = struct('names', {{...
            'CoopVSDefect'...
            'DefectVSCoop'...
            'ChoiceALLVSBaseline',...
            'CoopVSDefect_SR'...
            'DefectVSCoop_SR'...
            'ChoiceALLVSBaseline_SR'...
            'CoopVSDefect_SD'...
            'DefectVSCoop_SD'...
            'ChoiceALLVSBaseline_SD'...
            
                }},...
                'types', {{'T','T','T','T','T','T','T','T','T'}}, ...
                'values',{{CoopVSDefect,DefectVSCoop,ChoiceALLVSBaseline,CoopVSDefect_SR,DefectVSCoop_SR,ChoiceALLVSBaseline_SR,CoopVSDefect_SD,DefectVSCoop_SD,ChoiceALLVSBaseline_SD}} ...
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif ismember(subsname, Excl_SRANTI_IDs) %107, 118, 124
        %%ChoiceALL, ChoiceType_paramod, R16 (x3 for SR/SD PRO/ANTI)        
        % SR AND SD
        CoopVSDefect = [0 1 zeros(1,N) 0 1 zeros(1,N) 0 1 zeros(1,N) zeros(1,length(SPM.Sess))];
        DefectVSCoop = [0 -1 zeros(1,N) 0 -1 zeros(1,N) 0 -1 zeros(1,N) zeros(1,length(SPM.Sess))];
        ChoiceALLVSBaseline = [1 0 zeros(1,N) 1 0 zeros(1,N) 1 0 zeros(1,N) zeros(1,length(SPM.Sess))];
        
        %SR only 
        CoopVSDefect_SR = [0 1 zeros(1,N) 0 0 zeros(1,N) 0 0 zeros(1,N) zeros(1, length(SPM.Sess))];
        DefectVSCoop_SR = [0 -1 zeros(1,N) 0 0 zeros(1,N) 0 0 zeros(1,N) zeros(1, length(SPM.Sess))];
        ChoiceALLVSBaseline_SR = [1 0 zeros(1,N) 0 0 zeros(1, N) 0 0 zeros(1, N) zeros(1, length(SPM.Sess))];
        
        %SD only 
        CoopVSDefect_SD = [0 0 zeros(1,N) 0 1 zeros(1,N) 0 1 zeros(1,N) zeros(1, length(SPM.Sess))];
        DefectVSCoop_SD = [0 0 zeros(1,N) 0 -1 zeros(1,N) 0 -1 zeros(1,N) zeros(1, length(SPM.Sess))];
        ChoiceALLVSBaseline_SD = [0 0 zeros(1, N) 1 0 zeros(1,N) 1 0 zeros(1,N) zeros(1, length(SPM.Sess))];
       
        %SR vs SD 
        %CoopVSDefect_SRvsSD = [1 1 zeros(1,N) -1 1 zeros(1,N) -1 1 zeros(1,N) zeros(1, length(SPM.Sess))];
        %DefectVSCoop_SRvsSD = [1 -1 zeros(1,N) -1 -1 zeros(1,N) -1 -1 zeros(1,N) zeros(1, length(SPM.Sess))];
        %ChoiceALLVSBaseline_SRvsSD = [1 0 zeros(1,N) -1 0 zeros(1,N) -1 0 zeros(1,N)  zeros(1, length(SPM.Sess))];
        
        contrasts(1) = struct('names', {{...
            'CoopVSDefect'...
            'DefectVSCoop'...
            'ChoiceALLVSBaseline',...
            'CoopVSDefect_SR'...
            'DefectVSCoop_SR'...
            'ChoiceALLVSBaseline_SR'...
            'CoopVSDefect_SD'...
            'DefectVSCoop_SD'...
            'ChoiceALLVSBaseline_SD'...
            
                }},...
                'types', {{'T','T','T','T','T','T','T','T','T'}}, ...
                'values',{{CoopVSDefect,DefectVSCoop,ChoiceALLVSBaseline,CoopVSDefect_SR,DefectVSCoop_SR,ChoiceALLVSBaseline_SR,CoopVSDefect_SD,DefectVSCoop_SD,ChoiceALLVSBaseline_SD}} ...
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif ismember(subsname, Excl_SRSDPRO_IDs) %112, 120, 122
        %%ChoiceALL, ChoiceType_paramod, R16 (x2 for SR/SD ANTI)        
        % SR AND SD
        CoopVSDefect = [0 1 zeros(1,N) 0 1 zeros(1,N) zeros(1,length(SPM.Sess))];
        DefectVSCoop = [0 -1 zeros(1,N) 0 -1 zeros(1,N) zeros(1,length(SPM.Sess))];
        ChoiceALLVSBaseline = [1 0 zeros(1,N) 1 0 zeros(1,N) zeros(1,length(SPM.Sess))];
        
        %SR only 
        CoopVSDefect_SR = [0 1 zeros(1,N) 0 0 zeros(1,N) zeros(1, length(SPM.Sess))];
        DefectVSCoop_SR = [0 -1 zeros(1,N) 0 0 zeros(1,N) zeros(1, length(SPM.Sess))];
        ChoiceALLVSBaseline_SR = [1 0 zeros(1,N)  0 0 zeros(1, N) zeros(1, length(SPM.Sess))];
        
        %SD only 
        CoopVSDefect_SD = [0 0 zeros(1,N) 0 1 zeros(1,N) zeros(1, length(SPM.Sess))];
        DefectVSCoop_SD = [0 0 zeros(1,N) 0 -1 zeros(1,N) zeros(1, length(SPM.Sess))];
        ChoiceALLVSBaseline_SD = [0 0 zeros(1, N) 1 0 zeros(1,N) zeros(1, length(SPM.Sess))];
       
        %SR vs SD 
        %CoopVSDefect_SRvsSD = [1 1 zeros(1,N) -1 1 zeros(1,N) zeros(1, length(SPM.Sess))];
        %DefectVSCoop_SRvsSD = [1 -1 zeros(1,N) -1 -1 zeros(1,N) zeros(1, length(SPM.Sess))];
        %ChoiceALLVSBaseline_SRvsSD = [1 0 zeros(1,N) -1 0 zeros(1,N)  zeros(1, length(SPM.Sess))];
        
        contrasts(1) = struct('names', {{...
            'CoopVSDefect'...
            'DefectVSCoop'...
            'ChoiceALLVSBaseline',...
            'CoopVSDefect_SR'...
            'DefectVSCoop_SR'...
            'ChoiceALLVSBaseline_SR'...
            'CoopVSDefect_SD'...
            'DefectVSCoop_SD'...
            'ChoiceALLVSBaseline_SD'...
            
                }},...
                'types', {{'T','T','T','T','T','T','T','T','T'}}, ...
                'values',{{CoopVSDefect,DefectVSCoop,ChoiceALLVSBaseline,CoopVSDefect_SR,DefectVSCoop_SR,ChoiceALLVSBaseline_SR,CoopVSDefect_SD,DefectVSCoop_SD,ChoiceALLVSBaseline_SD}} ...
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif ismember(subsname, Excl_SRPRO_IDs) %123, 126
        %%ChoiceALL, ChoiceType_paramod, R16 (x3 for SRANTI SD PRO/ANTI)        
        % SR AND SD
        CoopVSDefect = [0 1 zeros(1,N) 0 1 zeros(1,N) 0 1 zeros(1,N) zeros(1,length(SPM.Sess))];
        DefectVSCoop = [0 -1 zeros(1,N) 0 -1 zeros(1,N) 0 -1 zeros(1,N) zeros(1,length(SPM.Sess))];
        ChoiceALLVSBaseline = [1 0 zeros(1,N) 1 0 zeros(1,N) 1 0 zeros(1,N) zeros(1,length(SPM.Sess))];
        
        %SR only 
        CoopVSDefect_SR = [0 1 zeros(1,N) 0 0 zeros(1,N) 0 0 zeros(1,N) zeros(1, length(SPM.Sess))];
        DefectVSCoop_SR = [0 -1 zeros(1,N) 0 0 zeros(1,N) 0 0 zeros(1,N) zeros(1, length(SPM.Sess))];
        ChoiceALLVSBaseline_SR = [1 0 zeros(1,N)  0 0 zeros(1, N) 0 0 zeros(1, N) zeros(1, length(SPM.Sess))];
        
        %SD only 
        CoopVSDefect_SD = [0 0 zeros(1,N) 0 1 zeros(1,N) 0 1 zeros(1,N) zeros(1, length(SPM.Sess))];
        DefectVSCoop_SD = [0 0 zeros(1,N) 0 -1 zeros(1,N) 0 -1 zeros(1,N) zeros(1, length(SPM.Sess))];
        ChoiceALLVSBaseline_SD = [0 0 zeros(1, N) 1 0 zeros(1,N) 1 0 zeros(1,N) zeros(1, length(SPM.Sess))];
       
        %SR vs SD 
        %CoopVSDefect_SRvsSD = [1 1 zeros(1,N) -1 1 zeros(1,N) -1 1 zeros(1,N) zeros(1, length(SPM.Sess))];
        %DefectVSCoop_SRvsSD = [1 -1 zeros(1,N) -1 -1 zeros(1,N) -1 -1 zeros(1,N) zeros(1, length(SPM.Sess))];
        %ChoiceALLVSBaseline_SRvsSD = [1 0 zeros(1,N) -1 0 zeros(1,N) -1 0 zeros(1,N)  zeros(1, length(SPM.Sess))];
        
        contrasts(1) = struct('names', {{...
            'CoopVSDefect'...
            'DefectVSCoop'...
            'ChoiceALLVSBaseline',...
            'CoopVSDefect_SR'...
            'DefectVSCoop_SR'...
            'ChoiceALLVSBaseline_SR'...
            'CoopVSDefect_SD'...
            'DefectVSCoop_SD'...
            'ChoiceALLVSBaseline_SD'...
            
                }},...
                'types', {{'T','T','T','T','T','T','T','T','T'}}, ...
                'values',{{CoopVSDefect,DefectVSCoop,ChoiceALLVSBaseline,CoopVSDefect_SR,DefectVSCoop_SR,ChoiceALLVSBaseline_SR,CoopVSDefect_SD,DefectVSCoop_SD,ChoiceALLVSBaseline_SD}} ...
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif ismember(subsname, Excl_SDANTI_IDs) %113
        %%ChoiceALL, ChoiceType_paramod, R16 (x3 for SR PRO/ANTI SDPRO)        
        % SR AND SD
        CoopVSDefect = [0 1 zeros(1,N) 0 1 zeros(1,N) 0 1 zeros(1,N) zeros(1,length(SPM.Sess))];
        DefectVSCoop = [0 -1 zeros(1,N) 0 -1 zeros(1,N) 0 -1 zeros(1,N) zeros(1,length(SPM.Sess))];
        ChoiceALLVSBaseline = [1 0 zeros(1,N) 1 0 zeros(1,N) 1 0 zeros(1,N) zeros(1,length(SPM.Sess))];
        
        %SR only 
        CoopVSDefect_SR = [0 1 zeros(1,N) 0 1 zeros(1,N) 0 0 zeros(1,N) zeros(1, length(SPM.Sess))];
        DefectVSCoop_SR = [0 -1 zeros(1,N) 0 -1 zeros(1,N) 0 0 zeros(1,N) zeros(1, length(SPM.Sess))];
        ChoiceALLVSBaseline_SR = [1 0 zeros(1,N) 1 0 zeros(1,N) 0 0 zeros(1, N) zeros(1, length(SPM.Sess))];
        
        %SD only 
        CoopVSDefect_SD = [0 0 zeros(1,N) 0 0 zeros(1,N) 0 1 zeros(1,N) zeros(1, length(SPM.Sess))];
        DefectVSCoop_SD = [0 0 zeros(1,N) 0 0 zeros(1,N) 0 -1 zeros(1,N) zeros(1, length(SPM.Sess))];
        ChoiceALLVSBaseline_SD = [0 0 zeros(1, N) 0 0 zeros(1, N) 1 0 zeros(1,N) zeros(1, length(SPM.Sess))];
       
        %SR vs SD 
        %CoopVSDefect_SRvsSD = [1 1 zeros(1,N) 1 1 zeros(1,N) -1 1 zeros(1,N) zeros(1, length(SPM.Sess))];
        %DefectVSCoop_SRvsSD = [1 -1 zeros(1,N) 1 -1 zeros(1,N) -1 -1 zeros(1,N) zeros(1, length(SPM.Sess))];
        %ChoiceALLVSBaseline_SRvsSD = [1 0 zeros(1,N) 1 0 zeros(1,N) -1 0 zeros(1,N)  zeros(1, length(SPM.Sess))];
        
        contrasts(1) = struct('names', {{...
            'CoopVSDefect'...
            'DefectVSCoop'...
            'ChoiceALLVSBaseline',...
            'CoopVSDefect_SR'...
            'DefectVSCoop_SR'...
            'ChoiceALLVSBaseline_SR'...
            'CoopVSDefect_SD'...
            'DefectVSCoop_SD'...
            'ChoiceALLVSBaseline_SD'...
            
                }},...
                'types', {{'T','T','T','T','T','T','T','T','T'}}, ...
                'values',{{CoopVSDefect,DefectVSCoop,ChoiceALLVSBaseline,CoopVSDefect_SR,DefectVSCoop_SR,ChoiceALLVSBaseline_SR,CoopVSDefect_SD,DefectVSCoop_SD,ChoiceALLVSBaseline_SD}} ...
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    else %do regular 4 runs below: 
        %%ChoiceALL, ChoiceType_paramod, R16 (x4 for SR/SD PRO/ANTI)        
        % SR AND SD
        CoopVSDefect = [0 1 zeros(1,N) 0 1 zeros(1,N) 0 1 zeros(1,N) 0 1 zeros(1,N) zeros(1,length(SPM.Sess))];
        DefectVSCoop = [0 -1 zeros(1,N) 0 -1 zeros(1,N) 0 -1 zeros(1,N) 0 -1 zeros(1,N) zeros(1,length(SPM.Sess))];
        ChoiceALLVSBaseline = [1 0 zeros(1,N) 1 0 zeros(1,N) 1 0 zeros(1,N) 1 0 zeros(1,N) zeros(1,length(SPM.Sess))];

        %SR only 
        CoopVSDefect_SR = [0 1 zeros(1,N) 0 1 zeros(1,N) 0 0 zeros(1,N) 0 0 zeros(1,N) zeros(1, length(SPM.Sess))];
        DefectVSCoop_SR = [0 -1 zeros(1,N) 0 -1 zeros(1,N) 0 0 zeros(1,N) 0 0 zeros(1,N) zeros(1, length(SPM.Sess))];
        ChoiceALLVSBaseline_SR = [1 0 zeros(1,N) 1 0 zeros(1,N)  0 0 zeros(1, N) 0 0 zeros(1, N) zeros(1, length(SPM.Sess))];
        
        %SD only 
        CoopVSDefect_SD = [0 0 zeros(1,N) 0 0 zeros(1,N) 0 1 zeros(1,N) 0 1 zeros(1,N) zeros(1, length(SPM.Sess))];
        DefectVSCoop_SD = [0 0 zeros(1,N) 0 0 zeros(1,N) 0 -1 zeros(1,N) 0 -1 zeros(1,N) zeros(1, length(SPM.Sess))];
        ChoiceALLVSBaseline_SD = [0 0 zeros(1, N) 0 0 zeros(1, N) 1 0 zeros(1,N) 1 0 zeros(1,N) zeros(1, length(SPM.Sess))];
       
        %SR vs SD %ajk note: below is not fixed. Will make SRvsSD in 2nd
        %level
        %CoopVSDefect_SRvsSD = [1 1 zeros(1,N) 1 1 zeros(1,N) -1 1 zeros(1,N) -1 1 zeros(1,N) zeros(1, length(SPM.Sess))];
        %DefectVSCoop_SRvsSD = [1 -1 zeros(1,N) 1 -1 zeros(1,N) -1 -1 zeros(1,N) -1 -1 zeros(1,N) zeros(1, length(SPM.Sess))];
        %ChoiceALLVSBaseline_SRvsSD = [1 0 zeros(1,N) 1 0 zeros(1,N) -1 0 zeros(1,N) -1 0 zeros(1,N)  zeros(1, length(SPM.Sess))];
        
        contrasts(1) = struct('names', {{...
            'CoopVSDefect'...
            'DefectVSCoop'...
            'ChoiceALLVSBaseline',...
            'CoopVSDefect_SR'...
            'DefectVSCoop_SR'...
            'ChoiceALLVSBaseline_SR'...
            'CoopVSDefect_SD'...
            'DefectVSCoop_SD'...
            'ChoiceALLVSBaseline_SD'...
            
                }},...
                'types', {{'T','T','T','T','T','T','T','T','T'}}, ...
                'values',{{CoopVSDefect,DefectVSCoop,ChoiceALLVSBaseline,CoopVSDefect_SR,DefectVSCoop_SR,ChoiceALLVSBaseline_SR,CoopVSDefect_SD,DefectVSCoop_SD,ChoiceALLVSBaseline_SD}} ...
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
    end
