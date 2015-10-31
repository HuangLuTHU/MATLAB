% Created by Huang Lu, Department of Electronic Engineering, Tsinghua University
% 2015/10/30, Friday, Beijing
% Code for Homework 3 of Communication and Network

% Generate the Original Signal
clear all; close all; clc;
x0 = rand(1, 100);
x0(x0<0.5) = 0;
x0(x0>=0.5) = 1;

% BPSK Modulation
x2 = zeros(1, 100*100);
f0 = 10;
t0 = 0.01:0.01:1;
for m = 1:100
    if x0(m) == 1
        x2((m-1)*100+1:m*100) = sin(2*pi*f0*t0);
        x1((m-1)*100+1:m*100) = 1;
    else
        x2((m-1)*100+1:m*100) = sin(2*pi*f0*t0+pi);
        x1((m-1)*100+1:m*100) = 0;
    end
end
X2 = fftshift(fft(x2));
% figure(1)
% subplot(2,1,1); stairs(x0(1:11));
% set(gca, 'Xlim', [1, 11])
% set(gca, 'Ylim', [-0.5, 1.5])
% set(gca,'xtick',[1:1:11],'xticklabel',[0:1:10])
% title('Wave of Original Signal')
% grid on;
% subplot(2,1,2); plot(x1(1:1000))
% set(gca, 'Xlim', [0, 1000])
% set(gca, 'Ylim', [-1.5, 1.5])
% set(gca,'xtick',[0:100:1000],'xticklabel',[0:1:10])
% title('Wave of BPSK Modulation')
% grid on;
% figure(2); plot(abs(X2))
% set(gca,'xtick',[0:1000:10000],'xticklabel',[-50:10:50])
% xlabel('Frequency/Hz')
% ylabel('H(e^j^\omega)')
% title('Power Spectrum Density of BPSK Modulation Wave')

% BPSK Coherent Demodulation
xr = sin(2*pi*f0*(0.01:0.01:100)).*x2;
h1 = ones(1,10);
x3 = conv(xr,h1);
x3 = x3(4:10003);
h2 = ones(1,12);
x4 = conv(xr,h2);
x4 = x4(5:10004);
x5 = x3 >= 0;
x6 = x4 >= 0;
% figure(3)
% subplot(4,2,1), stairs(x0(1:11),'r')
% set(gca, 'Xlim', [1, 11])
% set(gca, 'Ylim', [-0.5, 1.5])
% set(gca,'xtick',[1:1:11],'xticklabel',[0:1:10])
% title('Wave of Original Signal')
% grid on;
% subplot(4,2,3), plot(x1(1:1001),'r')       % figure of original signal
% set(gca, 'Xlim', [1, 1001])
% set(gca, 'Ylim', [-0.5, 1.5])
% set(gca,'xtick',[1:100:1001],'xticklabel',[0:1:10])
% title('Sample Wave of Original Signal')
% grid on
% subplot(4,2,5); plot(x2(1:1001),'r');
% set(gca, 'Xlim', [1, 1001])
% set(gca, 'Ylim', [-1.5, 1.5])
% set(gca,'xtick',[1:100:1001],'xticklabel',[0:1:10])
% title('Wave after Modulation')
% grid on
% subplot(4,2,7); plot(xr(1:1001),'r');
% set(gca, 'Xlim', [1, 1001])
% set(gca, 'Ylim', [-1.5, 1.5])
% set(gca,'xtick',[1:100:1001],'xticklabel',[0:1:10])
% title('Wave after Multiplied by Carrier')
% grid on
% subplot(4,2,2); plot(x3(1:1001),'r')
% set(gca, 'Xlim', [1, 1001])
% set(gca,'xtick',[1:100:1001],'xticklabel',[0:1:10])
% title('Wave after Demodulation by Ten 1')
% grid on
% subplot(4,2,4); plot(x5(1:1001),'r')
% set(gca, 'Xlim', [1, 1001])
% set(gca, 'Ylim', [-0.5, 1.5])
% set(gca,'xtick',[1:100:1001],'xticklabel',[0:1:10])
% title('Wave after Judged by Ten 1')
% grid on
% subplot(4,2,6); plot(x4(1:1001),'r')
% set(gca, 'Xlim', [1, 1001])
% set(gca,'xtick',[1:100:1001],'xticklabel',[0:1:10])
% title('Wave after Demodulation by Twelve 1')
% grid on
% subplot(4,2,8); plot(x6(1:1001),'r')
% set(gca, 'Xlim', [1, 1001])
% set(gca, 'Ylim', [-0.5, 1.5])
% set(gca,'xtick',[1:100:1001],'xticklabel',[0:1:10])
% title('Wave after Judged by Twelve 1')
% grid on

% BPSK Non-coherent Demodulation
f0 = 10.05;
xr = sin(2*pi*f0*(0.01:0.01:100)).*x2;
h1 = ones(1,10);
x3 = conv(xr,h1);
x3 = x3(4:10003);
x5 = x3 >= 0;
figure(4)
subplot(3,2,1), stairs(x0(1:21),'r')
set(gca, 'Xlim', [1, 21])
set(gca, 'Ylim', [-0.5, 1.5])
set(gca,'xtick',[1:1:21],'xticklabel',[0:1:20])
title('Wave of Original Signal')
grid on;
subplot(3,2,3), plot(x1(1:2001),'r')       % figure of original signal
set(gca, 'Xlim', [1, 2001])
set(gca, 'Ylim', [-0.5, 1.5])
set(gca,'xtick',[1:100:2001],'xticklabel',[0:1:20])
title('Sample Wave of Original Signal')
grid on
subplot(3,2,5); plot(x2(1:2001),'r');
set(gca, 'Xlim', [1, 2001])
set(gca, 'Ylim', [-1.5, 1.5])
set(gca,'xtick',[1:100:2001],'xticklabel',[0:1:20])
title('Wave after Modulation')
grid on
subplot(3,2,2); plot(xr(1:2001),'r');
set(gca, 'Xlim', [1, 2001])
set(gca, 'Ylim', [-1.5, 1.5])
set(gca,'xtick',[1:100:2001],'xticklabel',[0:1:20])
title('Wave after Multiplied by Carrier')
grid on
subplot(3,2,4); plot(x3(1:2001),'r')
set(gca, 'Xlim', [1, 2001])
set(gca,'xtick',[1:100:2001],'xticklabel',[0:1:20])
title('Wave after Demodulation by Ten 1')
grid on
subplot(3,2,6); plot(x5(1:2001),'r')
set(gca, 'Xlim', [1, 2001])
set(gca, 'Ylim', [-0.5, 1.5])
set(gca,'xtick',[1:100:2001],'xticklabel',[0:1:20])
title('Wave after Judged by Ten 1')
grid on

