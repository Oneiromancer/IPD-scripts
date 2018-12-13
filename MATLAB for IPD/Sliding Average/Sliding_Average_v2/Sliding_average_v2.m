%Sliding_average_v2
%Round1=1, 2=2, 3=3, 4=4, 5=2+3+4+5 etc. This script differs from
%v1 in that it does not average the first 4 trials (set as the learning
%period)l
%C=0
%D=1

%Cooperation Index
%   DC=1, 
%   DD=2
%   CC=3
%   CD=4

%subs = ['Sub102'; 'Sub103'; 'Sub104'; 'Sub105'; 'Sub106'; 'Sub107'; 'Sub108'; 'Sub109'; 'Sub110'; 'Sub112'; 'Sub113'; 'Sub114'; 'Sub115'; 'Sub116'; 'Sub117'; 'Sub118'; 'Sub119'; 'Sub120'; 'Sub121'; 'Sub122'; 'Sub123'; 'Sub124'; 'Sub125'; 'Sub126'; 'Sub128']; 
cd('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Sliding Average\Sliding_Average_v2');
bin = 4;

%Choices
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Choice_Vec_with_NaNs.mat'.mat');
%Outcomes
% load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Outcomes_Vec.mat');

subs=fieldnames(Choice);

%25 rows (subs); 16 columns (trial)
Smoothed_Choices_SR_PRO_bin4 = zeros(25,16);
Smoothed_Choices_SD_PRO_bin4 = zeros(25,16);


Smoothed_Choices_SR_ANTI_bin4 = zeros(25,16);
Smoothed_Choices_SD_ANTI_bin4 = zeros(25,16);


Smoothed_Outcomes_SR_PRO_bin4 = zeros(25,16);
Smoothed_Outcomes_SD_PRO_bin4 = zeros(25,16);

Smoothed_Outcomes_SR_ANTI_bin4 = zeros(25,16);
Smoothed_Outcomes_SD_ANTI_bin4 = zeros(25,16);


%smooth choices
for i = 1:length(subs);
    for j=1:16; %loop over trials
        if j < 5;
                Smoothed_Choices_SR_PRO_bin4(i,j) = Choice.(subs{i}).SR.PRO(j)';
                Smoothed_Choices_SD_PRO_bin4(i,j) = Choice.(subs{i}).SD.PRO(j)';
                
                
                Smoothed_Choices_SR_ANTI_bin4(i,j) = Choice.(subs{i}).SR.ANTI(j)';
                Smoothed_Choices_SD_ANTI_bin4(i,j) = Choice.(subs{i}).SD.ANTI(j)';
        
                
                Smoothed_Outcomes_SR_PRO_bin4(i,j) = Outcome.(subs{i}).SR.PRO(j)';
                Smoothed_Outcomes_SD_PRO_bin4(i,j) = Outcome.(subs{i}).SD.PRO(j)';
                
                Smoothed_Outcomes_SR_ANTI_bin4(i,j) = Outcome.(subs{i}).SR.ANTI(j)';
                Smoothed_Outcomes_SD_ANTI_bin4(i,j) = Outcome.(subs{i}).SD.ANTI(j)';
            
        else %j is 5 or more-smoothing begins here
            Smoothed_Choices_SR_PRO_bin4(i,j) = mean(Choice.(subs{i}).SR.PRO((j-3):j))';    
            Smoothed_Choices_SD_PRO_bin4(i,j) = mean(Choice.(subs{i}).SD.PRO((j-3):j))';

            
            Smoothed_Choices_SR_ANTI_bin4(i,j) = mean(Choice.(subs{i}).SR.ANTI((j-3):j))';    
            Smoothed_Choices_SD_ANTI_bin4(i,j) = mean(Choice.(subs{i}).SD.ANTI((j-3):j))';   
    
            
            Smoothed_Outcomes_SR_PRO_bin4(i,j) = mean(Outcome.(subs{i}).SR.PRO((j-3):j))';    
            Smoothed_Outcomes_SD_PRO_bin4(i,j) = mean(Outcome.(subs{i}).SD.PRO((j-3):j))';   
            
            Smoothed_Outcomes_SR_ANTI_bin4(i,j) = mean(Outcome.(subs{i}).SR.ANTI((j-3):j))';    
            Smoothed_Outcomes_SD_ANTI_bin4(i,j) = mean(Outcome.(subs{i}).SD.ANTI((j-3):j))';   
        end    
        
    end
    
    
end

[h, p_values_PRO] = ttest(Smoothed_Choices_SR_PRO_bin4, Smoothed_Choices_SD_PRO_bin4);
[h, p_values_ANTI] = ttest(Smoothed_Choices_SR_ANTI_bin4, Smoothed_Choices_SD_ANTI_bin4);


%plotting
%Group SR vs SD choice plots
%PRO
figure;
x = [1:1:16]; 
stderror_choice_SR_PRO = std( Smoothed_Choices_SR_PRO_bin4 ) / sqrt( length( Smoothed_Choices_SR_PRO_bin4 ));
errorbar(x, mean(Smoothed_Choices_SR_PRO_bin4), stderror_choice_SR_PRO, 'LineWidth', 1, 'MarkerSize', 10)
xlabel('Trial Number');
ylabel('Defection')
title('4-bin Smoothed Choices SR/SD PRO')
hold on 
stderror_choice_SD_PRO = std( Smoothed_Choices_SD_PRO_bin4 ) / sqrt( length( Smoothed_Choices_SD_PRO_bin4 ));
errorbar(x, mean(Smoothed_Choices_SD_PRO_bin4), stderror_choice_SD_PRO, 'LineWidth', 1, 'MarkerSize', 10)
ylim([.2, .75])
legend('SR-PRO', 'SD-PRO')

%ANTI
figure;
x = [1:1:16]; 
stderror_choice_SR_ANTI = std( Smoothed_Choices_SR_ANTI_bin4 ) / sqrt( length( Smoothed_Choices_SR_ANTI_bin4 ));
errorbar(x, mean(Smoothed_Choices_SR_ANTI_bin4), stderror_choice_SR_ANTI, 'LineWidth', 1, 'MarkerSize', 10)
xlabel('Trial Number');
ylabel('Defection')
title('4-bin Smoothed Choices SR/SD ANTI')
hold on 
stderror_choice_SD_ANTI = std( Smoothed_Choices_SD_ANTI_bin4 ) / sqrt( length( Smoothed_Choices_SD_ANTI_bin4 ));
errorbar(x, mean(Smoothed_Choices_SD_ANTI_bin4), stderror_choice_SD_ANTI, 'LineWidth', 1, 'MarkerSize', 10)
ylim([.2, .75])
legend('SR-ANTI', 'SD-ANTI')


%plotting
%Group SR vs SD Outcome plots
%PRO
figure;
x = [1:1:16]; 
stderror_outcome_SR_PRO = std( Smoothed_Outcomes_SR_PRO_bin4 ) / sqrt( length( Smoothed_Outcomes_SR_PRO_bin4 ));
errorbar(x, mean(Smoothed_Outcomes_SR_PRO_bin4), stderror_outcome_SR_PRO, 'LineWidth', 1, 'MarkerSize', 10)
xlabel('Trial Number');
ylabel('Cooperative Outcomes')
title('4-bin Smoothed Outcomes SR/SD PRO')
hold on 
stderror_outcome_SD_PRO = std( Smoothed_Outcomes_SD_PRO_bin4 ) / sqrt( length( Smoothed_Outcomes_SD_PRO_bin4 ));
errorbar(x, mean(Smoothed_Outcomes_SD_PRO_bin4), stderror_outcome_SD_PRO, 'LineWidth', 1, 'MarkerSize', 10)
ylim([1.75, 3.5])
legend('SR-PRO', 'SD-PRO')

%ANTI Outcomes
figure;
x = [1:1:16]; 
stderror_outcome_SR_ANTI = std( Smoothed_Outcomes_SR_ANTI_bin4 ) / sqrt( length( Smoothed_Outcomes_SR_ANTI_bin4 ));
errorbar(x, mean(Smoothed_Outcomes_SR_ANTI_bin4), stderror_outcome_SR_ANTI, 'LineWidth', 1, 'MarkerSize', 10)
xlabel('Trial Number');
ylabel('Cooperative Outcomes')
title('4-bin Smoothed Outcomes SR/SD ANTI')
hold on 
stderror_outcome_SD_ANTI = std( Smoothed_Outcomes_SD_ANTI_bin4 ) / sqrt( length( Smoothed_Outcomes_SD_ANTI_bin4 ));
errorbar(x, mean(Smoothed_Outcomes_SD_ANTI_bin4), stderror_outcome_SD_ANTI, 'LineWidth', 1, 'MarkerSize', 10)
ylim([1.75, 3.5])
legend('SR-ANTI', 'SD-ANTI')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%     %temp for individual smoothed choice plots
%     i=1;   
%    figure;
% %pro
% x = [1:1:16]; 
% plot(x, Smoothed_Choices_SR_PRO_bin4(i,:), 'LineWidth', 1, 'MarkerSize', 10);
% xlabel('Trial Number');
% ylabel('Defection')
% title('4-bin Smoothed Choices SR/SD PRO')
% hold on 
% plot(x, Smoothed_Choices_SD_PRO_bin4(i,:), 'LineWidth', 1, 'MarkerSize', 10);
% ylim([0, 1.1])
% legend('SR-PRO', 'SD-PRO')
% %anti
% figure;
% x = [1:1:16]; 
% plot(x, Smoothed_Choices_SR_ANTI_bin4(i,:), 'LineWidth', 1, 'MarkerSize', 10);
% xlabel('Trial Number');
% ylabel('Defection')
% title('4-bin Smoothed Choices SR/SD ANTI')
% hold on 
% plot(x, Smoothed_Choices_SD_ANTI_bin4(i,:), 'LineWidth', 1, 'MarkerSize', 10);
% ylim([0, 1.1])
% legend('SR-ANTI', 'SD-ANTI')
% 
% 
% 
% 






    
    
