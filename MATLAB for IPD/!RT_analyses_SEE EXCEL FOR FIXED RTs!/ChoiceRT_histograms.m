%Plot histograms for player choice
%Order: SR-PRO (16); SR-ANTI 16); SD-PRO (16); SD-ANTI (16);

%first batch collapses PRO/ANTI (32 trials) for each sub))
cd('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\!RT_analyses_SEE EXCEL FOR FIXED RTs!');
load('Player_Choice_RTs_ALL_fixed_with_missed_responses.mat');


%conditional indexing broke it -- this works but includes 0's
for sub=1:64:1600; %32 trials per sub (PRO+ANTI); not including missed responses = 0ms
    figure;
    subplot(1,2,1);
    RTs_SR = RTs_ALL(sub:sub+31);
    histogram(RTs_SR(RTs_SR>0),10); xlabel('Choice RT (ms)'); ylabel('#-Trials'); title('Sleep Rested');
    hold on
    subplot(1,2,2);
    RTs_SD = RTs_ALL(sub+32:sub+63);
    histogram(RTs_SD(RTs_SD>0),10); xlabel('Choice RT (ms)'); ylabel('#-Trials'); title('Sleep Deprived');
    hold off
end

    
    