%script for processing reaction times in IPD Player Choices
%all choice RT data
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\!RT_analyses_SEE EXCEL FOR FIXED RTs!\Player_Choice_RTs_fixed_sep_by_condition_and_partner.mat');
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Raw_Choices_ALL_row_per_subj.mat')
%%
%overall mean RTs
SR_PRO_mean_RT = nanmean(nanmean(SR_PRO_PlayerChoice_RT));
SD_PRO_mean_RT = nanmean(nanmean(SD_PRO_PlayerChoice_RT));
SR_ANTI_mean_RT = nanmean(nanmean(SR_ANTI_PlayerChoice_RT));
SD_ANTI_mean_RT = nanmean(nanmean(SD_ANTI_PlayerChoice_RT));

SR_PRO_RT_se = nanstd(SR_PRO_PlayerChoice_RT(:)) / 5;
SD_PRO_RT_se = nanstd(SD_PRO_PlayerChoice_RT(:)) / 5;
SR_ANTI_RT_se = nanstd(SR_ANTI_PlayerChoice_RT(:)) / 5;
SD_ANTI_RT_se = nanstd(SD_ANTI_PlayerChoice_RT(:)) / 5;

%ANTI+PRO
SR_ANTIPRO_mean_RT = nanmean([SR_PRO_mean_RT, SR_ANTI_mean_RT]);
SR_ANTIPRO_RT_se = nanstd([SR_PRO_PlayerChoice_RT(:); SR_ANTI_PlayerChoice_RT(:)]) / sqrt(50);
SD_ANTIPRO_mean_RT = nanmean([SD_PRO_mean_RT, SD_ANTI_mean_RT]);
SD_ANTIPRO_RT_se = nanstd([SD_PRO_PlayerChoice_RT(:); SD_ANTI_PlayerChoice_RT(:)]) / sqrt(50);
%plot antipro
figure;
barwitherr([SR_ANTIPRO_RT_se; SD_ANTIPRO_RT_se],[SR_ANTIPRO_mean_RT; SD_ANTIPRO_mean_RT]);
ylabel('Mean RT (ms)'); 
% ylim([3500,6000]);
set(gca, 'xticklabel', {'SR ANTI+PRO', 'SD ANTI+PRO'});
title({'SR vs. SD (ANTI + PRO)', 'Mean Player Choice RT'});
%plot PRO
figure;
barwitherr([SR_PRO_RT_se; SD_PRO_RT_se],[SR_PRO_mean_RT; SD_PRO_mean_RT]);
ylabel('Mean RT (ms)');
% ylim([3500,6000]);
set(gca, 'xticklabel', {'SR PRO', 'SD PRO'});
title({'SR vs. SD (PRO)', 'Mean Player Choice RT'});
%plot ANTI
figure;
barwitherr([SR_ANTI_RT_se; SD_ANTI_RT_se],[SR_ANTI_mean_RT; SD_ANTI_mean_RT]);
ylabel('Mean RT (ms)');
% ylim([3500,6000]);
set(gca, 'xticklabel', {'SR ANTI', 'SD ANTI'});
title({'SR vs. SD (ANTI)', 'Mean Player Choice RT'});

%%
%round by round RT
SR_ANTIPRO_round_means_Rt = nanmean([SR_ANTI_PlayerChoice_RT; SR_PRO_PlayerChoice_RT]);
SD_ANTIPRO_round_means_Rt = nanmean([SD_ANTI_PlayerChoice_RT; SD_PRO_PlayerChoice_RT]);
SR_PRO_round_means_Rt = nanmean(SR_PRO_PlayerChoice_RT); %1x16
SD_PRO_round_means_Rt = nanmean(SD_PRO_PlayerChoice_RT);
SR_ANTI_round_means_Rt = nanmean(SR_ANTI_PlayerChoice_RT);
SD_ANTI_round_means_Rt = nanmean(SD_ANTI_PlayerChoice_RT);

SR_ANTIPRO_round_RT_se = nanstd([SR_ANTI_PlayerChoice_RT; SR_PRO_PlayerChoice_RT]) / sqrt(50);
SD_ANTIPRO_round_RT_se = nanstd([SD_ANTI_PlayerChoice_RT; SD_PRO_PlayerChoice_RT]) / sqrt(50);
SR_PRO_round_RT_se = nanstd(SR_PRO_PlayerChoice_RT) / 5; %1x16
SD_PRO_round_RT_se = nanstd(SD_PRO_PlayerChoice_RT)/ 5;
SR_ANTI_round_RT_se = nanstd(SR_ANTI_PlayerChoice_RT)/ 5;
SD_ANTI_round_RT_se = nanstd(SD_ANTI_PlayerChoice_RT)/ 5;

%plotting round by round RT
%antipro
figure; 
plot(1:16,SR_ANTIPRO_round_means_Rt, '-b')
hold on 
plot(1:16, SD_ANTIPRO_round_means_Rt, '-r')
hold on
errorbar(SR_ANTIPRO_round_means_Rt, SR_ANTIPRO_round_RT_se)
hold on 
errorbar(SD_ANTIPRO_round_means_Rt, SD_ANTIPRO_round_RT_se)
legend('SR ANTI+PRO', 'SD ANTI+PRO');
xlabel('Round')
ylabel('Mean RT (ms)')
title({'Round by Round Choice RT', 'SR vs SD', 'ANTI+PRO'})

%pro
figure; 
plot(1:16,SR_PRO_round_means_Rt, '-b')
hold on 
plot(1:16, SD_PRO_round_means_Rt, 'r')
hold on
errorbar(SR_PRO_round_means_Rt,SR_PRO_round_RT_se)
hold on 
errorbar(SD_PRO_round_means_Rt, SD_PRO_round_RT_se)
legend('SR PRO', 'SD PRO');
xlabel('Round')
ylabel('Mean RT (ms)')
title({'Round by Round Choice RT', 'SR vs SD', 'PRO'})

%ANTI
figure; 
plot(1:16,SR_ANTI_round_means_Rt, '-b')
hold on 
plot(1:16, SD_ANTI_round_means_Rt, 'r')
hold on
errorbar(SR_ANTI_round_means_Rt,SR_ANTI_round_RT_se)
hold on 
errorbar(SD_ANTI_round_means_Rt, SD_ANTI_round_RT_se)
legend('SR ANTI', 'SD ANTI');
xlabel('Round')
ylabel('Mean RT (ms)')
title({'Round by Round Choice RT', 'SR vs SD', 'ANTI'})




%%
%correlating round by round RTs with round by round choices %shouldnt do
% %correlation, should do ttest. Ssaving for reference but commented out.
% [r,p]=corrcoef(Raw_Choices_SR_PRO(:), SR_PRO_PlayerChoice_RT(:))
% [r,p]=corrcoef(Raw_Choices_SD_PRO(:), SD_PRO_PlayerChoice_RT(:)) %sig
% [r,p]=corrcoef(Raw_Choices_SR_ANTI(:), SR_ANTI_PlayerChoice_RT(:))
% [r,p]=corrcoef(Raw_Choices_SD_ANTI(:), SD_ANTI_PlayerChoice_RT(:)) %sig

%averaging and bar plot for PlayerChoiceRT and PlayerChoiceType
%RT(Coop) vs RT(Defect)
%sd pro calc means and se
mean_RTs_SD_PRO_PlayerCoop = nanmean(SD_PRO_PlayerChoice_RT(Raw_Choices_SD_PRO==0));
se_RTs_SD_PRO_PlayerCoop = nanstd(SD_PRO_PlayerChoice_RT(Raw_Choices_SD_PRO==0))/sqrt(length(SD_PRO_PlayerChoice_RT(Raw_Choices_SD_PRO==0)));
mean_RTs_SD_PRO_PlayerDefect = nanmean(SD_PRO_PlayerChoice_RT(Raw_Choices_SD_PRO==1));
se_RTs_SD_PRO_PlayerDefect = nanstd(SD_PRO_PlayerChoice_RT(Raw_Choices_SD_PRO==1))/sqrt(length(SD_PRO_PlayerChoice_RT(Raw_Choices_SD_PRO==1)));
%se anti calc means and se 
mean_RTs_SD_ANTI_PlayerCoop = nanmean(SD_ANTI_PlayerChoice_RT(Raw_Choices_SD_ANTI==0));
se_RTs_SD_ANTI_PlayerCoop = nanstd(SD_ANTI_PlayerChoice_RT(Raw_Choices_SD_ANTI==0))/sqrt(length(SD_ANTI_PlayerChoice_RT(Raw_Choices_SD_ANTI==0)));
mean_RTs_SD_ANTI_PlayerDefect = nanmean(SD_ANTI_PlayerChoice_RT(Raw_Choices_SD_ANTI==1));
se_RTs_SD_ANTI_PlayerDefect = nanstd(SD_ANTI_PlayerChoice_RT(Raw_Choices_SD_ANTI==1))/sqrt(length(SD_ANTI_PlayerChoice_RT(Raw_Choices_SD_ANTI==1)));
%SD PRO
[h,p]=ttest2(SD_PRO_PlayerChoice_RT(Raw_Choices_SD_PRO==0), SD_PRO_PlayerChoice_RT(Raw_Choices_SD_PRO==1))
figure; barwitherr([se_RTs_SD_PRO_PlayerCoop, se_RTs_SD_PRO_PlayerDefect], [mean_RTs_SD_PRO_PlayerCoop, mean_RTs_SD_PRO_PlayerDefect]);set(gca, 'xticklabel', {'COOP Choice', 'DEFECT Choice'});ylabel('Choice RT (ms)');title({'SD PRO', 'Cooperation vs Defection Deliberation Times'})
% ylim([3300,5500]);
%SD ANTI
[h,p]=ttest2(SD_ANTI_PlayerChoice_RT(Raw_Choices_SD_ANTI==0), SD_ANTI_PlayerChoice_RT(Raw_Choices_SD_ANTI==1))
figure; barwitherr([se_RTs_SD_ANTI_PlayerCoop, se_RTs_SD_ANTI_PlayerDefect], [mean_RTs_SD_ANTI_PlayerCoop, mean_RTs_SD_ANTI_PlayerDefect]);set(gca, 'xticklabel', {'COOP Choice', 'DEFECT Choice'});ylabel('Choice RT (ms)');title({'SD ANTI', 'Cooperation vs Defection Deliberation Times'})
% ylim([3300,5500]);
%
%sr pro calc means and se
mean_RTs_SR_PRO_PlayerCoop = nanmean(SR_PRO_PlayerChoice_RT(Raw_Choices_SR_PRO==0));
se_RTs_SR_PRO_PlayerCoop = nanstd(SR_PRO_PlayerChoice_RT(Raw_Choices_SR_PRO==0))/sqrt(length(SR_PRO_PlayerChoice_RT(Raw_Choices_SR_PRO==0)));
mean_RTs_SR_PRO_PlayerDefect = nanmean(SR_PRO_PlayerChoice_RT(Raw_Choices_SR_PRO==1));
se_RTs_SR_PRO_PlayerDefect = nanstd(SR_PRO_PlayerChoice_RT(Raw_Choices_SR_PRO==1))/sqrt(length(SR_PRO_PlayerChoice_RT(Raw_Choices_SR_PRO==1)));
%sr anti calc means and se 
mean_RTs_SR_ANTI_PlayerCoop = nanmean(SR_ANTI_PlayerChoice_RT(Raw_Choices_SR_ANTI==0));
se_RTs_SR_ANTI_PlayerCoop = nanstd(SR_ANTI_PlayerChoice_RT(Raw_Choices_SR_ANTI==0))/sqrt(length(SR_ANTI_PlayerChoice_RT(Raw_Choices_SR_ANTI==0)));
mean_RTs_SR_ANTI_PlayerDefect = nanmean(SR_ANTI_PlayerChoice_RT(Raw_Choices_SR_ANTI==1));
se_RTs_SR_ANTI_PlayerDefect = nanstd(SR_ANTI_PlayerChoice_RT(Raw_Choices_SR_ANTI==1))/sqrt(length(SR_ANTI_PlayerChoice_RT(Raw_Choices_SR_ANTI==1)));
%SR PRO
[h,p]=ttest2(SR_PRO_PlayerChoice_RT(Raw_Choices_SR_PRO==0), SR_PRO_PlayerChoice_RT(Raw_Choices_SR_PRO==1))
figure; barwitherr([se_RTs_SR_PRO_PlayerCoop, se_RTs_SR_PRO_PlayerDefect], [mean_RTs_SR_PRO_PlayerCoop, mean_RTs_SR_PRO_PlayerDefect]);set(gca, 'xticklabel', {'COOP Choice', 'DEFECT Choice'});ylabel('Choice RT (ms)');title({'SR PRO', 'Cooperation vs Defection Deliberation Times'})
% ylim([3300,5500]);
%SR ANTI
[h,p]=ttest2(SR_ANTI_PlayerChoice_RT(Raw_Choices_SR_ANTI==0), SR_ANTI_PlayerChoice_RT(Raw_Choices_SR_ANTI==1))
figure; barwitherr([se_RTs_SR_ANTI_PlayerCoop, se_RTs_SR_ANTI_PlayerDefect], [mean_RTs_SR_ANTI_PlayerCoop, mean_RTs_SR_ANTI_PlayerDefect]);set(gca, 'xticklabel', {'COOP Choice', 'DEFECT Choice'});ylabel('Choice RT (ms)');title({'SR ANTI', 'Cooperation vs Defection Deliberation Times'})
% ylim([3300,5500]);
%testing SD ANTI Defect RT vs SD PRO Defect RT
[h,p]=ttest2(SD_PRO_PlayerChoice_RT(Raw_Choices_SD_PRO==1), SD_ANTI_PlayerChoice_RT(Raw_Choices_SD_ANTI==1))

%correlating round by round RT with prior partner choice --***This doesnt
%really work at the moment. I should not be averaging partner choice, but
%leaving all 15 partner choices, to correlate to 15 RTs, for each subject,
%giving 25 x 15 data points per condition per partner. 
% [r,p]=corrcoef(Raw_Partner_Choices_SR_PRO(:,1:15), SR_PRO_PlayerChoice_RT(:,2:end))
% [r,p]=corrcoef(Raw_Partner_Choices_SD_PRO(:,1:15), SD_PRO_PlayerChoice_RT(:,2:end))
% [r,p]=corrcoef(Raw_Partner_Choices_SR_ANTI(:,1:15), SR_ANTI_PlayerChoice_RT(:,2:end))
% [r,p]=corrcoef(Raw_Partner_Choices_SD_ANTI(:,1:15), SD_ANTI_PlayerChoice_RT(:,2:end))

% %antipro
% %work in progress;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
% [acor,lag]=xcorr(mean([Raw_Choices_SR_PRO; Raw_Choices_SR_ANTI]), mean([Raw_Choices_SD_PRO; Raw_Choices_SD_ANTI]))
% 
% lsline; xlabel('More/Less Defections'); ylabel('Mean Choice RT (ms)'); title({'SR vs SD ANTI+PRO', 'Correlation between Choice RT and Choice'})
% %pro
% figure;
% scatter(mean(Raw_Choices_SR_PRO), mean(SR_PRO_PlayerChoice_RT)); lsline; xlabel('More/Less Defections'); ylabl('Mean Choice RT (ms)'); title({'SR vs SD PRO', 'Correlation between Choice RT and Choice'});
% %ANTI
% figure;
% plot(mean(Raw_Choices_SR_ANTI), mean(SR_ANTI_PlayerChoice_RT)); lsline; xlabel('More/Less Defections'); ylabel('Mean Choice RT (ms)'); title({'SR vs SD ANTI', 'Correlation between Choice RT and Choice'});
% 


%%
%RT based on 1-back partner choice.
%ALL PARTNER CHOICES
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Raw_Partner_Choices_ALL.mat')
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Raw_Choices_ALL_row_per_subj.mat')

%SR PRO
SR_PRO_0_100perc_prior_coop_RT = zeros(25,2);  %col1 = prior partner D, col2 = prior partner C

for sub=1:25
%     num_coops = 16-sum(Raw_Partner_Choices_SR_PRO(sub,:)); 
    coop_RT_counter=[]; 
    defect_RT_counter=[];    
    %index1 partner choices corresponds to player_choices index2
    for i=1:(length(Raw_Partner_Choices_SR_PRO(sub,:)) - 1)
        if Raw_Partner_Choices_SR_PRO(sub,i)==0 %partner prior coop
            coop_RT_counter = [coop_RT_counter, SR_PRO_PlayerChoice_RT(sub,i+1)];
        else defect_RT_counter = [defect_RT_counter, SR_PRO_PlayerChoice_RT(sub,i+1)];
        end
    end
    SR_PRO_0_100perc_prior_coop_RT(sub,1) = nanmean(defect_RT_counter(defect_RT_counter>0));
    SR_PRO_0_100perc_prior_coop_RT(sub,2) = nanmean(coop_RT_counter(coop_RT_counter>0));
end

%SD PRO
SD_PRO_0_100perc_prior_coop_RT = zeros(25,2);  %col1 = prior partner D, col2 = prior partner C

for sub=1:25
    coop_RT_counter=[]; 
    defect_RT_counter=[];    
    %index1 partner choices corresponds to player_choices index2
    for i=1:(length(Raw_Partner_Choices_SD_PRO(sub,:)) - 1)
        if Raw_Partner_Choices_SD_PRO(sub,i)==0 %partner prior coop
            coop_RT_counter = [coop_RT_counter, SD_PRO_PlayerChoice_RT(sub,i+1)];
        else defect_RT_counter = [defect_RT_counter, SD_PRO_PlayerChoice_RT(sub,i+1)];
        end
    end
    SD_PRO_0_100perc_prior_coop_RT(sub,1) = nanmean(defect_RT_counter(defect_RT_counter>0));
    SD_PRO_0_100perc_prior_coop_RT(sub,2) = nanmean(coop_RT_counter(coop_RT_counter>0));
end

%SR ANTI
SR_ANTI_0_100perc_prior_coop_RT = zeros(25,2);  %col1 = prior partner D, col2 = prior partner C

for sub=1:25
    coop_RT_counter=[]; 
    defect_RT_counter=[];    
    %index1 partner choices corresponds to player_choices index2
    for i=1:(length(Raw_Partner_Choices_SR_ANTI(sub,:)) - 1)
        if Raw_Partner_Choices_SR_ANTI(sub,i)==0 %partner prior coop
            coop_RT_counter = [coop_RT_counter, SR_ANTI_PlayerChoice_RT(sub,i+1)];
        else defect_RT_counter = [defect_RT_counter, SR_ANTI_PlayerChoice_RT(sub,i+1)];
        end
    end
    SR_ANTI_0_100perc_prior_coop_RT(sub,1) = nanmean(defect_RT_counter(defect_RT_counter>0));
    SR_ANTI_0_100perc_prior_coop_RT(sub,2) = nanmean(coop_RT_counter(coop_RT_counter>0));
end

%SD ANTI
SD_ANTI_0_100perc_prior_coop_RT = zeros(25,2);  %col1 = prior partner D, col2 = prior partner C

for sub=1:25
    coop_RT_counter=[]; 
    defect_RT_counter=[];    
    %index1 partner choices corresponds to player_choices index2
    for i=1:(length(Raw_Partner_Choices_SD_ANTI(sub,:)) - 1)
        if Raw_Partner_Choices_SD_ANTI(sub,i)==0 %partner prior coop
            coop_RT_counter = [coop_RT_counter, SD_ANTI_PlayerChoice_RT(sub,i+1)];
        else defect_RT_counter = [defect_RT_counter, SD_ANTI_PlayerChoice_RT(sub,i+1)];
        end
    end
    SD_ANTI_0_100perc_prior_coop_RT(sub,1) = nanmean(defect_RT_counter(defect_RT_counter>0));
    SD_ANTI_0_100perc_prior_coop_RT(sub,2) = nanmean(coop_RT_counter(coop_RT_counter>0));
end

%%
%plotting conditional RTs
%histograms
%RT following partner choice
figure; histogram(SR_PRO_0_100perc_prior_coop_RT(:,2));xlabel('Mean RT (ms)');ylabel('#-Participants');title('SR PRO RT following Partner Coop');
figure; histogram(SD_PRO_0_100perc_prior_coop_RT(:,2));xlabel('Mean RT (ms)');ylabel('#-Participants');title('SD PRO RT following Partner Coop');
figure; histogram(SR_ANTI_0_100perc_prior_coop_RT(:,2));xlabel('Mean RT (ms)');ylabel('#-Participants');title('SR ANTI RT following Partner Coop');
figure; histogram(SD_ANTI_0_100perc_prior_coop_RT(:,2));xlabel('Mean RT (ms)');ylabel('#-Participants');title('SD ANTI RT following Partner Coop');
%rt following partner defect
figure; histogram(SR_PRO_0_100perc_prior_coop_RT(:,1));xlabel('Mean RT (ms)');ylabel('#-Participants');title('SR PRO RT following Partner Defect');
figure; histogram(SD_PRO_0_100perc_prior_coop_RT(:,1));xlabel('Mean RT (ms)');ylabel('#-Participants');title('SD PRO RT following Partner Defect');
figure; histogram(SR_ANTI_0_100perc_prior_coop_RT(:,1));xlabel('Mean RT (ms)');ylabel('#-Participants');title('SR ANTI RT following Partner Defect');
figure; histogram(SD_ANTI_0_100perc_prior_coop_RT(:,1));xlabel('Mean RT (ms)');ylabel('#-Participants');title('SD ANTI RT following Partner Defect');

%%
%barplots RT following partner coop 
mean_SR_ANTIPRO_100perc_RT = nanmean([SR_PRO_0_100perc_prior_coop_RT(:,2);SR_ANTI_0_100perc_prior_coop_RT(:,2)]);
mean_SD_ANTIPRO_100perc_RT = nanmean([SD_PRO_0_100perc_prior_coop_RT(:,2);SD_ANTI_0_100perc_prior_coop_RT(:,2)]);
mean_SR_PRO_100perc_RT = nanmean(SR_PRO_0_100perc_prior_coop_RT(:,2));
mean_SD_PRO_100perc_RT = nanmean(SD_PRO_0_100perc_prior_coop_RT(:,2));
mean_SR_ANTI_100perc_RT = nanmean(SR_ANTI_0_100perc_prior_coop_RT(:,2));
mean_SD_ANTI_100perc_RT = nanmean(SD_ANTI_0_100perc_prior_coop_RT(:,2));

se_SR_ANTIPRO_100perc_RT = nanstd([SR_PRO_0_100perc_prior_coop_RT(:,2);SR_ANTI_0_100perc_prior_coop_RT(:,2)]) / sqrt(50);
se_SD_ANTIPRO_100perc_RT = nanstd([SD_PRO_0_100perc_prior_coop_RT(:,2);SD_ANTI_0_100perc_prior_coop_RT(:,2)]) / sqrt(50);
se_SR_PRO_100perc_RT = nanstd(SR_PRO_0_100perc_prior_coop_RT(:,2)) / 5;
se_SD_PRO_100perc_RT = nanstd(SD_PRO_0_100perc_prior_coop_RT(:,2)) / 5;
se_SR_ANTI_100perc_RT = nanstd(SR_ANTI_0_100perc_prior_coop_RT(:,2)) / 5;
se_SD_ANTI_100perc_RT = nanstd(SD_ANTI_0_100perc_prior_coop_RT(:,2)) / 5;

%antipro
figure; barwitherr([se_SR_ANTIPRO_100perc_RT, se_SD_ANTIPRO_100perc_RT], [mean_SR_ANTIPRO_100perc_RT, mean_SD_ANTIPRO_100perc_RT])
 ylabel('Mean RT (ms)'); set(gca, 'xticklabel', {'SR ANTI+PRO', 'SD ANTI+PRO'}); title({'SR vs SD', 'Choice RT following Partner Cooperation', 'ANTI + PRO'});
%ylim([4000, 5500]);
%pro
figure; barwitherr([se_SR_PRO_100perc_RT, se_SD_PRO_100perc_RT], [mean_SR_PRO_100perc_RT, mean_SD_PRO_100perc_RT])
 ylabel('Mean RT (ms)'); set(gca, 'xticklabel', {'SR PRO', 'SD PRO'}); title({'SR vs SD', 'Choice RT following Partner Cooperation', 'PRO'});
%ylim([4000, 5500]);
%ANTI
figure; barwitherr([se_SR_ANTI_100perc_RT, se_SD_ANTI_100perc_RT], [mean_SR_ANTI_100perc_RT, mean_SD_ANTI_100perc_RT])
 ylabel('Mean RT (ms)'); set(gca, 'xticklabel', {'SR ANTI', 'SD ANTI'}); title({'SR vs SD', 'Choice RT following Partner Cooperation', 'ANTI'});
%ylim([4000, 5500]);

[h,p] = ttest([SR_PRO_0_100perc_prior_coop_RT(:,2);SR_ANTI_0_100perc_prior_coop_RT(:,2)], [SD_PRO_0_100perc_prior_coop_RT(:,2);SD_ANTI_0_100perc_prior_coop_RT(:,2)])


%%
%barplots RT following partner defect 
mean_SR_ANTIPRO_0perc_RT = nanmean([SR_PRO_0_100perc_prior_coop_RT(:,1);SR_ANTI_0_100perc_prior_coop_RT(:,1)]);
mean_SD_ANTIPRO_0perc_RT = nanmean([SD_PRO_0_100perc_prior_coop_RT(:,1);SD_ANTI_0_100perc_prior_coop_RT(:,1)]);
mean_SR_PRO_0perc_RT = nanmean(SR_PRO_0_100perc_prior_coop_RT(:,1));
mean_SD_PRO_0perc_RT = nanmean(SD_PRO_0_100perc_prior_coop_RT(:,1));
mean_SR_ANTI_0perc_RT = nanmean(SR_ANTI_0_100perc_prior_coop_RT(:,1));
mean_SD_ANTI_0perc_RT = nanmean(SD_ANTI_0_100perc_prior_coop_RT(:,1));

se_SR_ANTIPRO_0perc_RT = nanstd([SR_PRO_0_100perc_prior_coop_RT(:,1);SR_ANTI_0_100perc_prior_coop_RT(:,1)]) / sqrt(50);
se_SD_ANTIPRO_0perc_RT = nanstd([SD_PRO_0_100perc_prior_coop_RT(:,1);SD_ANTI_0_100perc_prior_coop_RT(:,1)]) / sqrt(50);
se_SR_PRO_0perc_RT = nanstd(SR_PRO_0_100perc_prior_coop_RT(:,1)) / 5;
se_SD_PRO_0perc_RT = nanstd(SD_PRO_0_100perc_prior_coop_RT(:,1)) / 5;
se_SR_ANTI_0perc_RT = nanstd(SR_ANTI_0_100perc_prior_coop_RT(:,1)) / 5;
se_SD_ANTI_0perc_RT = nanstd(SD_ANTI_0_100perc_prior_coop_RT(:,1)) / 5;

%antipro
figure; barwitherr([se_SR_ANTIPRO_0perc_RT, se_SD_ANTIPRO_0perc_RT], [mean_SR_ANTIPRO_0perc_RT, mean_SD_ANTIPRO_0perc_RT])
 ylabel('Mean RT (ms)'); set(gca, 'xticklabel', {'SR ANTI+PRO', 'SD ANTI+PRO'}); title({'SR vs SD', 'Choice RT following Partner Defect', 'ANTI + PRO'});
%ylim([4000, 5500]);
%pro
figure; barwitherr([se_SR_PRO_0perc_RT, se_SD_PRO_0perc_RT], [mean_SR_PRO_0perc_RT, mean_SD_PRO_0perc_RT])
 ylabel('Mean RT (ms)'); set(gca, 'xticklabel', {'SR PRO', 'SD PRO'}); title({'SR vs SD', 'Choice RT following Partner Defect', 'PRO'});
% ylim([4000, 5500]);
%ANTI
figure; barwitherr([se_SR_ANTI_0perc_RT, se_SD_ANTI_0perc_RT], [mean_SR_ANTI_0perc_RT, mean_SD_ANTI_0perc_RT])
 ylabel('Mean RT (ms)'); set(gca, 'xticklabel', {'SR ANTI', 'SD ANTI'}); title({'SR vs SD', 'Choice RT following Partner Defect', 'ANTI'});
% ylim([4000, 5500]);

%%%%
%%
%calculating RT by thirds (removing round 1). 
%calculating correlation [r,p] between each third's RT and average choice
%SR PRO
SubMeans_RT_First_third_SR_PRO = nanmean(SR_PRO_PlayerChoice_RT(:,2:6),2);
SubMeans_RT_Second_third_SR_PRO = nanmean(SR_PRO_PlayerChoice_RT(:,7:11),2);
SubMeans_RT_Third_third_SR_PRO = nanmean(SR_PRO_PlayerChoice_RT(:,12:16),2);

SubMeans_Choice_First_third_SR_PRO = nanmean(Raw_Choices_SR_PRO(:,2:6),2);
SubMeans_Choice_Second_third_SR_PRO = nanmean(Raw_Choices_SR_PRO(:,7:11),2);
SubMeans_Choice_Third_third_SR_PRO = nanmean(Raw_Choices_SR_PRO(:,12:16),2);

[r,p]=corrcoef(SubMeans_RT_First_third_SR_PRO, SubMeans_Choice_First_third_SR_PRO)%r=0,02; p=.90
[r,p]=corrcoef(SubMeans_RT_Second_third_SR_PRO, SubMeans_Choice_Second_third_SR_PRO)%r=0,06; p=.75
[r,p]=corrcoef(SubMeans_RT_Third_third_SR_PRO, SubMeans_Choice_Third_third_SR_PRO)%r=0,16; p=.42

%SD PRO
SubMeans_RT_First_third_SD_PRO = nanmean(SD_PRO_PlayerChoice_RT(:,2:6),2);
SubMeans_RT_Second_third_SD_PRO = nanmean(SD_PRO_PlayerChoice_RT(:,7:11),2);
SubMeans_RT_Third_third_SD_PRO = nanmean(SD_PRO_PlayerChoice_RT(:,12:16),2);

SubMeans_Choice_First_third_SD_PRO = nanmean(Raw_Choices_SD_PRO(:,2:6),2);
SubMeans_Choice_Second_third_SD_PRO = nanmean(Raw_Choices_SD_PRO(:,7:11),2);
SubMeans_Choice_Third_third_SD_PRO = nanmean(Raw_Choices_SD_PRO(:,12:16),2);

[r,p]=corrcoef(SubMeans_RT_First_third_SD_PRO, SubMeans_Choice_First_third_SD_PRO)%r=0.26; p=.19
[r,p]=corrcoef(SubMeans_RT_Second_third_SD_PRO, SubMeans_Choice_Second_third_SD_PRO)%r=0.07; p=.72
[r,p]=corrcoef(SubMeans_RT_Third_third_SD_PRO, SubMeans_Choice_Third_third_SD_PRO, 'rows','complete')%r=0.17; p=.43
%SR ANTI
SubMeans_RT_First_third_SR_ANTI = nanmean(SR_ANTI_PlayerChoice_RT(:,2:6),2);
SubMeans_RT_Second_third_SR_ANTI = nanmean(SR_ANTI_PlayerChoice_RT(:,7:11),2);
SubMeans_RT_Third_third_SR_ANTI = nanmean(SR_ANTI_PlayerChoice_RT(:,12:16),2);

SubMeans_Choice_First_third_SR_ANTI = nanmean(Raw_Choices_SR_ANTI(:,2:6),2);
SubMeans_Choice_Second_third_SR_ANTI = nanmean(Raw_Choices_SR_ANTI(:,7:11),2);
SubMeans_Choice_Third_third_SR_ANTI = nanmean(Raw_Choices_SR_ANTI(:,12:16),2);
[r,p]=corrcoef(SubMeans_RT_First_third_SR_ANTI, SubMeans_Choice_First_third_SR_ANTI)%r=.12; p=.55
[r,p]=corrcoef(SubMeans_RT_Second_third_SR_ANTI, SubMeans_Choice_Second_third_SR_ANTI)%r=.02; p=.89
[r,p]=corrcoef(SubMeans_RT_Third_third_SR_ANTI, SubMeans_Choice_Third_third_SR_ANTI)%r=-.05; p=.78

%SD ANTI
SubMeans_RT_First_third_SD_ANTI = nanmean(SD_ANTI_PlayerChoice_RT(:,2:6),2);
SubMeans_RT_Second_third_SD_ANTI = nanmean(SD_ANTI_PlayerChoice_RT(:,7:11),2);
SubMeans_RT_Third_third_SD_ANTI = nanmean(SD_ANTI_PlayerChoice_RT(:,12:16),2);

SubMeans_Choice_First_third_SD_ANTI = nanmean(Raw_Choices_SD_ANTI(:,2:6),2);
SubMeans_Choice_Second_third_SD_ANTI = nanmean(Raw_Choices_SD_ANTI(:,7:11),2);
SubMeans_Choice_Third_third_SD_ANTI = nanmean(Raw_Choices_SD_ANTI(:,12:16),2);
[r,p]=corrcoef(SubMeans_RT_First_third_SD_ANTI, SubMeans_Choice_First_third_SD_ANTI)%r=0.07; p=.71
[r,p]=corrcoef(SubMeans_RT_Second_third_SD_ANTI, SubMeans_Choice_Second_third_SD_ANTI)%r=0.39; p=.0498
[r,p]=corrcoef(SubMeans_RT_Third_third_SD_ANTI, SubMeans_Choice_Third_third_SD_ANTI)%r=0.38; p=.06

%plotting RTs by thirds
%means
%PRO-frst
mean_RT_First_third_SR_PRO = nanmean(SubMeans_RT_First_third_SR_PRO);
mean_RT_First_third_SD_PRO = nanmean(SubMeans_RT_First_third_SD_PRO);
se_RT_First_third_SR_PRO = nanstd(SubMeans_RT_First_third_SR_PRO)/5;
se_RT_First_third_SD_PRO = nanstd(SubMeans_RT_First_third_SD_PRO)/5;
figure;barwitherr([se_RT_First_third_SR_PRO, se_RT_First_third_SD_PRO], [mean_RT_First_third_SR_PRO, mean_RT_First_third_SD_PRO]);set(gca,'xticklabel',{'SR PRO', 'SD PRO'});ylabel('Mean RT (ms)');title({'Choice RT First Third', 'PRO'});
% ylim([3500, 5500]);

%pro second
mean_RT_Second_third_SR_PRO = nanmean(SubMeans_RT_Second_third_SR_PRO);
mean_RT_Second_third_SD_PRO = nanmean(SubMeans_RT_Second_third_SD_PRO);
se_RT_Second_third_SR_PRO = nanstd(SubMeans_RT_Second_third_SR_PRO)/5;
se_RT_Second_third_SD_PRO = nanstd(SubMeans_RT_Second_third_SD_PRO)/5;
figure;barwitherr([se_RT_Second_third_SR_PRO, se_RT_Second_third_SD_PRO], [mean_RT_Second_third_SR_PRO, mean_RT_Second_third_SD_PRO]);set(gca,'xticklabel',{'SR PRO', 'SD PRO'});ylabel('Mean RT (ms)');title({'Choice RT Second Third', 'PRO'});
% ylim([3500, 5500]);
%pro third
mean_RT_Third_third_SR_PRO = nanmean(SubMeans_RT_Third_third_SR_PRO);
mean_RT_Third_third_SD_PRO = nanmean(SubMeans_RT_Third_third_SD_PRO);
se_RT_Third_third_SR_PRO = nanstd(SubMeans_RT_Third_third_SR_PRO)/5;
se_RT_Third_third_SD_PRO = nanstd(SubMeans_RT_Third_third_SD_PRO)/5;
figure;barwitherr([se_RT_Third_third_SR_PRO, se_RT_Third_third_SD_PRO], [mean_RT_Third_third_SR_PRO, mean_RT_Third_third_SD_PRO]);set(gca,'xticklabel',{'SR PRO', 'SD PRO'});ylabel('Mean RT (ms)');title({'Choice RT Third Third', 'PRO'});
% ylim([3500, 5500]);
%ANTI-first
mean_RT_First_third_SR_ANTI = nanmean(SubMeans_RT_First_third_SR_ANTI);
mean_RT_First_third_SD_ANTI = nanmean(SubMeans_RT_First_third_SD_ANTI);
se_RT_First_third_SR_ANTI = nanstd(SubMeans_RT_First_third_SR_ANTI)/5;
se_RT_First_third_SD_ANTI = nanstd(SubMeans_RT_First_third_SD_ANTI)/5;
figure;barwitherr([se_RT_First_third_SR_ANTI, se_RT_First_third_SD_ANTI], [mean_RT_First_third_SR_ANTI, mean_RT_First_third_SD_ANTI]);set(gca,'xticklabel',{'SR ANTI', 'SD ANTI'});ylabel('Mean RT (ms)');title({'Choice RT First Third', 'ANTI'});
% ylim([4000, 5500]);
%ANTI-Second
mean_RT_Second_third_SR_ANTI = nanmean(SubMeans_RT_Second_third_SR_ANTI);
mean_RT_Second_third_SD_ANTI = nanmean(SubMeans_RT_Second_third_SD_ANTI);
se_RT_Second_third_SR_ANTI = nanstd(SubMeans_RT_Second_third_SR_ANTI)/5;
se_RT_Second_third_SD_ANTI = nanstd(SubMeans_RT_Second_third_SD_ANTI)/5;
figure;barwitherr([se_RT_Second_third_SR_ANTI, se_RT_Second_third_SD_ANTI], [mean_RT_Second_third_SR_ANTI, mean_RT_Second_third_SD_ANTI]);set(gca,'xticklabel',{'SR ANTI', 'SD ANTI'});ylabel('Mean RT (ms)');title({'Choice RT Second Third', 'ANTI'});
% ylim([4000, 5500]);
%ANTI-Third
mean_RT_Third_third_SR_ANTI = nanmean(SubMeans_RT_Third_third_SR_ANTI);
mean_RT_Third_third_SD_ANTI = nanmean(SubMeans_RT_Third_third_SD_ANTI);
se_RT_Third_third_SR_ANTI = nanstd(SubMeans_RT_Third_third_SR_ANTI)/5;
se_RT_Third_third_SD_ANTI = nanstd(SubMeans_RT_Third_third_SD_ANTI)/5;
figure;barwitherr([se_RT_Third_third_SR_ANTI, se_RT_Third_third_SD_ANTI], [mean_RT_Third_third_SR_ANTI, mean_RT_Third_third_SD_ANTI]);set(gca,'xticklabel',{'SR ANTI', 'SD ANTI'});ylabel('Mean RT (ms)');title({'Choice RT Third Third', 'ANTI'});
% ylim([4000, 5500]);

%ttests 
[h,p]=ttest(SubMeans_RT_First_third_SR_PRO,SubMeans_RT_First_third_SD_PRO)
[h,p]=ttest(SubMeans_RT_Second_third_SR_PRO,SubMeans_RT_Second_third_SD_PRO)
[h,p]=ttest(SubMeans_RT_Third_third_SR_PRO,SubMeans_RT_Third_third_SD_PRO)

[h,p]=ttest(SubMeans_RT_First_third_SR_ANTI,SubMeans_RT_First_third_SD_ANTI)
[h,p]=ttest(SubMeans_RT_Second_third_SR_ANTI,SubMeans_RT_Second_third_SD_ANTI)
[h,p]=ttest(SubMeans_RT_Third_third_SR_ANTI,SubMeans_RT_Third_third_SD_ANTI)
