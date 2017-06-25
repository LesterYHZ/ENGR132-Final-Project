function sse = SSEFinder_005_19(y,fx)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
%   Calculates SSE
%
% Function Call
% 	SSEFinder_005_19(y,fx)
%
% Input Arguments
%   1. y: original data
%   2. fx: modeling function calculated data
%
% Output Arguments
%   1. sse: SSEmod
%
% Assigment Information
%   Assignment:  	    Final Project, Milestone 4
%   Author:             Sameer Leley, sleley@purdue.edu
%                       Lester Yang, yang1118@purdue.edu
%                       Youssof Ashmawy, yashmawy@purdue.edu
%                       Michael Mayer, Mayer24@gmail.com
%   Team ID:            005-19
%  	Contributor:        Name, login@purdue [repeat for each]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% ____________________
%% INITIALIZATION


%% ____________________
%% CALCULATIONS

dif = y-fx; %calculates the difference between y and fx

sse = (sum((dif).^2))/length(y); %calculates mod sse



%% ____________________
%% FIGURE DISPLAYS


%% ____________________
%% COMMAND WINDOW OUTPUTS



%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I/We have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I/we provided
% access to my/our code to another. The project I/we am/are submitting
% is my/our own original work.