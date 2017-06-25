function  [SSE,SST,r_2]=Project_M4Regression_005_19(tau)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 Program Description 
%	This function helps understand thermocouple price as a function of
%	performance (time constant).
%
% Function Call
% 	price = Project_M4Regression_005_19(tau)
%
% Input Arguments
%	1. tau: time constant
% Output Arguments
%	1. SSE
%   2. SST
%   3. r_2: r-squared
% Assignment Information
%	Assignment:         Project M4
%	Author:             Lester Yang, yang1118@purdue.edu
%                       Sameer Leley, sleley@purdue.edu

%                       Michael Mayer, Mayer24@gpurdue.edu
%  	Team ID:            005-19    
%  	Paired Programmer:  Name, login@purdue.edu
%  	Contributor:        Name, login@purdue [repeat for each contributor]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Assign Data Into seperate vectors
tau1 = tau(1:20);
tau2 = tau(21:40);
tau3 = tau(41:60);
tau4 = tau(61:80);
tau5 = tau(81:100);
tau_mean = [mean(tau1),mean(tau2),mean(tau3),mean(tau4),mean(tau5)];

%create vectors of price data to be the y val for tau data
price1 = 15.77*ones(1,20);
price2 = 10.61*ones(1,20);
price3 = 2.69*ones(1,20);
price4 = 1.23*ones(1,20);
price5 = 0.11*ones(1,20);
price = [price1,price2,price3,price4,price5];
price_ = [15.77,10.61,2.69,1.23,0.11];
%% Regression
P=polyfit(tau,log10(price),1); %polyfit of semilog y data
m=P(1);
b=P(2);
B=10^b; %convert it to proper format for exponential equation

price_fit = B*10.^(m*tau_mean);
price_fit_ = B*10.^(m*tau);
fprintf('Price = %.4f * 10^(%.4f*Tau)\n',B,m);

SSE = sum((price-price_fit_).^2); %calculate sse
SST = sum((price-mean(price)).^2); %calculate sst
r_2 = 1-SSE/SST; %calculate r_2

%% Figure Display
figure('Name','Regression Analysis');
plot(tau1,price1,'bo');
hold on;
plot(tau2,price2,'co');
plot(tau3,price3,'go');
plot(tau4,price4,'ko');
plot(tau5,price5,'mo');
plot(tau_mean,price_fit,'r-','LineWidth',3);
grid on;
xlabel('Time Constant [seconds]');
ylabel('Unit Price [dollars]');
title('Price versus Time Constants Before and After Regression');
legend('FOS1','FOS2','FOS3','FOS4','FOS5','Regression: price=34.5099*10^(-1.2942*tau)',...
    'Location','NorthEast');
%% Figure Display Testing
% figure(1);
% subplot(2,2,1);
% plot([tau1,tau2,tau3,tau4,tau5],...
%     [price1,price2,price3,price4,price5],...
%     'bo')
% subplot(2,2,2);
% semilogx([tau1,tau2,tau3,tau4,tau5],...
%     [price1,price2,price3,price4,price5],...
%     'bo')
% subplot(2,2,3);
% semilogy([tau1,tau2,tau3,tau4,tau5],...
%     [price1,price2,price3,price4,price5],...
%     'bo')
% subplot(2,2,4);
% loglog([tau1,tau2,tau3,tau4,tau5],...
%     [price1,price2,price3,price4,price5],...
%     'bo')
end

