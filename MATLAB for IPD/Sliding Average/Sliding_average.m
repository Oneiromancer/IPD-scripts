%Creating IPD subject behavior structs containing
%SR / SD
%PRO / ANTI
%vector of choice (0-c; 1-d), length 16x1)
%vector of outcome (code as with cooperation index)

%Cooperation Index
%   DC=1, 
%   DD=2
%   CC=3
%   CD=4

%subs = ['Sub102'; 'Sub103'; 'Sub104'; 'Sub105'; 'Sub106'; 'Sub107'; 'Sub108'; 'Sub109'; 'Sub110'; 'Sub112'; 'Sub113'; 'Sub114'; 'Sub115'; 'Sub116'; 'Sub117'; 'Sub118'; 'Sub119'; 'Sub120'; 'Sub121'; 'Sub122'; 'Sub123'; 'Sub124'; 'Sub125'; 'Sub126'; 'Sub128']; 
bin = 4;

%Choices
load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Choice_Vec.mat');
%Outcomes
% load('C:\Users\vikram\Documents\My Experiments\PD fMRI zipping\MATLAB for IPD\Outcomes_Vec.mat');

subs=fieldnames(Choice);

%25 rows (subs); 16 columns (trial)
Smoothed_Choices_SR_PRO_bin4 = zeros(25,16);
Smoothed_Choices_SD_PRO_bin4 = zeros(25,16);

Smoothed_Choices_SR_ANTI_bin4 = zeros(25,16);
Smoothed_Choices_SD_ANTI_bin4 = zeros(25,16);




for i = 1:length(subs);
    for j=1:16; %loop over trials
        if j < 4;
            if j==1;
                Smoothed_Choices_SR_PRO_bin4(i,j) = Choice.(subs{i}).SR.PRO(1);
                Smoothed_Choices_SD_PRO_bin4(i,j) = Choice.(subs{i}).SD.PRO(1);
                
                Smoothed_Choices_SR_ANTI_bin4(i,j) = Choice.(subs{i}).SR.ANTI(1);
                Smoothed_Choices_SD_ANTI_bin4(i,j) = Choice.(subs{i}).SD.ANTI(1);
            elseif j==2;
                Smoothed_Choices_SR_PRO_bin4(i,j) = mean(Choice.(subs{i}).SR.PRO(1:2));
                Smoothed_Choices_SD_PRO_bin4(i,j) = mean(Choice.(subs{i}).SD.PRO(1:2));
                
                Smoothed_Choices_SR_ANTI_bin4(i,j) = mean(Choice.(subs{i}).SR.ANTI(1:2));
                Smoothed_Choices_SD_ANTI_bin4(i,j) = mean(Choice.(subs{i}).SD.ANTI(1:2));
            elseif j==3;
                Smoothed_Choices_SR_PRO_bin4(i,j) = mean(Choice.(subs{i}).SR.PRO(1:3));
                Smoothed_Choices_SD_PRO_bin4(i,j) = mean(Choice.(subs{i}).SD.PRO(1:3));
                
                Smoothed_Choices_SR_ANTI_bin4(i,j) = mean(Choice.(subs{i}).SR.ANTI(1:3));
                Smoothed_Choices_SD_ANTI_bin4(i,j) = mean(Choice.(subs{i}).SD.ANTI(1:3));
            end
        else %j is 4 or more
            Smoothed_Choices_SR_PRO_bin4(i,j) = mean(Choice.(subs{i}).SR.PRO((j-3):j));    
            Smoothed_Choices_SD_PRO_bin4(i,j) = mean(Choice.(subs{i}).SD.PRO((j-3):j));   
            
            Smoothed_Choices_SR_ANTI_bin4(i,j) = mean(Choice.(subs{i}).SR.ANTI((j-3):j));    
            Smoothed_Choices_SD_ANTI_bin4(i,j) = mean(Choice.(subs{i}).SD.ANTI((j-3):j));   
        end    
        
    end
    
    
end

%plotting

%Group SR vs SD choice plots
%PRO
figure;
x = [1:1:16]; 
stderror_SR_PRO = std( Smoothed_Choices_SR_PRO_bin4 ) / sqrt( length( Smoothed_Choices_SR_PRO_bin4 ));
errorbar(x, mean(Smoothed_Choices_SR_PRO_bin4), stderror_SR_PRO, 'LineWidth', 1, 'MarkerSize', 10)
xlabel('Trial Number');
ylabel('Defection')
title('4-bin Smoothed Choices SR/SD PRO')
hold on 
stderror_SD_PRO = std( Smoothed_Choices_SD_PRO_bin4 ) / sqrt( length( Smoothed_Choices_SD_PRO_bin4 ));
errorbar(x, mean(Smoothed_Choices_SD_PRO_bin4), stderror_SD_PRO, 'LineWidth', 1, 'MarkerSize', 10)
ylim([.15, .6])
legend('SR-PRO', 'SD-PRO')

%ANTI
figure;
x = [1:1:16]; 
stderror_SR_ANTI = std( Smoothed_Choices_SR_ANTI_bin4 ) / sqrt( length( Smoothed_Choices_SR_ANTI_bin4 ));
errorbar(x, mean(Smoothed_Choices_SR_ANTI_bin4), stderror_SR_ANTI, 'LineWidth', 1, 'MarkerSize', 10)
xlabel('Trial Number');
ylabel('Defection')
title('4-bin Smoothed Choices SR/SD ANTI')
hold on 
stderror_SD_ANTI = std( Smoothed_Choices_SD_ANTI_bin4 ) / sqrt( length( Smoothed_Choices_SD_ANTI_bin4 ));
errorbar(x, mean(Smoothed_Choices_SD_ANTI_bin4), stderror_SD_ANTI, 'LineWidth', 1, 'MarkerSize', 10)
ylim([.15, .6])
legend('SR-ANTI', 'SD-ANTI')







%scratch
%     varname = ['SR_PRO_smoothed_choice_', subs{i}];
%     eval([varname '= zeros(1,16)']);
%     
%     varname = ['SD_PRO_smoothed_choice_', subs{i}];
%     eval([varname '= zeros(1,16)']);
%     
%     varname = ['SR_ANTI_smoothed_choice_', subs{i}];
%     eval([varname '= zeros(1,16)']);
%     
%     varname = ['SD_ANTI_smoothed_choice_', subs{i}];
%     eval([varname '= zeros(1,16)']);

    
    
