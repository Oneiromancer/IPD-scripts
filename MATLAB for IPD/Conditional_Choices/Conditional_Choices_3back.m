%%
%3back conditional choice 
% Possible Outcomes: 
%     CCC - 100% (Mean = 0)
%     DDD - 0% (Mean = 1)
%     CDD / CCD (order doesnt matter); count these as 50% / mixed (0 < Mean < 1 )


%Load Raw Choices for Player and Partner
%ALL PLAYER CHOICES
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Raw_Choices_ALL.mat');
%ALL PARTNER CHOICES
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Raw_Partner_Choices_ALL.mat');

%%
%SR PRO 
SR_PRO_0_50_100perc_prior_coop = zeros(25,3); %col1 = 0%; Col2 = mixed; Col3=100%

for sub=1:25
%     index1_smoothed corresponds to Player Choice index4
    Smoothed_Partner_Choice = movmean(Raw_Partner_Choices_SR_PRO(sub,:), [2 0], 'Endpoints', 'discard');
    
    for i=1:length(Smoothed_Partner_Choice)
        if Smoothed_Partner_Choice(i)==1 && i<length(Smoothed_Partner_Choice)-3 %if partner 0% coops DDD
            if Raw_Choices_SR_PRO(sub,i+3)==0 %if player cooperates in response 
                SR_PRO_0_50_100perc_prior_coop(sub,1)=SR_PRO_0_50_100perc_prior_coop(sub,1)+1;%increment coop counter
            end
        elseif Smoothed_Partner_Choice(i)>0 && Smoothed_Partner_Choice(i)<1 && (i<length(Smoothed_Partner_Choice)-3) %if partner mixed cooperation
            if Raw_Choices_SR_PRO(sub,i+3)==0
                SR_PRO_0_50_100perc_prior_coop(sub,2) = SR_PRO_0_50_100perc_prior_coop(sub,2)+1;
            end
        elseif Smoothed_Partner_Choice(i)==0 && i<length(Smoothed_Partner_Choice)-3
            if Raw_Choices_SR_PRO(sub, i+3)==0
                SR_PRO_0_50_100perc_prior_coop(sub,3)=SR_PRO_0_50_100perc_prior_coop(sub,3)+1;
            end
        end
    end
end

%%***************SD_PRO***************
SD_PRO_0_50_100perc_prior_coop = zeros(25,3); %col1 = 0%; col2=mixed; col3=100%;

 for sub=1:25
%     index1_smoothed corresponds to Player Choice index4
    Smoothed_Partner_Choice = movmean(Raw_Partner_Choices_SD_PRO(sub,:), [2 0], 'Endpoints', 'discard');
    
    for i=1:length(Smoothed_Partner_Choice)
        if Smoothed_Partner_Choice(i)==1 && i<length(Smoothed_Partner_Choice)-3 %if partner 0% coops DDD
            if Raw_Choices_SD_PRO(sub,i+3)==0 %if player cooperates in response 
                SD_PRO_0_50_100perc_prior_coop(sub,1)=SD_PRO_0_50_100perc_prior_coop(sub,1)+1;%increment coop counter
            end
        elseif Smoothed_Partner_Choice(i)>0 && Smoothed_Partner_Choice(i)<1 && (i<length(Smoothed_Partner_Choice)-3) %if partner mixed cooperation
            if Raw_Choices_SD_PRO(sub,i+3)==0
                SD_PRO_0_50_100perc_prior_coop(sub,2) = SD_PRO_0_50_100perc_prior_coop(sub,2)+1;
            end
        elseif Smoothed_Partner_Choice(i)==0 && i<length(Smoothed_Partner_Choice)-3
            if Raw_Choices_SD_PRO(sub, i+3)==0
                SD_PRO_0_50_100perc_prior_coop(sub,3)=SD_PRO_0_50_100perc_prior_coop(sub,3)+1;
            end
        end
    end
 end

 %%***************SR_ANTI***************
SR_ANTI_0_50_100perc_prior_coop = zeros(25,3); %col1 = 0%; Col2 = mixed; Col3=100%

for sub=1:25
%     index1_smoothed corresponds to Player Choice index4
    Smoothed_Partner_Choice = movmean(Raw_Partner_Choices_SR_ANTI(sub,:), [2 0], 'Endpoints', 'discard');
    
    for i=1:length(Smoothed_Partner_Choice)
        if Smoothed_Partner_Choice(i)==1 && i<length(Smoothed_Partner_Choice)-3 %if partner 0% coops DDD
            if Raw_Choices_SR_ANTI(sub,i+3)==0 %if player cooperates in response 
                SR_ANTI_0_50_100perc_prior_coop(sub,1)=SR_ANTI_0_50_100perc_prior_coop(sub,1)+1;%increment coop counter
            end
        elseif Smoothed_Partner_Choice(i)>0 && Smoothed_Partner_Choice(i)<1 && (i<length(Smoothed_Partner_Choice)-3) %if partner mixed cooperation
            if Raw_Choices_SR_ANTI(sub,i+3)==0
                SR_ANTI_0_50_100perc_prior_coop(sub,2) = SR_ANTI_0_50_100perc_prior_coop(sub,2)+1;
            end
        elseif Smoothed_Partner_Choice(i)==0 && i<length(Smoothed_Partner_Choice)-3
            if Raw_Choices_SR_ANTI(sub, i+3)==0
                SR_ANTI_0_50_100perc_prior_coop(sub,3)=SR_ANTI_0_50_100perc_prior_coop(sub,3)+1;
            end
        end
    end
end

%%***************SD_ANTI***************
SD_ANTI_0_50_100perc_prior_coop = zeros(25,3); %col1 = 0%; Col2 = mixed; Col3=100%

for sub=1:25
%     index1_smoothed corresponds to Player Choice index4
    Smoothed_Partner_Choice = movmean(Raw_Partner_Choices_SD_ANTI(sub,:), [2 0], 'Endpoints', 'discard');
    
    for i=1:length(Smoothed_Partner_Choice)
        if Smoothed_Partner_Choice(i)==1 && i<length(Smoothed_Partner_Choice)-3 %if partner 0% coops DDD
            if Raw_Choices_SD_ANTI(sub,i+3)==0 %if player cooperates in response 
                SD_ANTI_0_50_100perc_prior_coop(sub,1)=SD_ANTI_0_50_100perc_prior_coop(sub,1)+1;%increment coop counter
            end
        elseif Smoothed_Partner_Choice(i)>0 && Smoothed_Partner_Choice(i)<1 && (i<length(Smoothed_Partner_Choice)-3) %if partner mixed cooperation
            if Raw_Choices_SD_ANTI(sub,i+3)==0
                SD_ANTI_0_50_100perc_prior_coop(sub,2) = SD_ANTI_0_50_100perc_prior_coop(sub,2)+1;
            end
        elseif Smoothed_Partner_Choice(i)==0 && i<length(Smoothed_Partner_Choice)-3
            if Raw_Choices_SD_ANTI(sub, i+3)==0
                SD_ANTI_0_50_100perc_prior_coop(sub,3)=SD_ANTI_0_50_100perc_prior_coop(sub,3)+1;
            end
        end
    end
end

%%
%Plotting 
%1. SR(ANTI+PRO) Vs. SD(ANTI+PRO)
%2. SR(PRO) Vs. SD(PRO)
%3. SR(ANTI) Vs. SD(ANTI)

%1. SR(ANTI+PRO) Vs. SD(ANTI+PRO)
SR_ANTIPRO_means = mean([SR_PRO_0_50_100perc_prior_coop; SR_ANTI_0_50_100perc_prior_coop]);
SR_ANTIPRO_se = std([SR_PRO_0_50_100perc_prior_coop; SR_ANTI_0_50_100perc_prior_coop]) / sqrt(25);

SD_ANTIPRO_means = mean([SD_PRO_0_50_100perc_prior_coop; SD_ANTI_0_50_100perc_prior_coop]);
SD_ANTIPRO_se = std([SD_PRO_0_50_100perc_prior_coop; SD_ANTI_0_50_100perc_prior_coop]) / sqrt(25);
        
figure;
barwitherr([SR_ANTIPRO_se; SD_ANTIPRO_se],[SR_ANTIPRO_means; SD_ANTIPRO_means]);
ylabel('# of Cooperate Choices by Player');
set(gca, 'xticklabel', {'SR ANTI+PRO', 'SD ANTI+PRO'});
legend('0% Prior Partner Coop', 'Mixed Prior Partner Coop', '100% Prior Partner Coop');
title({'SR vs. SD (ANTI + PRO)', '3-back Conditional Cooperation Count'});

%2 SR(PRO) vs SD(PRO
SR_PRO_mean = mean(SR_PRO_0_50_100perc_prior_coop);
SR_PRO_se = std(SR_PRO_0_50_100perc_prior_coop) / sqrt(25);

SD_PRO_mean = mean(SD_PRO_0_50_100perc_prior_coop);
SD_PRO_se = std(SD_PRO_0_50_100perc_prior_coop) / sqrt(25);

figure; 
barwitherr([SR_PRO_se; SD_PRO_se], [SR_PRO_mean; SD_PRO_mean])
ylabel('# of Cooperate Choices by Player');
set(gca, 'xticklabel', {'SR PRO', 'SD PRO'});
legend('0% Prior Partner Coop', 'Mixed Prior Partner Coop', '100% Prior Partner Coop');
title({'SR vs. SD (PRO)', '3-back Conditional Cooperation Count'});

%3 SR(ANTI) vs SD(ANTI)
SR_ANTI_mean = mean(SR_ANTI_0_50_100perc_prior_coop);
SR_ANTI_se = std(SR_ANTI_0_50_100perc_prior_coop) / sqrt(25);

SD_ANTI_mean = mean(SD_ANTI_0_50_100perc_prior_coop);
SD_ANTI_se = std(SD_ANTI_0_50_100perc_prior_coop) / sqrt(25);

figure; 
barwitherr([SR_ANTI_se; SD_ANTI_se], [SR_ANTI_mean; SD_ANTI_mean])
ylabel('# of Cooperate Choices by Player');
set(gca, 'xticklabel', {'SR ANTI', 'SD ANTI'});
legend('0% Prior Partner Coop', 'Mixed Prior Partner Coop', '100% Prior Partner Coop');
title({'SR vs. SD (ANTI)', '3-back Conditional Cooperation Count'});

%% 
%histograms
%SR ANTI+PRO
figure;
histogram([SR_PRO_0_50_100perc_prior_coop(:,1); SR_ANTI_0_50_100perc_prior_coop(:,1)]);
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SR PRO+ANTI'; '0% Prior Partner Coop'});
figure;
histogram([SR_PRO_0_50_100perc_prior_coop(:,2); SR_ANTI_0_50_100perc_prior_coop(:,2)]);
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SR PRO+ANTI'; 'Mixed Prior Partner Coop'});
figure;
histogram([SR_PRO_0_50_100perc_prior_coop(:,3); SR_ANTI_0_50_100perc_prior_coop(:,3)]);
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SR PRO+ANTI'; '100% Prior Partner Coop'});

%SD ANTI+PRO
figure;
histogram([SD_PRO_0_50_100perc_prior_coop(:,1); SD_ANTI_0_50_100perc_prior_coop(:,1)]);
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SD PRO+ANTI'; '0% Prior Partner Coop'});
figure;
histogram([SD_PRO_0_50_100perc_prior_coop(:,2); SD_ANTI_0_50_100perc_prior_coop(:,2)]);
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SD PRO+ANTI'; 'Mixed Prior Partner Coop'});
figure;
histogram([SD_PRO_0_50_100perc_prior_coop(:,3); SD_ANTI_0_50_100perc_prior_coop(:,3)]);
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SD PRO+ANTI'; '100% Prior Partner Coop'});

%SR-PRO
figure;
histogram(SR_PRO_0_50_100perc_prior_coop(:,1)) %0%
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SR PRO';'0% Prior Partner Coop'});
figure;
histogram(SR_PRO_0_50_100perc_prior_coop(:,2)) %50%
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SR PRO';'Mixed Prior Partner Coop'});
figure;
histogram(SR_PRO_0_50_100perc_prior_coop(:,3)) %100%
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SR PRO';'100% Prior Partner Coop'});


%SD-PRO
figure; 
histogram(SD_PRO_0_50_100perc_prior_coop(:,1));%0%
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SD PRO';'0% Prior Partner Coop'});
figure;
histogram(SD_PRO_0_50_100perc_prior_coop(:,2)) %50%
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SD PRO';'Mixed Prior Partner Coop'});
figure;
histogram(SD_PRO_0_50_100perc_prior_coop(:,3)) %100%
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SD PRO';'100% Prior Partner Coop'});

%SR-ANTI
figure;
histogram(SR_ANTI_0_50_100perc_prior_coop(:,1)); %0%
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SR ANTI';'0% Prior Partner Coop'});
figure; 
histogram(SR_ANTI_0_50_100perc_prior_coop(:,2)) %50%
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SR ANTI';'Mixed Prior Partner Coop'});
figure; 
histogram(SR_ANTI_0_50_100perc_prior_coop(:,3)) %100%
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SR ANTI';'100% Prior Partner Coop'});

%SD-ANTI
figure;
histogram(SD_ANTI_0_50_100perc_prior_coop(:,1)) %0%
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SD ANTI';'0% Prior Partner Coop'});
figure; 
histogram(SD_ANTI_0_50_100perc_prior_coop(:,2)) %50%
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SD ANTI';'Mixed Prior Partner Coop'});
figure;
histogram(SD_ANTI_0_50_100perc_prior_coop(:,3)) %100%
xlabel('#-Cooperations'); ylabel('#-Participants'); title({'SD ANTI';'100% Prior Partner Coop'});
