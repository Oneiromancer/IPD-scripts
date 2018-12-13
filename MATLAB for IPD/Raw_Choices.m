%Calculate and Plot Raw Choices
%D=1, C=0


%Choices
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Choice_Vec_with_NaNs.mat');
subs=fieldnames(Choice);

%25 rows (subs); 16 columns (trial)
Raw_Choices_SR_PRO = zeros(25,16);
Raw_Choices_SD_PRO = zeros(25,16);

Raw_Choices_SR_ANTI = zeros(25,16);
Raw_Choices_SD_ANTI = zeros(25,16);

for i=1:length(subs);
    Raw_Choices_SR_PRO(i,:) = Choice.(subs{i}).SR.PRO(:)';
    Raw_Choices_SD_PRO(i,:) = Choice.(subs{i}).SD.PRO(:)';
    
    Raw_Choices_SR_ANTI(i,:) = Choice.(subs{i}).SR.ANTI(:)';
    Raw_Choices_SD_ANTI(i,:) = Choice.(subs{i}).SD.ANTI(:)';
end

[h,p_val_rawchoice_PRO] = ttest(Raw_Choices_SR_PRO, Raw_Choices_SD_PRO);
[h,p_val_rawchoice_ANTI] = ttest(Raw_Choices_SR_ANTI, Raw_Choices_SD_ANTI);


%%
%plotting Group Choices
%PRO
%MAKE SURE TO IGNORE NANS
figure;
x = [1:1:16]; 
stderror_choice_SR_PRO = nanstd( Raw_Choices_SR_PRO) / sqrt( length( Raw_Choices_SR_PRO ));
errorbar(x, nanmean(Raw_Choices_SR_PRO), stderror_choice_SR_PRO, 'LineWidth', 1, 'MarkerSize', 10)
xlabel('Trial Number');
ylabel('Defection')
title('Raw Choices SR/SD PRO')
hold on 
stderror_choice_SD_PRO = nanstd( Raw_Choices_SD_PRO) / sqrt( length( Raw_Choices_SD_PRO ));
errorbar(x, nanmean(Raw_Choices_SD_PRO), stderror_choice_SD_PRO, 'LineWidth', 1, 'MarkerSize', 10)
ylim([.1, .65])
legend('SR-PRO', 'SD-PRO')


%ANTI
figure;
x = [1:1:16]; 
stderror_choice_SR_ANTI = nanstd( Raw_Choices_SR_ANTI) / sqrt( length( Raw_Choices_SR_ANTI ));
errorbar(x, nanmean(Raw_Choices_SR_ANTI), stderror_choice_SR_ANTI, 'LineWidth', 1, 'MarkerSize', 10)
xlabel('Trial Number');
ylabel('Defection')
title('Raw Choices SR/SD ANTI')
hold on 
stderror_choice_SD_ANTI = nanstd( Raw_Choices_SD_ANTI) / sqrt( length( Raw_Choices_SD_ANTI ));
errorbar(x, nanmean(Raw_Choices_SD_ANTI), stderror_choice_SD_ANTI, 'LineWidth', 1, 'MarkerSize', 10)
ylim([.15, .75])
legend('SR-ANTI', 'SD-ANTI')

%%
%first half cooperation vs second half cooperation 
%PRO 1st half 
% load('Raw_Choices_ALL_halved.mat')
se_SR_PRO_1st = mean(nanstd(Raw_Choices_SR_PRO(:,1:8)) / sqrt(length(Raw_Choices_SR_PRO(:,1:8))));
se_SR_PRO_2nd = mean(nanstd(Raw_Choices_SR_PRO(:,9:16)) / sqrt(length(Raw_Choices_SR_PRO(:,9:16))));
se_SD_PRO_1st = mean(nanstd(Raw_Choices_SD_PRO(:,1:8)) / sqrt(length(Raw_Choices_SD_PRO(:,1:8))));
se_SD_PRO_2nd = mean(nanstd(Raw_Choices_SD_PRO(:,9:16)) / sqrt(length(Raw_Choices_SD_PRO(:,9:16))));

se_SR_ANTI_1st = mean(nanstd(Raw_Choices_SR_ANTI(:,1:8)) / sqrt(length(Raw_Choices_SR_ANTI(:,1:8))));
se_SR_ANTI_2nd = mean(nanstd(Raw_Choices_SR_ANTI(:,9:16)) / sqrt(length(Raw_Choices_SR_ANTI(:,9:16))));
se_SD_ANTI_1st = mean(nanstd(Raw_Choices_SD_ANTI(:,1:8)) / sqrt(length(Raw_Choices_SD_ANTI(:,1:8))));
se_SD_ANTI_2nd = mean(nanstd(Raw_Choices_SD_ANTI(:,9:16)) / sqrt(length(Raw_Choices_SD_ANTI(:,9:16))));

%SD vs SR PRO_1sthalf
figure; 
bar([mean(nanmean(Raw_Choices_SR_PRO(:,1:8)));mean(nanmean(Raw_Choices_SD_PRO(:,1:8)))]); 
hold on
bar(2, mean(nanmean(Raw_Choices_SD_PRO(:,1:8))), 'r');
hold on
errorbar([mean(nanmean(Raw_Choices_SR_PRO(:,1:8))); mean(nanmean(Raw_Choices_SD_PRO(:,1:8)))], [se_SR_PRO_1st; se_SD_PRO_1st]);
ylim([.2,.56]);
set(gca, 'xticklabel', {'SR PRO 1st half', 'SD PRO 1st half'});
ylabel('Defection');
title('SR vs SD PRO 1st half');

%SD vs SR PRO_2ndhalf
figure; 
bar([mean(nanmean(Raw_Choices_SR_PRO(:,9:16)));mean(nanmean(Raw_Choices_SD_PRO(:,9:16)))]); 
hold on
bar(2, mean(nanmean(Raw_Choices_SD_PRO(:,9:16))), 'r');
hold on
errorbar([mean(nanmean(Raw_Choices_SR_PRO(:,9:16))); mean(nanmean(Raw_Choices_SD_PRO(:,9:16)))], [se_SR_PRO_1st; se_SD_PRO_2nd]);
ylim([.20,.56]);
set(gca, 'xticklabel', {'SR PRO 2nd half', 'SD PRO 2nd half'});
ylabel('Defection');
title('SR vs SD PRO 2nd half');

%SD vs SR ANTI_1sthalf
figure; 
bar([mean(nanmean(Raw_Choices_SR_ANTI(:,1:8)));mean(nanmean(Raw_Choices_SD_ANTI(:,1:8)))]); 
hold on
bar(2, mean(nanmean(Raw_Choices_SD_ANTI(:,1:8))), 'r');
hold on
errorbar([mean(nanmean(Raw_Choices_SR_ANTI(:,1:8))); mean(nanmean(Raw_Choices_SD_ANTI(:,1:8)))], [se_SR_ANTI_1st; se_SD_ANTI_1st]);
ylim([.2,.56]);
set(gca, 'xticklabel', {'SR ANTI 1st half', 'SD ANTI 1st half'});
ylabel('Defection');
title('SR vs SD ANTI 1st half');

%SD vs SR ANTI_2nd half
figure; 
bar([mean(nanmean(Raw_Choices_SR_ANTI(:,9:16)));mean(nanmean(Raw_Choices_SD_ANTI(:,9:16)))]); 
hold on
bar(2, mean(nanmean(Raw_Choices_SD_ANTI(:,9:16))), 'r');
hold on
errorbar([mean(nanmean(Raw_Choices_SR_ANTI(:,9:16))); mean(nanmean(Raw_Choices_SD_ANTI(:,9:16)))], [se_SR_ANTI_1st; se_SD_ANTI_2nd]);
ylim([.20,.56]);
set(gca, 'xticklabel', {'SR ANTI 2nd half', 'SD ANTI 2nd half'});
ylabel('Defection');
title('SR vs SD ANTI 2nd half');

%%


