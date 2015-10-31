% Created by Huang Lu, Department of Electronic Engineering, Tsinghua University
% 2015/10/30, Friday, Beijing
% Code for Homework 3 of Communication and Network

% Generate the Source Signal
clear all; close all; clc;
p0 = 0.8;                       % Probability of 0
x0 = rand(1,1000);              % Uniform Distribution in [0,1]
x0(x0<p0) = 0;                  % Get the Source Signal
x0(x0>=p0) = 1;

% AMI Code
c1 = [1, 0];
c2 = [0, 0];
c3 = [-1, 0];
AMI_code = zeros(1, 2000);   % AMI Code with Returning to 0
f1 = x0(1);                   % Initial the fk, fk = fk-1 = x(0)    
for m = 1:1:1000
    f0 = f1;                    % Update fk-1
    f1 = ~(x0(m)==f0);          % Update fk
    if x0(m) == 0               % Get AMI Code
        AMI_code(2*m-1:2*m) = c2;
    else
        if f1 == 1
            AMI_code(2*m-1:2*m) = c1;
        else
            AMI_code(2*m-1:2*m) = c3;
        end
    end
    
end

% HDB3 Code
HDB3_code = AMI_code;
h1 = [1, 0, 0, 0, 0, 0, 1, 0];
h2 = [-1, 0, 0, 0, 0, 0, -1, 0];
for m = 1:2:1993
    if HDB3_code(m+6) ~= 0
        for n = m+4:-2:1
            if HDB3_code(n) ~= 0
                flag = HDB3_code(n);
                if  HDB3_code(m+6) == flag
                    HDB3_code(m+6) = -flag;
                end
                break;
            end
        end
    end
    if HDB3_code(m:m+7) == [0, 0, 0, 0, 0, 0, 0, 0]
        if m == 1
            HDB3_code(m:m+7) = h1;
        else
            if HDB3_code(m-2) == 1
                HDB3_code(m:m+7) = h2;
            else 
                HDB3_code(m:m+7) = h1;
            end
        end
    end
end

% Miller Code
Miller_code = zeros(1, 2000);
m = 1;
while(m<=1000)
    if x0(m) == 1
        if m > 1
            if Miller_code(2*m-2) == 1;
                Miller_code(2*m-1:2*m) = [1, 0];
            else
                Miller_code(2*m-1:2*m) = [0, 1];
            end
        else
            Miller_code(2*m-1:2*m) = [0, 1];
        end
        m = m + 1;
    elseif (m < 1000) & (x0(m:m+1) == [0, 0])
        if m > 1
            if Miller_code(2*m-2) == x0(m-1)
                Miller_code(2*m-1:2*m+2) = [1, 1, 0, 0];
            else
                Miller_code(2*m-1:2*m+2) = [0, 0, 1, 1];
            end
        else
            Miller_code(2*m-1:2*m+2) = [0, 0, 1, 1];
        end
        m = m + 2;
    else
        if m > 1
            if Miller_code(2*m-2) ~= x0(m-1)
                Miller_code(2*m-1:2*m) = [0, 0];
            else
                Miller_code(2*m-1:2*m) = [1, 1];
            end
        else
            Miller_code(2*m-1:2*m) = [0, 0];
        end
        m = m + 1;
    end
end

% Sample by x8
xx0 = zeros(1, 8000);
xx_AMI = zeros(1, 8000);
xx_HDB3 = zeros(1, 8000);
xx_Miller = zeros(1, 8000);
for m = 1:length(x0)
    if x0(m) == 1
        xx0((m-1)*8+1:m*8) = [1,1,1,1,1,1,1,1];
    end
end
clear x0;
for m = 1:length(AMI_code)
    if AMI_code(m) == 1;
        xx_AMI((m-1)*4+1:m*4) = [1,1,1,1];
    elseif AMI_code(m) == -1;
        xx_AMI((m-1)*4+1:m*4) = [-1,-1,-1,-1];
    end
end
clear AMI_code;
for m = 1:length(HDB3_code)
    if HDB3_code(m) == 1;
        xx_HDB3((m-1)*4+1:m*4) = [1,1,1,1];
    elseif HDB3_code(m) == -1;
        xx_HDB3((m-1)*4+1:m*4) = [-1,-1,-1,-1];
    end
end
clear HDB3_code
for m = 1:length(Miller_code)
    if Miller_code(m) == 1;
        xx_Miller((m-1)*4+1:m*4) = [1,1,1,1];
    end
end
clear Miller_code

figure(1); 
subplot(4,1,1); plot(xx0(1:160),'r'); % Figure of the Original Signal
title('Original Signal')
set(gca,'Ylim', [-0.5, 1.5])
set(gca,'Xlim', [1, 161])
set(gca,'xtick',[1:8:161],'xticklabel',[0:1:20]) 
grid on;
subplot(4,1,2); plot(xx_AMI(1:160),'r');% Figure of the AMI Code
title('AMI Code')
set(gca,'Ylim', [-1.5, 1.5])
set(gca,'Xlim', [1, 161])
set(gca,'xtick',[1:8:161],'xticklabel',[0:1:20]) 
grid on;
subplot(4,1,3); plot(xx_HDB3(1:160),'r');% Figure of the HDB3 Code
title('HDB3 Code')
set(gca,'Ylim', [-1.5, 1.5])
set(gca,'Xlim', [1, 161])
set(gca,'xtick',[1:8:161],'xticklabel',[0:1:20]) 
grid on;
subplot(4,1,4); plot(xx_Miller(1:160),'r');% Figure of the Miller Code
title('Miller Code')
set(gca,'Ylim', [-0.5, 1.5])
set(gca,'Xlim', [1, 161])
set(gca,'xtick',[1:8:161],'xticklabel',[0:1:20]) 
grid on;


% Power Spectrum Density
figure(2)
X0 = fftshift(fft(xx0));
X0 = abs(X0).^2;
X0 = X0/max(X0);
subplot(2,2,1); plot(X0)
title('Power Spectrum Density of Original Signal');
xlabel('fT'), ylabel('Power Spectrum')
set(gca, 'Xlim', [4000,5000])
set(gca,'xtick',[4000:500:5000],'xticklabel',{'0', '0.5', '1.0'}) 
X_AMI = fftshift(fft(xx_AMI));
X_AMI = abs(X_AMI).^2;
X_AMI = X_AMI/max(X_AMI);
subplot(2,2,2); plot(X_AMI)
title('Power Spectrum Density of AMI Code with Returing Zero');
xlabel('fT'), ylabel('Power Spectrum')
set(gca, 'Xlim', [4000,5000])
set(gca,'xtick',[4000:500:5000],'xticklabel',{'0', '0.5', '1.0'}) 
X_HDB3 = fftshift(fft(xx_HDB3));
X_HDB3 = abs(X_HDB3).^2;
X_HDB3 = X_HDB3/max(X_HDB3);
subplot(2,2,3); plot(X_HDB3)
title('Power Spectrum Density of HDB3 Code');
xlabel('fT'), ylabel('Power Spectrum')
set(gca, 'Xlim', [4000,5000])
set(gca,'xtick',[4000:500:5000],'xticklabel',{'0', '0.5', '1.0'}) 
X_Miller = fftshift(fft(xx_Miller));
X_Miller = abs(X_Miller).^2;
X_Miller = X_Miller/max(X_Miller);
subplot(2,2,4); plot(X_Miller)
title('Power Spectrum Density of Miller Code');
xlabel('fT'), ylabel('Power Spectrum')
set(gca, 'Xlim', [4000,5000])
set(gca,'xtick',[4000:500:5000],'xticklabel',{'0', '0.5', '1.0'}) 
