% Created by Huang Lu, Department of Electronic Engineering, Tsinghua University
% 2015/10/30, Friday, Beijing
% Code for Homework 3 of Communication and Network

% Generate the Original Signal
clear all; close all; clc;
x0 = rand(1, 100);
x0(x0<0.5) = 0;
x0(x0>=0.5) = 1;
% figure(1); stairs(x0)       % figure of original signal
% set(gca, 'Ylim', [-0.5, 1.5])
% title('Orignal Signal')

% BPSK Modulation
x1 = zeros(1, 100*100);
f0 = 10;
t0 = 0.01:0.01:1;
for m = 1:100
    if x0(m) == 1
        x1((m-1)*100+1:m*100) = sin(2*pi*f0*t0);
    end
end
X1 = fftshift(fft(x1));
figure(2)
subplot(2,1,1); stairs(x0(1:11));
set(gca, 'Xlim', [1, 11])
set(gca, 'Ylim', [-0.5, 1.5])
set(gca,'xtick',[1:1:11],'xticklabel',[0:1:10])
title('Wave of Original Signal')
grid on;
subplot(2,1,2); plot(x1(1:1000))
set(gca, 'Xlim', [0, 1000])
set(gca, 'Ylim', [-1.5, 1.5])
set(gca,'xtick',[0:100:1000],'xticklabel',[0:1:10])
title('Wave of BPSK Modulation')
grid on;
figure(3); plot(abs(X1))
set(gca,'xtick',[0:1000:10000],'xticklabel',[-50:10:50])
xlabel('Frequency/Hz')
ylabel('H(e^j^\omega)')
title('Power Spectrum Density of BPSK Modulation Wave')

% BPSK Coherent demodulation
xr = sin(2*pi*f0*(0.01:0.01:100));
x2 = xr .* x1;
plot(x2(1:1000))
plot(abs(fftshift(fft(x2))))

