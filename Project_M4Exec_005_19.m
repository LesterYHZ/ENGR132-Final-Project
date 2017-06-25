function Project_M4Exec_005_19()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 Program Description 
%	Analyze the 100 time histories provided by FOS, Inc. in a fully
%	automated way, and identify the four relevant first-order system
%	parameters (yL, yH, ts, and tau) from each time history. Also
%   does a regression to get price vs tau equation.
%
% Function Call
% 	Project_M4Exec_005_19()
%
% Input Arguments
%	1. none
% Output Arguments
%	1. none
% Assignment Information
%	Assignment:         Project M4
%	Author:             Lester Yang, yang1118@purdue.edu
%                       Sameer Leley, sleley@purdue.edu
%                       Michael Mayer, Mayer24@purdue.edu
%  	Team ID:            005-19    
%  	Paired Programmer:  Name, login@purdue.edu
%  	Contributor:        Name, login@purdue [repeat for each contributor]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% initialize workspace
clear all; close all; clc;
dbstop if error; % for testing
%% Import Data
FileData = csvread('fos_time_histories.csv');

%split up matrix into vectors
Time = FileData(:,1);
FOS_1 = FileData(:,2:21);
FOS_2 = FileData(:,22:41);
FOS_3 = FileData(:,42:61);
FOS_4 = FileData(:,62:81);
FOS_5 = FileData(:,82:101);

%% Compute four values
FourValue = zeros(4,100); %create a matrix of zeros
Condition = zeros(1,100); %create a matrix of zeros

for k=1:length(FourValue) %for loop to fill matrix with parameter vals
    [FourValue(:,k),Condition(k)] = Project_M4Algorithm_005_19(Time,FileData(:,k+1));
end

%% Assign Necessary Data

%breaks up condition matrix into seperate vectors for each thermocouple
FOS1_condition = Condition(1:20);
FOS2_condition = Condition(21:40);
FOS3_condition = Condition(41:60);
FOS4_condition = Condition(61:80);
FOS5_condition = Condition(81:100);

%break up parameter matrix into seperate vectors for each thermocouple
FOS1_var = FourValue(:,1:20);
FOS2_var = FourValue(:,21:40);
FOS3_var = FourValue(:,41:60);
FOS4_var = FourValue(:,61:80);
FOS5_var = FourValue(:,81:100);

%create vectors of tau data for each thermocouple
FOS1_tau = FOS1_var(end,:);
FOS2_tau = FOS2_var(end,:);
FOS3_tau = FOS3_var(end,:);
FOS4_tau = FOS4_var(end,:);
FOS5_tau = FOS5_var(end,:);

%calculate the mean for each thermocouple tau data
tau1_mean = mean(FOS1_tau);
tau2_mean = mean(FOS2_tau);
tau3_mean = mean(FOS3_tau);
tau4_mean = mean(FOS4_tau);
tau5_mean = mean(FOS5_tau);

%calculate the standard deviation for each thermocouple tau data
tau1_std = std(FOS1_tau);
tau2_std = std(FOS2_tau);
tau3_std = std(FOS3_tau);
tau4_std = std(FOS4_tau);
tau5_std = std(FOS5_tau);

%% Compute SSE

% initialze vectors of zeros
FOS1_yt=zeros(length(Time),20);
FOS2_yt=zeros(length(Time),20);
FOS3_yt=zeros(length(Time),20);
FOS4_yt=zeros(length(Time),20);
FOS5_yt=zeros(length(Time),20);

% assign vectors with piecewise function data
for k=1:20
    FOS1_yt(:,k) = FirstOrder_005_019(FOS1_var(:,k),Time,FOS1_condition(k));
    FOS2_yt(:,k) = FirstOrder_005_019(FOS2_var(:,k),Time,FOS2_condition(k));
    FOS3_yt(:,k) = FirstOrder_005_019(FOS3_var(:,k),Time,FOS3_condition(k));
    FOS4_yt(:,k) = FirstOrder_005_019(FOS4_var(:,k),Time,FOS4_condition(k));
    FOS5_yt(:,k) = FirstOrder_005_019(FOS5_var(:,k),Time,FOS5_condition(k));
end

% compute SSEmod 
FOS1_SSE = SSEFinder_005_19(FOS_1,FOS1_yt);
FOS2_SSE = SSEFinder_005_19(FOS_2,FOS2_yt);
FOS3_SSE = SSEFinder_005_19(FOS_3,FOS3_yt);
FOS4_SSE = SSEFinder_005_19(FOS_4,FOS4_yt);
FOS5_SSE = SSEFinder_005_19(FOS_5,FOS5_yt);

% compute meanSSE
SSE1_mean = mean(FOS1_SSE);
SSE2_mean = mean(FOS2_SSE);
SSE3_mean = mean(FOS3_SSE);
SSE4_mean = mean(FOS4_SSE);
SSE5_mean = mean(FOS5_SSE);

%% Print Results
fprintf('FOS-1''s tau_mean is %.4f, tau_std is %.4f\n',tau1_mean,tau1_std);
fprintf('FOS-2''s tau_mean is %.4f, tau_std is %.4f\n',tau2_mean,tau2_std);
fprintf('FOS-3''s tau_mean is %.4f, tau_std is %.4f\n',tau3_mean,tau3_std);
fprintf('FOS-4''s tau_mean is %.4f, tau_std is %.4f\n',tau4_mean,tau4_std);
fprintf('FOS-5''s tau_mean is %.4f, tau_std is %.4f\n',tau5_mean,tau5_std);
fprintf('\n');
fprintf('FOS-1''s SSE_mean is %.4f\n',SSE1_mean);
fprintf('FOS-2''s SSE_mean is %.4f\n',SSE2_mean);
fprintf('FOS-3''s SSE_mean is %.4f\n',SSE3_mean);
fprintf('FOS-4''s SSE_mean is %.4f\n',SSE4_mean);
fprintf('FOS-5''s SSE_mean is %.4f\n',SSE5_mean);
fprintf('\n');
%% Regression Analysis
[SSE,SST,r_2]=Project_M4Regression_005_19(FourValue(end,:));
fprintf('SSE=%.4f, SST=%.4f, r_2=%.4f.\n',SSE,SST,r_2);

%% Algorithm Insight
%{
% % Import Data of M2 Heating
% m2 = csvread('M2_Data_HEATING_NoisyCalibration.csv');
% ti2 = m2(:,1);
% te2 = m2(:,2);
% [Varm3,conditionm3]=Project_M3Algorithm_005_19(ti2,te2);    % Compute with M3 algorithm
% [Varm4,conditionm4]=Project_M4Algorithm_005_19(ti2,te2);    % Compute with M4 algorithm
% ytm3 = FirstOrder_005_019(Varm3,ti2,conditionm3);           % Find predicted values by M3 algorithm
% ytm4 = FirstOrder_005_019(Varm4,ti2,conditionm4);           % Find predicted values by M4 algorithm
% ytac = FirstOrder_005_019([1.84,-0.96,98.75,1.35],ti2,1);   % Compute predicted values by actual values
% % Graphing
% figure('Name','Insights Gained for Cooling Data in M2');
% plot(ti2,ytac,'b-','LineWidth',4);
% hold on;
% plot(ti2,ytm3,'r--','LineWidth',3);
% plot(ti2,ytm4,'g-.','LineWidth',2);
% hold off;
% grid on;
% title('Tau Improvements Insights of M3 and M4');
% xlabel('Time [seconds]');
% ylabel('Temperature [degrees Celsius]');
% legend('Actual Values','M3''s Values','M4''s Values','Location','SouthEast');
% 
% % The results of M4 algorithm actually predicted the values better in the
% % middle of the curve and this enables the algorithm to compute a more
% % accurate tau value.
% % The tau value computed by M4 is 1.34 while that by M3 is 1.37 and the
% % actual tau value is 1.35. This proves that M4 algorithm computes more
% % accurate tau value than M3 algorithm. 
%}


