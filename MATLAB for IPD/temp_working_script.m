%temp
figure;
scatter(n1back_ANTI, n3back_ANTI); lsline;
xlabel({'1-back Conditional Choice', 'SD - SR ANTI'})
ylabel({'3-back Conditional Choice', 'SD - SR ANTI'})
title({'#-Coops following Partner Coops - ANTI'});

[SD_PRO_0_50_100perc_prior_coop(:,3); SD_ANTI_0_50_100perc_prior_coop(:,3)] - ...
    [SR_PRO_0_50_100perc_prior_coop(:,3); SR_ANTI_0_50_100perc_prior_coop(:,3)]


SD_PRO_0_50_100perc_prior_coop(:,3) - SR_PRO_0_50_100perc_prior_coop(:,3)

SD_ANTI_0_50_100perc_prior_coop(:,3) - SR_ANTI_0_50_100perc_prior_coop(:,3)


ANTIPROpvals = [0.32	0.089	0.082];
PROpvals = [0.14	0.08	0.07];
ANTIpvals = [0.62	0.36	0.33];
x=[1,2,3];
plot(x,ANTIPROpvals, 'ko-')
hold on 
plot(x,PROpvals, 'bo-')
hold on
plot(x,ANTIpvals, 'ro-')
xticks([1 2 3])
set(gca, 'XTickLabel', {'1-back', '2-back', '3-back'})
xlabel('N-Back Partner Choices')
ylabel({'SR vs SD P-Value', '#-Coops following Partner 100%-Coop'})
title({'Comparison of SD vs SR Conditional Cooperations', '100%-Prior Partner Coop'})
legend('ANTI+PRO', 'PRO', 'ANTI')

%correlating with IL6
%raw DC
DC_diff_raw = DC_means_SD - DC_means_SR;
 DC_diff_percent = [DC_means_SD - DC_means_SR] ./ DC_means_SD %dividing by
% zero giving nans. calculated in excel


%correl, exclude index 11 15 17
[r,p] = corrcoef(DC_diff_raw([1:8, 10:11, 13:15, 17, 19:22, 24:end]), IL6_log_raw_diff)
[r,p] = corrcoef(DC_diff_percent([1:8, 10:11, 13:15, 17, 19:22, 24:end]), IL6_perc_diff,'Rows','pairwise')
figure;
scatter(DC_diff_raw([1:8, 10:11, 13:15, 17, 19:22, 24:end]), IL6_log_raw_diff); lsline
figure;
scatter(DC_diff_percent([1:8, 10:11, 13:15, 17, 19:22, 24:end]), IL6_perc_diff); lsline



%counting defections
SR_PRO_0_100perc_prior_coop = zeros(25,2); %col1 = 0%; col2=100%; 

for sub=1:25
    %index1 Partner_choices corresponds to player_choices index2
    %no need to smooth with 1back
    for i=1:(length(Raw_Partner_Choices_SR_PRO(sub,:)) - 1) %go up to Partner_index 15 (corresponds to Player_index 16)
        if Raw_Partner_Choices_SR_PRO(sub,i)==0
            if Raw_Choices_SR_PRO(sub,i+1) == 1 %check corresponding player choice
                SR_PRO_0_100perc_prior_coop(sub,2)= SR_PRO_0_100perc_prior_coop(sub,2) + 1; %increment coop counter
            end
        elseif Raw_Partner_Choices_SR_PRO(sub,i) == 1
            if Raw_Choices_SR_PRO(sub, i+1) == 1
                SR_PRO_0_100perc_prior_coop(sub,1) = SR_PRO_0_100perc_prior_coop(sub,1) + 1;
            end
        end
    end
end