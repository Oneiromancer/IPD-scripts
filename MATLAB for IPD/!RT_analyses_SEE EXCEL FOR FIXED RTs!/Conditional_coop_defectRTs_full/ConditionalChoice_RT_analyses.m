%script to calculate reaction time for 4 events
%Rt of Player COOP following Partner COOP
%RT of Player COOP following Partner DEFECT
%RT of Player DEFECT following Partner COOP
%RT of Player COOP following Partner DEFECT


%all choice RT data
%%
%RT based on 1-back partner choice.
%ALL PARTNER CHOICES
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Raw_Partner_Choices_ALL.mat')
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\!RT_analyses_SEE EXCEL FOR FIXED RTs!\Player_Choice_RTs_fixed_sep_by_condition_and_partner.mat');
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Raw_Choices_ALL_row_per_subj.mat')

%SR PRO
SR_PRO_prior_coop_ChoiceRT = zeros(25,2); %col1=CC=Player coops %col2=DC=Player defects
SR_PRO_prior_defect_ChoiceRT = zeros(25,2); %col1=CD=Player coops %col2=DD=Player defects

for sub=1:25
    CC_RT_counter=[]; 
    CD_RT_counter=[];%Player coops following Partner D
    DC_RT_counter=[];%Player defects following partner C
    DD_RT_counter=[];    
    for i=1:(length(Raw_Partner_Choices_SR_PRO(sub,:)) - 1)
        if Raw_Partner_Choices_SR_PRO(sub,i)==0 %partner prior coop
            %how does the player respond?
            if Raw_Choices_SR_PRO(sub,i+1) == 0 %player cooped in response to partner coop
                CC_RT_counter = [CC_RT_counter, SR_PRO_PlayerChoice_RT(sub,i+1)]; %find corresponding choice RT
            else %player defected in response to partner coop
                DC_RT_counter = [DC_RT_counter, SR_PRO_PlayerChoice_RT(sub,i+1)]; 
            end
        elseif Raw_Partner_Choices_SR_PRO(sub,i)==1 %Partner defected
            if Raw_Choices_SR_PRO(sub,i+1)==0 %player cooped in response to partner defect
                CD_RT_counter = [CD_RT_counter, SR_PRO_PlayerChoice_RT(sub,i+1)];
            else %player defected in response to partner defection
                DD_RT_counter = [DD_RT_counter, SR_PRO_PlayerChoice_RT(sub,i+1)];
            end
        end
    end
    %save counters
    SR_PRO_prior_coop_ChoiceRT(sub,1) = nanmean(CC_RT_counter(CC_RT_counter>0));
    SR_PRO_prior_coop_ChoiceRT(sub,2) = nanmean(DC_RT_counter(DC_RT_counter>0));
    SR_PRO_prior_defect_ChoiceRT(sub,1) = nanmean(CD_RT_counter(CD_RT_counter>0));
    SR_PRO_prior_defect_ChoiceRT(sub,2) = nanmean(DD_RT_counter(DD_RT_counter>0));
end

%SD PRO
SD_PRO_prior_coop_ChoiceRT = zeros(25,2); %col1=CC=Player coops %col2=DC=Player defects
SD_PRO_prior_defect_ChoiceRT = zeros(25,2); %col1=CD=Player coops %col2=DD=Player defects

for sub=1:25
    CC_RT_counter=[]; 
    CD_RT_counter=[];%Player coops following Partner D
    DC_RT_counter=[];%Player defects following partner C
    DD_RT_counter=[];    
    for i=1:(length(Raw_Partner_Choices_SD_PRO(sub,:)) - 1)
        if Raw_Partner_Choices_SD_PRO(sub,i)==0 %partner prior coop
            %how does the player respond?
            if Raw_Choices_SD_PRO(sub,i+1) == 0 %player cooped in response to partner coop
                CC_RT_counter = [CC_RT_counter, SD_PRO_PlayerChoice_RT(sub,i+1)]; %find corresponding choice RT
            else %player defected in response to partner coop
                DC_RT_counter = [DC_RT_counter, SD_PRO_PlayerChoice_RT(sub,i+1)]; 
            end
        elseif Raw_Partner_Choices_SD_PRO(sub,i)==1 %Partner defected
            if Raw_Choices_SD_PRO(sub,i+1)==0 %player cooped in response to partner defect
                CD_RT_counter = [CD_RT_counter, SD_PRO_PlayerChoice_RT(sub,i+1)];
            else %player defected in response to partner defection
                DD_RT_counter = [DD_RT_counter, SD_PRO_PlayerChoice_RT(sub,i+1)];
            end
        end
    end
    %save counters
    SD_PRO_prior_coop_ChoiceRT(sub,1) = nanmean(CC_RT_counter(CC_RT_counter>0));
    SD_PRO_prior_coop_ChoiceRT(sub,2) = nanmean(DC_RT_counter(DC_RT_counter>0));
    SD_PRO_prior_defect_ChoiceRT(sub,1) = nanmean(CD_RT_counter(CD_RT_counter>0));
    SD_PRO_prior_defect_ChoiceRT(sub,2) = nanmean(DD_RT_counter(DD_RT_counter>0));
end

%SR ANTI
SR_ANTI_prior_coop_ChoiceRT = zeros(25,2); %col1=CC=Player coops %col2=DC=Player defects
SR_ANTI_prior_defect_ChoiceRT = zeros(25,2); %col1=CD=Player coops %col2=DD=Player defects

for sub=1:25
    CC_RT_counter=[]; 
    CD_RT_counter=[];%Player coops following Partner D
    DC_RT_counter=[];%Player defects following partner C
    DD_RT_counter=[];    
    for i=1:(length(Raw_Partner_Choices_SR_ANTI(sub,:)) - 1)
        if Raw_Partner_Choices_SR_ANTI(sub,i)==0 %partner prior coop
            %how does the player respond?
            if Raw_Choices_SR_ANTI(sub,i+1) == 0 %player cooped in response to partner coop
                CC_RT_counter = [CC_RT_counter, SR_ANTI_PlayerChoice_RT(sub,i+1)]; %find corresponding choice RT
            else %player defected in response to partner coop
                DC_RT_counter = [DC_RT_counter, SR_ANTI_PlayerChoice_RT(sub,i+1)]; 
            end
        elseif Raw_Partner_Choices_SR_ANTI(sub,i)==1 %Partner defected
            if Raw_Choices_SR_ANTI(sub,i+1)==0 %player cooped in response to partner defect
                CD_RT_counter = [CD_RT_counter, SR_ANTI_PlayerChoice_RT(sub,i+1)];
            else %player defected in response to partner defection
                DD_RT_counter = [DD_RT_counter, SR_ANTI_PlayerChoice_RT(sub,i+1)];
            end
        end
    end
    %save counters
    SR_ANTI_prior_coop_ChoiceRT(sub,1) = nanmean(CC_RT_counter(CC_RT_counter>0));
    SR_ANTI_prior_coop_ChoiceRT(sub,2) = nanmean(DC_RT_counter(DC_RT_counter>0));
    SR_ANTI_prior_defect_ChoiceRT(sub,1) = nanmean(CD_RT_counter(CD_RT_counter>0));
    SR_ANTI_prior_defect_ChoiceRT(sub,2) = nanmean(DD_RT_counter(DD_RT_counter>0));
end

%SD ANTI
SD_ANTI_prior_coop_ChoiceRT = zeros(25,2); %col1=CC=Player coops %col2=DC=Player defects
SD_ANTI_prior_defect_ChoiceRT = zeros(25,2); %col1=CD=Player coops %col2=DD=Player defects

for sub=1:25
    CC_RT_counter=[]; 
    CD_RT_counter=[];%Player coops following Partner D
    DC_RT_counter=[];%Player defects following partner C
    DD_RT_counter=[];    
    for i=1:(length(Raw_Partner_Choices_SD_ANTI(sub,:)) - 1)
        if Raw_Partner_Choices_SD_ANTI(sub,i)==0 %partner prior coop
            %how does the player respond?
            if Raw_Choices_SD_ANTI(sub,i+1) == 0 %player cooped in response to partner coop
                CC_RT_counter = [CC_RT_counter, SD_ANTI_PlayerChoice_RT(sub,i+1)]; %find corresponding choice RT
            else %player defected in response to partner coop
                DC_RT_counter = [DC_RT_counter, SD_ANTI_PlayerChoice_RT(sub,i+1)]; 
            end
        elseif Raw_Partner_Choices_SD_ANTI(sub,i)==1 %Partner defected
            if Raw_Choices_SD_ANTI(sub,i+1)==0 %player cooped in response to partner defect
                CD_RT_counter = [CD_RT_counter, SD_ANTI_PlayerChoice_RT(sub,i+1)];
            else %player defected in response to partner defection
                DD_RT_counter = [DD_RT_counter, SD_ANTI_PlayerChoice_RT(sub,i+1)];
            end
        end
    end
    %save counters
    SD_ANTI_prior_coop_ChoiceRT(sub,1) = nanmean(CC_RT_counter(CC_RT_counter>0));
    SD_ANTI_prior_coop_ChoiceRT(sub,2) = nanmean(DC_RT_counter(DC_RT_counter>0));
    SD_ANTI_prior_defect_ChoiceRT(sub,1) = nanmean(CD_RT_counter(CD_RT_counter>0));
    SD_ANTI_prior_defect_ChoiceRT(sub,2) = nanmean(DD_RT_counter(DD_RT_counter>0));
end

%%
%plotting
%SRvsSD ANTIPRO CC
mean_CC_RT_SR_ANTIPRO = nanmean([SR_PRO_prior_coop_ChoiceRT(:,1); SR_ANTI_prior_coop_ChoiceRT(:,1)]);
mean_CC_RT_SD_ANTIPRO = nanmean([SD_PRO_prior_coop_ChoiceRT(:,1); SD_ANTI_prior_coop_ChoiceRT(:,1)]);
mean_DC_RT_SR_ANTIPRO = nanmean([SR_PRO_prior_coop_ChoiceRT(:,2); SR_ANTI_prior_coop_ChoiceRT(:,2)]);
mean_DC_RT_SD_ANTIPRO = nanmean([SD_PRO_prior_coop_ChoiceRT(:,2); SD_ANTI_prior_coop_ChoiceRT(:,2)]);
mean_CD_RT_SR_ANTIPRO = nanmean([SR_PRO_prior_defect_ChoiceRT(:,1); SR_ANTI_prior_coop_ChoiceRT(:,1)]);
mean_CD_RT_SD_ANTIPRO = nanmean([SD_PRO_prior_defect_ChoiceRT(:,1); SD_ANTI_prior_coop_ChoiceRT(:,1)]);
mean_DD_RT_SR_ANTIPRO = nanmean([SR_PRO_prior_defect_ChoiceRT(:,2); SR_ANTI_prior_coop_ChoiceRT(:,2)]);
mean_DD_RT_SD_ANTIPRO = nanmean([SD_PRO_prior_defect_ChoiceRT(:,2); SD_ANTI_prior_coop_ChoiceRT(:,2)]);

se_CC_RT_SR_ANTIPRO = nanstd([SR_PRO_prior_coop_ChoiceRT(:,1); SR_ANTI_prior_coop_ChoiceRT(:,1)])/sqrt(50);
se_CC_RT_SD_ANTIPRO = nanstd([SD_PRO_prior_coop_ChoiceRT(:,1); SD_ANTI_prior_coop_ChoiceRT(:,1)])/sqrt(50);
se_DC_RT_SR_ANTIPRO = nanstd([SR_PRO_prior_coop_ChoiceRT(:,2); SR_ANTI_prior_coop_ChoiceRT(:,2)])/sqrt(50);
se_DC_RT_SD_ANTIPRO = nanstd([SD_PRO_prior_coop_ChoiceRT(:,2); SD_ANTI_prior_coop_ChoiceRT(:,2)])/sqrt(50);
se_CD_RT_SR_ANTIPRO = nanstd([SR_PRO_prior_defect_ChoiceRT(:,1); SR_ANTI_prior_defect_ChoiceRT(:,1)])/sqrt(50);
se_CD_RT_SD_ANTIPRO = nanstd([SD_PRO_prior_defect_ChoiceRT(:,1); SD_ANTI_prior_defect_ChoiceRT(:,1)])/sqrt(50);
se_DD_RT_SR_ANTIPRO = nanstd([SR_PRO_prior_defect_ChoiceRT(:,2); SR_ANTI_prior_defect_ChoiceRT(:,2)])/sqrt(50);
se_DD_RT_SD_ANTIPRO = nanstd([SD_PRO_prior_defect_ChoiceRT(:,2); SD_ANTI_prior_defect_ChoiceRT(:,2)])/sqrt(50);

%antipro CC
figure;barwitherr([se_CC_RT_SR_ANTIPRO, se_CC_RT_SD_ANTIPRO], [mean_CC_RT_SR_ANTIPRO, mean_CC_RT_SD_ANTIPRO])
 ylabel('Mean RT (ms)'); set(gca, 'xticklabel', {'SR ANTI+PRO', 'SD ANTI+PRO'}); title({'SR vs SD', 'Cooperative Choice RT following Partner Cooperation', 'ANTI + PRO'});
%  ylim([3000, 5500]);
%antipro DC
figure;barwitherr([se_DC_RT_SR_ANTIPRO, se_DC_RT_SD_ANTIPRO], [mean_DC_RT_SR_ANTIPRO, mean_DC_RT_SD_ANTIPRO])
 ylabel('Mean RT (ms)'); set(gca, 'xticklabel', {'SR ANTI+PRO', 'SD ANTI+PRO'}); title({'SR vs SD', 'Defection Choice RT following Partner Cooperation', 'ANTI + PRO'});
%  ylim([3000, 5500]);
%antipro CD
figure;barwitherr([se_CD_RT_SR_ANTIPRO, se_CD_RT_SD_ANTIPRO], [mean_CD_RT_SR_ANTIPRO, mean_CD_RT_SD_ANTIPRO])
 ylabel('Mean RT (ms)'); set(gca, 'xticklabel', {'SR ANTI+PRO', 'SD ANTI+PRO'}); title({'SR vs SD', 'Cooperative Choice RT following Partner Defection', 'ANTI + PRO'});
%  ylim([3000, 5500]);
%antipro DD
figure;barwitherr([se_DD_RT_SR_ANTIPRO, se_DD_RT_SD_ANTIPRO], [mean_DD_RT_SR_ANTIPRO, mean_DD_RT_SD_ANTIPRO])
ylabel('Mean RT (ms)'); set(gca, 'xticklabel', {'SR ANTI+PRO', 'SD ANTI+PRO'}); title({'SR vs SD', 'Defection Choice RT following Partner Defection', 'ANTI + PRO'});
% ylim([3000, 5500]); 

