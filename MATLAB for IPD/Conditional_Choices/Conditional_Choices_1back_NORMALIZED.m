%%1-back Coop counter normalized to total instances per subject of each
%NOTE: !this is only showing player cooperations. Need to mirror all this
%for player defections!

%%partner choice type
%Load Raw Choices for Player and Partner
%ALL PLAYER CHOICES
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Raw_Choices_ALL_row_per_subj.mat');
%ALL PARTNER CHOICES
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Raw_Partner_Choices_ALL.mat')
%player conditional choice raw count
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Conditional_Choices\1back_conditional_choices_ALL.mat');

%%
%SR PRO 
SR_PRO_0_100_perc_prior_coop_NORM = zeros(25,2);
for sub=1:25
    %normalize prior defections - 0%
    SR_PRO_0_100_perc_prior_coop_NORM(sub,1) = 100*(SR_PRO_0_100perc_prior_coop(sub,1) / nansum(Raw_Partner_Choices_SR_PRO(sub,:)));
    %normalize prior cooperations - 100%
    SR_PRO_0_100_perc_prior_coop_NORM(sub,2) = 100*(SR_PRO_0_100perc_prior_coop(sub,2) / (16-nansum(Raw_Partner_Choices_SR_PRO(sub,:))));
end
%SD PRO 
SD_PRO_0_100_perc_prior_coop_NORM = zeros(25,2);
for sub=1:25
    %normalize prior defections - 0%
    SD_PRO_0_100_perc_prior_coop_NORM(sub,1) = 100*(SD_PRO_0_100perc_prior_coop(sub,1) / nansum(Raw_Partner_Choices_SD_PRO(sub,:)));
    %normalize prior cooperations - 100%
    SD_PRO_0_100_perc_prior_coop_NORM(sub,2) = 100*(SD_PRO_0_100perc_prior_coop(sub,2) / (16-nansum(Raw_Partner_Choices_SD_PRO(sub,:))));
end
%SR ANTI 
SR_ANTI_0_100_perc_prior_coop_NORM = zeros(25,2);
for sub=1:25
    %normalize prior defections - 0%
    SR_ANTI_0_100_perc_prior_coop_NORM(sub,1) = 100*(SR_ANTI_0_100perc_prior_coop(sub,1) / nansum(Raw_Partner_Choices_SR_ANTI(sub,:)));
    %normalize prior cooperations - 100%
    SR_ANTI_0_100_perc_prior_coop_NORM(sub,2) = 100*(SR_ANTI_0_100perc_prior_coop(sub,2) / (16-nansum(Raw_Partner_Choices_SR_ANTI(sub,:))));
end
%SD ANTI
SD_ANTI_0_100_perc_prior_coop_NORM = zeros(25,2);
for sub=1:25
    %normalize prior defections - 0%
    SD_ANTI_0_100_perc_prior_coop_NORM(sub,1) = 100*(SD_ANTI_0_100perc_prior_coop(sub,1) / nansum(Raw_Partner_Choices_SD_ANTI(sub,:)));
    %normalize prior cooperations - 100%
    SD_ANTI_0_100_perc_prior_coop_NORM(sub,2) = 100*(SD_ANTI_0_100perc_prior_coop(sub,2) / (16-nansum(Raw_Partner_Choices_SD_ANTI(sub,:))));
end

%%
%plotting and ttests 
%SR ANTIPRO vs SD ANTIPRO
SR_ANTIPRO_means_NORM = nanmean([SR_PRO_0_100_perc_prior_coop_NORM; SR_ANTI_0_100_perc_prior_coop_NORM]);
SR_ANTIPRO_se_NORM = nanstd([SR_PRO_0_100_perc_prior_coop_NORM; SR_ANTI_0_100_perc_prior_coop_NORM]) / sqrt(25);

SR_PRO_means_NORM = nanmean(SR_PRO_0_100_perc_prior_coop_NORM);
SR_PRO_se_NORM = nanstd(SR_PRO_0_100_perc_prior_coop_NORM)/sqrt(25);

SD_ANTIPRO_means_NORM = nanmean([SD_PRO_0_100_perc_prior_coop_NORM; SD_ANTI_0_100_perc_prior_coop_NORM]);
SD_ANTIPRO_se_NORM = nanstd([SD_PRO_0_100_perc_prior_coop_NORM; SD_ANTI_0_100_perc_prior_coop_NORM]) / sqrt(25);

SD_PRO_means_NORM = nanmean(SD_PRO_0_100_perc_prior_coop_NORM);
SD_PRO_se_NORM = nanstd(SD_PRO_0_100_perc_prior_coop_NORM)/sqrt(25);

%prior coop
[h,p]=ttest([SR_PRO_0_100_perc_prior_coop_NORM(:,2); SR_ANTI_0_100_perc_prior_coop_NORM(:,2)], [SD_PRO_0_100_perc_prior_coop_NORM(:,2); SD_ANTI_0_100_perc_prior_coop_NORM(:,2)]);
display(p)
%prior defect
[h,p]=ttest([SR_PRO_0_100_perc_prior_coop_NORM(:,1); SR_ANTI_0_100_perc_prior_coop_NORM(:,1)], [SD_PRO_0_100_perc_prior_coop_NORM(:,1); SD_ANTI_0_100_perc_prior_coop_NORM(:,1)]);
display(p)

figure;
barwitherr([SR_PRO_se_NORM; SD_PRO_se_NORM], [SR_PRO_means_NORM; SD_PRO_means_NORM]);
ylabel('%-Cooperate Choices by Player');
set(gca, 'xticklabel', {'SR PRO', 'SD PRO'});
legend('Prior Partner Defect', 'Prior Partner Coop');
title({'SR vs. SD (PRO)', '1-back Conditional Cooperation Percent'})

figure;
barwitherr([SR_ANTIPRO_se_NORM; SD_ANTIPRO_se_NORM], [SR_ANTIPRO_means_NORM; SD_ANTIPRO_means_NORM]);
ylabel('%-Cooperate Choices by Player');
set(gca, 'xticklabel', {'SR ANTI+PRO', 'SD ANTI+PRO'});
legend('Prior Partner Defect', 'Prior Partner Coop');
title({'SR vs. SD (ANTI + PRO)', '1-back Conditional Cooperation Percent'})

%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%normalize counted conditional defections 
clear
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Raw_Choices_ALL_row_per_subj.mat');
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Conditional_Choices\1back_conditonal_defections_ALL.mat');
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Raw_Partner_Choices_ALL.mat')

%SR PRO 
SR_PRO_0_100_perc_prior_coop_defectioncount_NORM = zeros(25,2);
for sub=1:25
    %normalize prior defections - 0%
    SR_PRO_0_100_perc_prior_coop_defectioncount_NORM(sub,1) = 100*(SR_PRO_0_100perc_prior_coop_defectioncount(sub,1) / nansum(Raw_Partner_Choices_SR_PRO(sub,:)));
    %normalize prior cooperations - 100%
    SR_PRO_0_100_perc_prior_coop_defectioncount_NORM(sub,2) = 100*(SR_PRO_0_100perc_prior_coop_defectioncount(sub,2) / (16-nansum(Raw_Partner_Choices_SR_PRO(sub,:))));
end
%SD PRO 
SD_PRO_0_100_perc_prior_coop_defectioncount_NORM = zeros(25,2);
for sub=1:25
    %normalize prior defections - 0%
    SD_PRO_0_100_perc_prior_coop_defectioncount_NORM(sub,1) = 100*(SD_PRO_0_100perc_prior_coop_defectioncount(sub,1) / sum(Raw_Partner_Choices_SD_PRO(sub,:)));
    %normalize prior cooperations - 100%
    SD_PRO_0_100_perc_prior_coop_defectioncount_NORM(sub,2) = 100*(SD_PRO_0_100perc_prior_coop_defectioncount(sub,2) / (16-sum(Raw_Partner_Choices_SD_PRO(sub,:))));
end
%SR ANTI
SR_ANTI_0_100_perc_prior_coop_defectioncount_NORM = zeros(25,2);
for sub=1:25
    %normalize prior defections - 0%
    SR_ANTI_0_100_perc_prior_coop_defectioncount_NORM(sub,1) = 100*(SR_ANTI_0_100perc_prior_coop_defectioncount(sub,1) / sum(Raw_Partner_Choices_SR_ANTI(sub,:)));
    %normalize prior cooperations - 100%
    SR_ANTI_0_100_perc_prior_coop_defectioncount_NORM(sub,2) = 100*(SR_ANTI_0_100perc_prior_coop_defectioncount(sub,2) / (16-sum(Raw_Partner_Choices_SR_ANTI(sub,:))));
end
%SD ANTI 
SD_ANTI_0_100_perc_prior_coop_defectioncount_NORM = zeros(25,2);
for sub=1:25
    %normalize prior defections - 0%
    SD_ANTI_0_100_perc_prior_coop_defectioncount_NORM(sub,1) = 100*(SD_ANTI_0_100perc_prior_coop_defectioncount(sub,1) / sum(Raw_Partner_Choices_SD_ANTI(sub,:)));
    %normalize prior cooperations - 100%
    SD_ANTI_0_100_perc_prior_coop_defectioncount_NORM(sub,2) = 100*(SD_ANTI_0_100perc_prior_coop_defectioncount(sub,2) / (16-sum(Raw_Partner_Choices_SD_ANTI(sub,:))));
end

%plotting and ttests 
%SR ANTIPRO vs SD ANTIPRO
SR_ANTIPRO_defection_means_NORM = nanmean([SR_PRO_0_100_perc_prior_coop_defectioncount_NORM; SR_ANTI_0_100_perc_prior_coop_defectioncount_NORM]);
SR_ANTIPRO_se_defection_NORM = nanstd([SR_PRO_0_100_perc_prior_coop_defectioncount_NORM; SR_ANTI_0_100_perc_prior_coop_defectioncount_NORM]) / sqrt(25);

SR_PRO_defection_means_NORM=nanmean(SR_PRO_0_100_perc_prior_coop_defectioncount_NORM);
SR_PRO_se_defection_NORM = nanstd(SR_PRO_0_100_perc_prior_coop_defectioncount_NORM)/sqrt(25);

SD_ANTIPRO_defection_means_NORM = nanmean([SD_PRO_0_100_perc_prior_coop_defectioncount_NORM; SD_ANTI_0_100_perc_prior_coop_defectioncount_NORM]);
SD_ANTIPRO_se_defection_NORM = nanstd([SD_PRO_0_100_perc_prior_coop_defectioncount_NORM; SD_ANTI_0_100_perc_prior_coop_defectioncount_NORM]) / sqrt(25);

SD_PRO_defection_means_NORM=nanmean(SD_PRO_0_100_perc_prior_coop_defectioncount_NORM);
SD_PRO_se_defection_NORM = nanstd(SD_PRO_0_100_perc_prior_coop_defectioncount_NORM)/sqrt(25);
%prior coop
[h,p]=ttest([SR_PRO_0_100_perc_prior_coop_defectioncount_NORM(:,2); SR_ANTI_0_100_perc_prior_coop_defectioncount_NORM(:,2)], [SD_PRO_0_100_perc_prior_coop_defectioncount_NORM(:,2); SD_ANTI_0_100_perc_prior_coop_defectioncount_NORM(:,2)]);
display(p)
%prior defect
[h,p]=ttest([SR_PRO_0_100_perc_prior_coop_defectioncount_NORM(:,1); SR_ANTI_0_100_perc_prior_coop_defectioncount_NORM(:,1)], [SD_PRO_0_100_perc_prior_coop_defectioncount_NORM(:,1); SD_ANTI_0_100_perc_prior_coop_defectioncount_NORM(:,1)]);
display(p)

figure;
barwitherr([SR_ANTIPRO_se_defection_NORM; SD_ANTIPRO_se_defection_NORM], [SR_ANTIPRO_defection_means_NORM; SD_ANTIPRO_defection_means_NORM]);
ylabel('%-Defection Choices by Player');
set(gca, 'xticklabel', {'SR ANTI+PRO', 'SD ANTI+PRO'});
legend('Prior Partner Defect', 'Prior Partner Coop');
title({'SR vs. SD (ANTI + PRO)', '1-back Conditional Defection Percent'})

figure;
barwitherr([SR_PRO_se_defection_NORM; SD_PRO_se_defection_NORM], [SR_PRO_defection_means_NORM; SD_PRO_defection_means_NORM]);
ylabel('%-Defection Choices by Player');
set(gca, 'xticklabel', {'SR PRO', 'SD PRO'});
legend('Prior Partner Defect', 'Prior Partner Coop');
title({'SR vs. SD (PRO)', '1-back Conditional Defection Percent'})
