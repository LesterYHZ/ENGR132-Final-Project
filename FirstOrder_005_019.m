function [y_t] = FirstOrder_005_019(Var,t,condition)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 Program Description 
% This function helps to compute the predicted value with First Order
% equation. Used to calculate SSEmod
%
% Function Call
% 	[y_t] = FirstOrder_005_019(Var,t,condition)
%
% Input Arguments
%	1. Var: vector of ts,y_L,y_H,tau
%   2. t: time
%   3. condition: heating or cooling (1/0)
%
% Output Arguments
%	1. y_t = the model generated data set
%
% Assignment Information
%	Assignment:         Project M4
%	Author:             Lester Yang, yang1118@purdue.edu
%                       Sameer Leley, sleley@purdue.edu
%                       Michael Mayer, Mayer24@purdue.edu
%  	Team ID:            005-19    
%  	Paired Programmer:  Name, login@purdue.edu
%  	Contributor:        Name, login@purdue [repeat for each contributor]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Assign Data
ts=Var(1);
y_L=Var(2);
y_H=Var(3);
tau=Var(4);

%% Compute y_t
if condition %heating data
    idx=find(t<ts); %all t values less than ts
    y_t(idx)=y_L; %before ts yt = yl
    idx=find(t>=ts); %all t values greater than ts
    y_t(idx)=y_L+(y_H-y_L)*(1-exp(-(t(idx)-ts)/tau)); 
    %calculates piecewise graph
    
else %cooling data
    idx=find(t<ts); %all t values less than ts
    y_t(idx)=y_H; %yt = yh
    idx=find(t>=ts); %all t values greater than ts
    y_t(idx)=y_L+(y_H-y_L)*exp(-(t(idx)-ts)/tau);
    %calculates yt based on piecewise function
    
end


end