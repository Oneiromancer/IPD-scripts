%%
%Load Raw Choices for Player and Partner
%ALL PLAYER CHOICES
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Raw_Choices_ALL_row_per_subj.mat');
%ALL PARTNER CHOICES
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Raw_Partner_Choices_ALL.mat')


%%***************SR_PRO***************
SR_PRO_0_100perc_prior_coop = zeros(25,2); %col1 = 0%; col2=100%; 

for sub=1:25
    %index1 Partner_choices corresponds to player_choices index2
    %no need to smooth with 1back
    for i=1:(length(Raw_Partner_Choices_SR_PRO(sub,:)) - 1) %go up to Partner_index 15 (corresponds to Player_index 16)
        if Raw_Partner_Choices_SR_PRO(sub,i)==0
            if Raw_Choices_SR_PRO(sub,i+1) == 0 %check corresponding player choice
                SR_PRO_0_100perc_prior_coop(sub,2)= SR_PRO_0_100perc_prior_coop(sub,2) + 1; %increment coop counter
            end
        elseif Raw_Partner_Choices_SR_PRO(sub,i) == 1
            if Raw_Choices_SR_PRO(sub, i+1) == 0
                SR_PRO_0_100perc_prior_coop(sub,1) = SR_PRO_0_100perc_prior_coop(sub,1) + 1;
            end
        end
    end
end

%%***************SD_PRO***************
SD_PRO_0_100perc_prior_coop = zeros(25,2); %col1 = 0%; col2=100%; 

for sub=1:25
    %index1 Partner_choices corresponds to player_choices index2
    %no need to smooth with 1back
    for i=1:(length(Raw_Partner_Choices_SD_PRO(sub,:)) - 1) %go up to Partner_index 15 (corresponds to Player_index 16)
        if Raw_Partner_Choices_SD_PRO(sub,i)==0
            if Raw_Choices_SD_PRO(sub,i+1) == 0 %check corresponding player choice
                SD_PRO_0_100perc_prior_coop(sub,2)= SD_PRO_0_100perc_prior_coop(sub,2) + 1; %increment coop counter
            end
        elseif Raw_Partner_Choices_SD_PRO(sub,i) == 1
            if Raw_Choices_SD_PRO(sub, i+1) == 0
                SD_PRO_0_100perc_prior_coop(sub,1) = SD_PRO_0_100perc_prior_coop(sub,1) + 1;
            end
        end
    end
end

%%***************SR_ANTI***************
SR_ANTI_0_100perc_prior_coop = zeros(25,2); %col1 = 0%; col2=100%; 

for sub=1:25
    %index1 Partner_choices corresponds to player_choices index2
    %no need to smooth with 1back
    for i=1:(length(Raw_Partner_Choices_SR_ANTI(sub,:)) - 1) %go up to Partner_index 15 (corresponds to Player_index 16)
        if Raw_Partner_Choices_SR_ANTI(sub,i)==0
            if Raw_Choices_SR_ANTI(sub,i+1) == 0 %check corresponding player choice
                SR_ANTI_0_100perc_prior_coop(sub,2)= SR_ANTI_0_100perc_prior_coop(sub,2) + 1; %increment coop counter
            end
        elseif Raw_Partner_Choices_SR_ANTI(sub,i) == 1
            if Raw_Choices_SR_ANTI(sub, i+1) == 0
                SR_ANTI_0_100perc_prior_coop(sub,1) = SR_ANTI_0_100perc_prior_coop(sub,1) + 1;
            end
        end
    end
end

%%***************SD_ANTI***************
SD_ANTI_0_100perc_prior_coop = zeros(25,2); %col1 = 0%; col2=100%; 

for sub=1:25
    %index1 Partner_choices corresponds to player_choices index2
    %no need to smooth with 1back
    for i=1:(length(Raw_Partner_Choices_SD_ANTI(sub,:)) - 1) %go up to Partner_index 15 (corresponds to Player_index 16)
        if Raw_Partner_Choices_SD_ANTI(sub,i)==0
            if Raw_Choices_SD_ANTI(sub,i+1) == 0 %check corresponding player choice
                SD_ANTI_0_100perc_prior_coop(sub,2)= SD_ANTI_0_100perc_prior_coop(sub,2) + 1; %increment coop counter
            end
        elseif Raw_Partner_Choices_SD_ANTI(sub,i) == 1
            if Raw_Choices_SD_ANTI(sub, i+1) == 0
                SD_ANTI_0_100perc_prior_coop(sub,1) = SD_ANTI_0_100perc_prior_coop(sub,1) + 1;
            end
        end
    end
end


%%
%plotting 
% load('1-back_Conditional_Choices_means_ALL.mat')
%1. SR(ANTI+PRO) Vs. SD(ANTI+PRO)
%2. SR(PRO) Vs. SD(PRO)
%3. SR(ANTI) Vs. SD(ANTI)
%%
%1back 
%Counting the number of cooperations following partner C vs Partner D
%combining PRO+ANTI

% SR(ANTIPRO) Vs SD(ANTIPRO)
SR_ANTIPRO_means = nanmean([SR_PRO_0_100perc_prior_coop; SR_ANTI_0_100perc_prior_coop]);
SR_ANTIPRO_se = nanstd([SR_PRO_0_100perc_prior_coop; SR_ANTI_0_100perc_prior_coop]) / sqrt(25);

SD_ANTIPRO_means = nanmean([SD_PRO_0_100perc_prior_coop; SD_ANTI_0_100perc_prior_coop]);
SD_ANTIPRO_se = nanstd([SD_PRO_0_100perc_prior_coop; SD_ANTI_0_100perc_prior_coop]) / sqrt(25);

figure;
barwitherr([SR_ANTIPRO_se; SD_ANTIPRO_se], [SR_ANTIPRO_means; SD_ANTIPRO_means]);
ylabel('# of Cooperate Choices by Player');
set(gca, 'xticklabel', {'SR ANTI+PRO', 'SD ANTI+PRO'});
legend('Prior Partner Defect', 'Prior Partner Coop');
title({'SR vs. SD (ANTI + PRO)', '1-back Conditional Cooperation Count'})

%2 SR(PRO) vs SD(PRO)
SR_PRO_means = nanmean(SR_PRO_0_100perc_prior_coop);
SR_PRO_se = nanstd(SR_PRO_0_100perc_prior_coop) / sqrt(25);
SD_PRO_means = nanmean(SD_PRO_0_100perc_prior_coop);
SD_PRO_se = nanstd(SD_PRO_0_100perc_prior_coop) / sqrt(25);

figure;
barwitherr([SR_PRO_se; SD_PRO_se], [SR_PRO_means; SD_PRO_means]);
ylabel('# of Cooperate Choices by Player');
set(gca, 'xticklabel', {'SR PRO', 'SD PRO'});
legend('Prior Partner Defect', 'Prior Partner Coop');
title({'SR vs. SD (PRO)', '1-back Conditional Cooperation Count'});

%3 SR(ANTI) vs SD(ANTI)
SR_ANTI_means = nanmean(SR_ANTI_0_100perc_prior_coop);
SR_ANTI_se = nanstd(SR_ANTI_0_100perc_prior_coop) / sqrt(25);
SD_ANTI_means = nanmean(SD_ANTI_0_100perc_prior_coop);
SD_ANTI_se = nanstd(SD_ANTI_0_100perc_prior_coop) / sqrt(25);

figure;
barwitherr([SR_ANTI_se; SD_ANTI_se], [SR_ANTI_means; SD_ANTI_means]);
ylabel('# of Cooperate Choices by Player');
set(gca, 'xticklabel', {'SR ANTI', 'SD ANTI'});
legend('Prior Partner Defect', 'Prior Partner Coop');
title({'SR vs. SD (ANTI)', '1-back Conditional Cooperation Count'});