% Created by Huang Lu, Department of Electronic Engineering, Tsinghua University
% 2015/10/30, Friday, Beijing
% Code for Homework 3 of Communication and Network

% Generate the Source Signal
clear all; close all; clc;
p0 = 0.8;                       % Probability of 0
x0 = rand(1,1000);              % Uniform Distribution in [0,1]
x0(x0<p0) = 0;                  % Get the Source Signal
x0(x0>=p0) = 1;
figure(1); stairs(x0);          % Figure of the Original Signal
title('Original Source Signal')
set(gca,'Ylim', [-0.5, 1.5])

% AMI Code
c1 = [1, 0];
c2 = [0, 0];
c3 = [-1, 0];
AMI_code = zeros(1, 21);    % AMI Code without Returning to 0
AMI_code0 = zeros(1, 41);   % AMI Code with Returning to 0
f1 = x0(1);                 % Initial the fk, fk = fk-1 = x(0)    
for m = 1:1:21
    f0 = f1;                    % Update fk-1
    f1 = ~(x0(m)==f0);          % Update fk
    if x0(m) == 0               % Get AMI Code
        AMI_code0(2*m-1:2*m) = c2;
        AMI_code(m) = 0;
    else
        if f1 == 1
            AMI_code0(2*m-1:2*m) = c1;
            AMI_code(m) = 1;
        else
            AMI_code0(2*m-1:2*m) = c3;
            AMI_code(m) = -1;
        end
    end
    
end
figure(2); 
subplot(3,1,1); stairs(x0(1:21),'r'); % Figure of the Original Signal
title('Original Source Signal')
set(gca,'Ylim', [-0.5, 1.5])
set(gca,'Xlim', [1, 21])
set(gca,'xtick',[1:1:21],'xticklabel',[0:1:20]) 
grid on;
subplot(3,1,2); stairs(AMI_code,'r'); % Figure of the AMI Code without Returning to 0
title('Original AMI Code without Returning to Zero')
set(gca,'Ylim', [-1.5, 1.5])
set(gca,'Xlim', [1, 21])
set(gca,'xtick',[1:1:21],'xticklabel',[0:1:20]) 
grid on;
subplot(3,1,3); stairs(AMI_code0,'r');% Figure of the AMI Code with Returning to 0
title('Original AMI Code with Returning to Zero')
set(gca,'Ylim', [-1.5, 1.5])
set(gca,'Xlim', [1, 41])
set(gca,'xtick',[1:2:41],'xticklabel',[0:1:20]) 
grid on;

% HDB3 Code

% Miller Code

% Power Spectrum