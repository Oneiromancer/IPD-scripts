%%
%Matt asks for following analyses on rounds 2-16
%2-trial moving average 
%average into non-overlapping thirds
%5-trial moving average 
clear
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Sliding Average\Removed_Round1\Raw_Choices_All_15rds.mat');

%%
%moving mean 
%2back 
Smoothed2_Choices_SR_PRO = movmean(Raw_Choices_SR_PRO, [1 0],2,'Endpoints', 'discard');
Smoothed2_Choices_SD_PRO = movmean(Raw_Choices_SD_PRO, [1 0],2,'Endpoints', 'discard');
Smoothed2_Choices_SR_ANTI = movmean(Raw_Choices_SR_ANTI, [1 0],2,'Endpoints', 'discard');
Smoothed2_Choices_SD_ANTI = movmean(Raw_Choices_SD_ANTI, [1 0],2,'Endpoints', 'discard');

mean_Smoothed2_Choices_SR_PRO = mean(Smoothed2_Choices_SR_PRO);
mean_Smoothed2_Choices_SD_PRO = mean(Smoothed2_Choices_SD_PRO);
mean_Smoothed2_Choices_SR_ANTI = mean(Smoothed2_Choices_SR_ANTI);
mean_Smoothed2_Choices_SD_ANTI = mean(Smoothed2_Choices_SD_ANTI);

se_Smoothed2_Choices_SR_PRO = std(Smoothed2_Choices_SR_PRO) / 5;
se_Smoothed2_Choices_SD_PRO = std(Smoothed2_Choices_SD_PRO) / 5;
se_Smoothed2_Choices_SR_ANTI = std(Smoothed2_Choices_SR_ANTI) / 5;
se_Smoothed2_Choices_SD_ANTI = std(Smoothed2_Choices_SD_ANTI) / 5;

%plot 2trial moving average choice 
%pro
figure; plot(1:14, mean_Smoothed2_Choices_SR_PRO, '-b');hold on;plot(1:14, mean_Smoothed2_Choices_SD_PRO, '-r');hold on
errorbar(mean_Smoothed2_Choices_SR_PRO, se_Smoothed2_Choices_SR_PRO);hold on;errorbar(mean_Smoothed2_Choices_SD_PRO, se_Smoothed2_Choices_SD_PRO);
title({'SR PRO vs SD PRO', '2-Trial Moving Mean Choice'}); xlabel('Rounds 2-16 (average of current and previous)'); ylabel('More Defections');legend('SR PRO', 'SD PRO');

%anti
figure; plot(1:14, mean_Smoothed2_Choices_SR_ANTI, '-b');hold on;plot(1:14, mean_Smoothed2_Choices_SD_ANTI, '-r');hold on
errorbar(mean_Smoothed2_Choices_SR_ANTI, se_Smoothed2_Choices_SR_ANTI);hold on;errorbar(mean_Smoothed2_Choices_SD_ANTI, se_Smoothed2_Choices_SD_ANTI);legend('SR ANTI', 'SD ANTI');
title({'SR ANTI vs SD ANTI', '2-Trial Moving Mean Choice'}); xlabel('Rounds 2-16 (average of current and previous)'); ylabel('More Defections')

%ttests
%pro
[h,p]=ttest(Smoothed2_Choices_SR_PRO, Smoothed2_Choices_SD_PRO);
%anti
[h,p]=ttest(Smoothed2_Choices_SR_ANTI, Smoothed2_Choices_SD_ANTI);

%%
%moving mean rounds=15 
clear
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Sliding Average\Removed_Round1\Raw_Choices_All_15rds.mat');
%5back 
Smoothed5_Choices_SR_PRO = movmean(Raw_Choices_SR_PRO, [4 0],2,'Endpoints', 'discard');
Smoothed5_Choices_SD_PRO = movmean(Raw_Choices_SD_PRO, [4 0],2,'Endpoints', 'discard');
Smoothed5_Choices_SR_ANTI = movmean(Raw_Choices_SR_ANTI, [4 0],2,'Endpoints', 'discard');
Smoothed5_Choices_SD_ANTI = movmean(Raw_Choices_SD_ANTI, [4 0],2,'Endpoints', 'discard');

mean_Smoothed5_Choices_SR_PRO = mean(Smoothed5_Choices_SR_PRO);
mean_Smoothed5_Choices_SD_PRO = mean(Smoothed5_Choices_SD_PRO);
mean_Smoothed5_Choices_SR_ANTI = mean(Smoothed5_Choices_SR_ANTI);
mean_Smoothed5_Choices_SD_ANTI = mean(Smoothed5_Choices_SD_ANTI);

se_Smoothed5_Choices_SR_PRO = std(Smoothed5_Choices_SR_PRO) / 5;
se_Smoothed5_Choices_SD_PRO = std(Smoothed5_Choices_SD_PRO) / 5;
se_Smoothed5_Choices_SR_ANTI = std(Smoothed5_Choices_SR_ANTI) / 5;
se_Smoothed5_Choices_SD_ANTI = std(Smoothed5_Choices_SD_ANTI) / 5;

%plot 2trial moving average choice 
%pro
figure; plot(1:11, mean_Smoothed5_Choices_SR_PRO, '-b');hold on;plot(1:11, mean_Smoothed5_Choices_SD_PRO, '-r');hold on
errorbar(mean_Smoothed5_Choices_SR_PRO, se_Smoothed5_Choices_SR_PRO);hold on;errorbar(mean_Smoothed5_Choices_SD_PRO, se_Smoothed5_Choices_SD_PRO);
title({'SR PRO vs SD PRO', '5-Trial Moving Mean Choice'}); xlabel('Rounds 2-16 (average of current and previous)'); ylabel('More Defections');legend('SR PRO', 'SD PRO');

%anti
figure; plot(1:11, mean_Smoothed5_Choices_SR_ANTI, '-b');hold on;plot(1:11, mean_Smoothed5_Choices_SD_ANTI, '-r');hold on
errorbar(mean_Smoothed5_Choices_SR_ANTI, se_Smoothed5_Choices_SR_ANTI);hold on;errorbar(mean_Smoothed5_Choices_SD_ANTI, se_Smoothed5_Choices_SD_ANTI);legend('SR ANTI', 'SD ANTI');
title({'SR ANTI vs SD ANTI', '5-Trial Moving Mean Choice'}); xlabel('Rounds 2-16 (average of current and previous)'); ylabel('More Defections')

%ttests
%pro
[h,p]=ttest(Smoothed5_Choices_SR_PRO, Smoothed5_Choices_SD_PRO);p
%anti
[h,p]=ttest(Smoothed5_Choices_SR_ANTI, Smoothed5_Choices_SD_ANTI);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mean choice; dividing rounds 2-16 into thirds. Compare mean cooperation
%Gather thirds
First_third_choices_SR_PRO = Raw_Choices_SR_PRO(:,2:6);Second_third_choices_SR_PRO = Raw_Choices_SR_PRO(:,7:11);Third_third_choices_SR_PRO=Raw_Choices_SR_PRO(:,12:end);
First_third_choices_SD_PRO = Raw_Choices_SD_PRO(:,2:6);Second_third_choices_SD_PRO = Raw_Choices_SD_PRO(:,7:11);Third_third_choices_SD_PRO=Raw_Choices_SD_PRO(:,12:end);
First_third_choices_SR_ANTI = Raw_Choices_SR_ANTI(:,2:6);Second_third_choices_SR_ANTI = Raw_Choices_SR_ANTI(:,7:11);Third_third_choices_SR_ANTI=Raw_Choices_SR_ANTI(:,12:end);
First_third_choices_SD_ANTI = Raw_Choices_SD_ANTI(:,2:6);Second_third_choices_SD_ANTI = Raw_Choices_SD_ANTI(:,7:11);Third_third_choices_SD_ANTI=Raw_Choices_SD_ANTI(:,12:end);

%means
mean_First_third_choice_SR_PRO = nanmean(First_third_choices_SR_PRO(:));mean_Second_third_choice_SR_PRO = nanmean(Second_third_choices_SR_PRO(:));mean_Third_third_choice_SR_PRO = nanmean(Third_third_choices_SR_PRO(:));
mean_First_third_choice_SD_PRO = nanmean(First_third_choices_SD_PRO(:));mean_Second_third_choice_SD_PRO = nanmean(Second_third_choices_SD_PRO(:));mean_Third_third_choice_SD_PRO = nanmean(Third_third_choices_SD_PRO(:));
mean_First_third_choice_SR_ANTI = nanmean(First_third_choices_SR_ANTI(:));mean_Second_third_choice_SR_ANTI = nanmean(Second_third_choices_SR_ANTI(:));mean_Third_third_choice_SR_ANTI = nanmean(Third_third_choices_SR_ANTI(:));
mean_First_third_choice_SD_ANTI = nanmean(First_third_choices_SD_ANTI(:));mean_Second_third_choice_SD_ANTI = nanmean(Second_third_choices_SD_ANTI(:));mean_Third_third_choice_SD_ANTI = nanmean(Third_third_choices_SD_ANTI(:));
%se
se_First_third_choice_SR_PRO = nanstd(First_third_choices_SR_PRO(:))/5;se_Second_third_choice_SR_PRO = nanstd(Second_third_choices_SR_PRO(:))/5;se_Third_third_choice_SR_PRO = nanstd(Third_third_choices_SR_PRO(:))/5;
se_First_third_choice_SD_PRO = nanstd(First_third_choices_SD_PRO(:))/5;se_Second_third_choice_SD_PRO = nanstd(Second_third_choices_SD_PRO(:))/5;se_Third_third_choice_SD_PRO = nanstd(Third_third_choices_SD_PRO(:))/5;
se_First_third_choice_SR_ANTI = nanstd(First_third_choices_SR_ANTI(:))/5;se_Second_third_choice_SR_ANTI = nanstd(Second_third_choices_SR_ANTI(:))/5;se_Third_third_choice_SR_ANTI = nanstd(Third_third_choices_SR_ANTI(:))/5;
se_First_third_choice_SD_ANTI = nanstd(First_third_choices_SD_ANTI(:))/5;se_Second_third_choice_SD_ANTI = nanstd(Second_third_choices_SD_ANTI(:))/5;se_Third_third_choice_SD_ANTI = nanstd(Third_third_choices_SD_ANTI(:))/5;

%plotting thirds PRO
%1st third 
figure; barwitherr([se_First_third_choice_SR_PRO, se_First_third_choice_SD_PRO], [mean_First_third_choice_SR_PRO, mean_First_third_choice_SD_PRO]); title({'1st Third', 'SR vs SD PRO', 'Mean Choice'}); ylabel('More Defections');set(gca, 'xticklabel', {'SR PRO 1/3', 'SD PRO 1/3'});ylim([.2,.6]);
%2nd third 
figure; barwitherr([se_Second_third_choice_SR_PRO, se_Second_third_choice_SD_PRO], [mean_Second_third_choice_SR_PRO, mean_Second_third_choice_SD_PRO]); title({'Second Third', 'SR vs SD PRO', 'Mean Choice'}); ylabel('More Defections');set(gca, 'xticklabel', {'SR PRO 2/3', 'SD PRO 2/3'});ylim([.2,.6]);
%3rd third 
figure; barwitherr([se_Third_third_choice_SR_PRO, se_Third_third_choice_SD_PRO], [mean_Third_third_choice_SR_PRO, mean_Third_third_choice_SD_PRO]); title({'Third Third', 'SR vs SD PRO', 'Mean Choice'}); ylabel('More Defections');set(gca, 'xticklabel', {'SR PRO 3/3', 'SD PRO 3/3'});ylim([.2,.6])
%plotting thirds ANTI
%1st third 
figure; barwitherr([se_First_third_choice_SR_ANTI, se_First_third_choice_SD_ANTI], [mean_First_third_choice_SR_ANTI, mean_First_third_choice_SD_ANTI]); title({'1st Third', 'SR vs SD ANTI', 'Mean Choice'}); ylabel('More Defections');set(gca, 'xticklabel', {'SR ANTI 1/3', 'SD ANTI 1/3'});ylim([.2,.6])
%2nd third 
figure; barwitherr([se_Second_third_choice_SR_ANTI, se_Second_third_choice_SD_ANTI], [mean_Second_third_choice_SR_ANTI, mean_Second_third_choice_SD_ANTI]); title({'Second Third', 'SR vs SD ANTI', 'Mean Choice'}); ylabel('More Defections');set(gca, 'xticklabel', {'SR ANTI 2/3', 'SD ANTI 2/3'});ylim([.2,.6])
%3rd third 
figure; barwitherr([se_Third_third_choice_SR_ANTI, se_Third_third_choice_SD_ANTI], [mean_Third_third_choice_SR_ANTI, mean_Third_third_choice_SD_ANTI]); title({'Third Third', 'SR vs SD ANTI', 'Mean Choice'}); ylabel('More Defections');set(gca, 'xticklabel', {'SR ANTI 3/3', 'SD ANTI 3/3'});ylim([.2,.6])

%ttests
[h,p]=ttest(First_third_choices_SR_PRO(:),First_third_choices_SD_PRO(:));
[h,p]=ttest(Second_third_choices_SR_PRO(:),Second_third_choices_SD_PRO(:));
[h,p]=ttest(Third_third_choices_SR_PRO(:),Third_third_choices_SD_PRO(:))

[h,p]=ttest(First_third_choices_SR_ANTI(:),First_third_choices_SD_ANTI(:));
[h,p]=ttest(Second_third_choices_SR_ANTI(:),Second_third_choices_SD_ANTI(:));
[h,p]=ttest(Third_third_choices_SR_ANTI(:),Third_third_choices_SD_ANTI(:))