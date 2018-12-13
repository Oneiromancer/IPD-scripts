%script to calculate and plot with statistics the cooperation rate (%) for
%each subject, separately for PRO/ANTI
clear all 
close all
%homedir
cd('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD');

%raw choice data
load('Choices_nomissedresp_ALL.mat');

% %initialize
% Coop_rate_SR_PRO = zeros(25,1);
% Coop_rate_SD_PRO = zeros(25,1);
% Coop_rate_SR_ANTI = zeros(25,1);
% Coop_rate_SD_ANTI = zeros(25,1);
% 
% for i=1:25;
%     Coop_rate_SR_PRO(i,1) = 100*((16-sum(Raw_Choices_SR_PRO(i,:))) / 16);
% %     Coop_rate_SR_PRO(i,1) = sum(Choices_nomissedresp_SR_PRO
%     
%     Coop_rate_SD_PRO(i,1) = 100*((16-sum(Raw_Choices_SD_PRO(i,:))) / 16);
%     
%     Coop_rate_SR_ANTI(i,1) = 100*((16-sum(Raw_Choices_SR_ANTI(i,:))) / 16);
%     Coop_rate_SD_ANTI(i,1) = 100*((16-sum(Raw_Choices_SD_ANTI(i,:))) / 16);
% end

load('Coop_rates_All_nomissedresps.mat');



%plotting
%PRO
figure;
stderror_SR_PRO = std( Coop_rate_SR_PRO) / sqrt( length( Coop_rate_SR_PRO ));
stderror_SD_PRO = std( Coop_rate_SD_PRO) / sqrt( length( Coop_rate_SD_PRO ));
bar([mean(Coop_rate_SR_PRO); mean(Coop_rate_SD_PRO)]);
ylabel('Cooperation Rate (%)');
hold on
errorbar([mean(Coop_rate_SR_PRO), mean(Coop_rate_SD_PRO)], [stderror_SR_PRO, stderror_SD_PRO]);
ylim([50, 75]);
set(gca,'xticklabel',{'SR PRO', 'SD PRO'});
title('Cooperation Rate (%) SR/SD PRO');

%ANTI
figure;
stderror_SR_ANTI = std( Coop_rate_SR_ANTI) / sqrt( length( Coop_rate_SR_ANTI ));
stderror_SD_ANTI = std( Coop_rate_SD_ANTI) / sqrt( length( Coop_rate_SD_ANTI ));
bar([mean(Coop_rate_SR_ANTI); mean(Coop_rate_SD_ANTI)]);
ylabel('Cooperation Rate (%)');
hold on
errorbar([mean(Coop_rate_SR_ANTI), mean(Coop_rate_SD_ANTI)], [stderror_SR_ANTI, stderror_SD_ANTI]);
ylim([40, 65]);
set(gca,'xticklabel',{'SR ANTI', 'SD ANTI'});
title('Cooperation Rate (%) SR/SD ANTI');

[h,p_val_PRO] = ttest(Coop_rate_SR_PRO, Coop_rate_SD_PRO);  
display(p_val_PRO)

[h,p_val_ANTI] = ttest(Coop_rate_SR_ANTI, Coop_rate_SD_ANTI);  
display(p_val_ANTI)

%remove cooperates-only
[h,p_val_PRO] = ttest(Coop_rate_SR_PRO([1:7, 10:19, 21:end]), Coop_rate_SD_PRO([1:7, 10:19, 21:end]));  
display(p_val_PRO)

[h,p_val_ANTI] = ttest(Coop_rate_SR_ANTI([1:7,10:end]), Coop_rate_SD_ANTI([1:7,10:end]));  
display(p_val_ANTI)

%%
%First Round Choice 
mean_SR_PRO_firstmove = nanmean(Raw_Choices_SR_PRO(:,1));
mean_SD_PRO_firstmove = nanmean(Raw_Choices_SD_PRO(:,1));
mean_SR_ANTI_firstmove = nanmean(Raw_Choices_SR_ANTI(:,1));
mean_SD_ANTI_firstmove = nanmean(Raw_Choices_SD_ANTI(:,1));
mean_SR_ANTIPRO_firstmove = nanmean([Raw_Choices_SR_PRO(:,1); Raw_Choices_SR_ANTI(:,1)]);
mean_SD_ANTIPRO_firstmove = nanmean([Raw_Choices_SD_PRO(:,1); Raw_Choices_SD_ANTI(:,1)]);


se_SR_PRO_firstmove = nanstd(Raw_Choices_SR_PRO(:,1)) / 5;
se_SD_PRO_firstmove = nanstd(Raw_Choices_SD_PRO(:,1)) / 5;
se_SR_ANTI_firstmove = nanstd(Raw_Choices_SR_ANTI(:,1)) / 5;
se_SD_ANTI_firstmove = nanstd(Raw_Choices_SD_ANTI(:,1)) / 5;
se_SR_ANTIPRO_firstmove = nanstd([Raw_Choices_SR_PRO(:,1); Raw_Choices_SR_ANTI(:,1)])/sqrt(50);
se_SD_ANTIPRO_firstmove = nanstd([Raw_Choices_SD_PRO(:,1); Raw_Choices_SD_ANTI(:,1)])/sqrt(50);

%plot first moves 
%antipro
figure; barwitherr([se_SR_ANTIPRO_firstmove, se_SD_ANTIPRO_firstmove], [mean_SR_ANTIPRO_firstmove, mean_SD_ANTIPRO_firstmove]);
set(gca,'xticklabel',{'SR ANTIPRO', 'SD ANTIPRO'});ylabel('First Move Defection'); title({'SR vs SD ANTIPRO', 'First Move'});

%pro
figure; barwitherr([se_SR_PRO_firstmove, se_SD_PRO_firstmove], [mean_SR_PRO_firstmove, mean_SD_PRO_firstmove]);
set(gca,'xticklabel',{'SR PRO', 'SD PRO'});ylabel('First Move Defection'); title({'SR vs SD PRO', 'First Move'});

%anti
figure; barwitherr([se_SR_ANTI_firstmove, se_SD_ANTI_firstmove], [mean_SR_ANTI_firstmove, mean_SD_ANTI_firstmove]);
set(gca,'xticklabel',{'SR ANTI', 'SD ANTI'});ylabel('First Move Defection'); title({'SR vs SD ANTI', 'First Move'});


%%
%Round of First defection
%SRPRO
FirstDefect_SR_PRO = zeros(25,1);
for sub=1:25
    if nansum(Raw_Choices_SR_PRO(sub,:))>0
        FirstDefect_SR_PRO(sub,1) = nanmin(find(Raw_Choices_SR_PRO(sub,:)>0));
    end
end
%SDPRO
FirstDefect_SD_PRO = zeros(25,1);
for sub=1:25
    if nansum(Raw_Choices_SD_PRO(sub,:))>0
        FirstDefect_SD_PRO(sub,1) = nanmin(find(Raw_Choices_SD_PRO(sub,:)>0));
    end
end 
%SRANTI
FirstDefect_SR_ANTI = zeros(25,1);
for sub=1:25
    if nansum(Raw_Choices_SR_ANTI(sub,:))>0
        FirstDefect_SR_ANTI(sub,1) = nanmin(find(Raw_Choices_SR_ANTI(sub,:)>0));
    end
end
%SDANTI
FirstDefect_SD_ANTI = zeros(25,1);
for sub=1:25
    if nansum(Raw_Choices_SD_ANTI(sub,:))>0
        FirstDefect_SD_ANTI(sub,1) = nanmin(find(Raw_Choices_SD_ANTI(sub,:)>0));
    end
end 

%plotting round of first defection
% figure; boxplot([FirstDefect_SR_PRO, FirstDefect_SD_PRO], 'Labels', {'SR PRO', 'SD PRO'}); ylabel('Round of First Defection'); title({'Round of First Defection', 'SRvsSD PRO All Subs'});
% figure; boxplot([FirstDefect_SR_ANTI, FirstDefect_SD_ANTI], 'Labels', {'SR ANTI', 'SD ANTI'}); ylabel('Round of First Defection'); title({'Round of First Defection', 'SRvsSD ANTI All Subs'});
edges=[0:1:16];
figure; histogram([FirstDefect_SR_PRO], edges); xlabel('Round of First Defection'); ylabel('#-Participants'); title({'Round of First Defection', 'SR PRO'});
figure; histogram([FirstDefect_SD_PRO],edges, 'FaceColor', 'r'); xlabel('Round of First Defection'); ylabel('#-Participants'); title({'Round of First Defection', 'SD PRO'});

figure; histogram([FirstDefect_SR_ANTI],edges); xlabel('Round of First Defection'); ylabel('#-Participants'); title({'Round of First Defection', 'SR ANTI'});
figure; histogram([FirstDefect_SD_ANTI],edges, 'FaceColor', 'r'); xlabel('Round of First Defection'); ylabel('#-Participants'); title({'Round of First Defection', 'SD ANTI'});
