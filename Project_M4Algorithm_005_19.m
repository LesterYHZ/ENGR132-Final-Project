function [Var,condition]=Project_M4Algorithm_005_19(Time,Temp)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 Program Description 
%	This function shows the four necessary values for each csv files
%
% Function Call
% 	[Var,condition]=Project_M4Algorithm_005_19(Time,Temp)
%
% Input Arguments
%	1. Time
%   2. Temp
% Output Arguments
%	1. Var: vector of ts,y_L,y_H,tau 
%   2. condition: heating or cooling(1/0)
% Assignment Information
%	Assignment:         Project M4
%	Author:             Lester Yang, yang1118@purdue.edu
%                       Sameer Leley, sleley@purdue.edu                       
%                       Michael Mayer, Mayer24@purdue.edu
%  	Team ID:            005-19    
%  	Paired Programmer:  Name, login@purdue.edu
%  	Contributor:        Name, login@purdue [repeat for each contributor]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% initialize data
    n=round(length(Temp)/(max(Temp)-min(Temp)));
%% improve data and consider if it is heating data or cooling data
    Temp=movmean(Temp,n);
    if Temp(1)<Temp(end)
        condition=1; % Heating data
        [ts,y_L,y_H,tau]=Heating2(Time,Temp);
    elseif Temp(1)>Temp(end)
        condition=0; % Cooling data
        [ts,y_L,y_H,tau]=Cooling2(Time,Temp);
    end
            
%% Output results
Var = [ts,y_L,y_H,tau];
end

%% functions needed in the process
%% The first function is to compute four values for cooling data
function [ts,y_l,y_h,TAU]=Cooling2(x,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 Program Description 
%	This function shows the four necessary values for cooling data
%
% Function Call
% 	[ts,y_l,y_h,TAU]=Cooling2(x,y)
%
% Input Arguments
%	1. x: time
%   2. y: temperature
% Output Arguments
%	1. ts
%	2. y_l
%	3. y_h
%	4. TAU
% Assignment Information
%	Assignment:         Project M4
%	Author:             Lester Yang, yang1118@purdue.edu
%                       Sameer Leley, sleley@purdue.edu                       
%                       Michael Mayer, Mayer24@purdue.edu
%  	Team ID:            005-19    
%  	Paired Programmer:  Name, login@purdue.edu
%  	Contributor:        Name, login@purdue [repeat for each contributor]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y=smooth(y,0.01,'lowess'); 
%use smooth function to create cleaner data set

y_min=min(y); %find min 
y_max=max(y); %find max


for k=1:length(x)-1 %for loop to find index of ts in temp data
    if x(k)>=1
        if ((y(k+1)-y(k))/(x(k+1)-x(k)))<=-50
            a=k;
            break;
        end
    end
end
ts=x(a); %assigns ts from index found above

y_h=y(a);

y_l=min(y);


yTau=y_l+(1-0.632)*(y_h-y_l); %yTau calculation
k=find(abs(y-yTau)<=0.33); %finds all of the values within 1 of yTau
        % We used to find tau value in this step by finding the index with
        % y-yTau<=1, and now we make the range smaller in order to have
        % more accurate tau. 
k=k(fix(length(k)/2)); %finds index of mean value

TAU=x(k)-ts; %assigns value of Tau


end


%% the second function compute four values for heatinging data

function [ts,y_l,y_h,tau]=Heating2(x,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 Program Description 
%	This function shows the four necessary values for heating data
%
% Function Call
% 	[ts,y_l,y_h,TAU]=Heating2(x,y)
%
% Input Arguments
%	1. x: time
%   2. y: temperature
% Output Arguments
%	1. ts
%	2. y_l
%	3. y_h
%	4. TAU
% Assignment Information
%	Assignment:         Project M4
%	Author:             Lester Yang, yang1118@purdue.edu
%                       Sameer Leley, sleley@purdue.edu                       
%                       Michael Mayer, Mayer24@purdue.edu
%  	Team ID:            005-19    
%  	Paired Programmer:  Name, login@purdue.edu
%  	Contributor:        Name, login@purdue [repeat for each contributor]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Improve Original Data

	y=smooth(y,0.01,'lowess'); %smooth function to make cleaner data set


y_min=min(y); %find min
y_max=max(y); %find max


%% Compute ts
for k=1:length(x)-1 %for loop to find index of ts
    if x(k)>=1
        if ((y(k+1)-y(k))/(x(k+1)-x(k)))>=50
            a=k;
            break;
        end
    end
end
ts=x(a); %assign value of ts using index from above


%% Compute y_L
y_l=y(a);



%% Compute y_H
y_h=max(y); %find yH



%% Compute tau
yTau=y_l+0.632*(y_h-y_l); %equation for yT
k=find(abs(y-yTau)<=0.33); %find values within 1 of yT
        % We used to find tau value in this step by finding the index with
        % y-yTau<=1, and now we make the range smaller in order to have
        % more accurate tau. 
l=k(fix(length(k)/2)); %find index of mean of k

tau=x(l)-ts; %find tau


end