% Created by Huang Lu, Department of Electronic Engineering, Tsinghua University
% 2015/10/31, Friday, Beijing
% Code for Homework 3 of Communication and Network

% Generate the Original Signal
clear all; close all; clc;
x0 = rand(1, 100);
x0(x0<0.5) = 0;
x0(x0>=0.5) = 1;

% BPSK Modulation
x2 = zeros(1, 100*100);
f0 = 10;
t0 = 0:0.01:0.99;
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
figure(1)
suptitle('Original Signal and Modulated Signal')
subplot(2,1,1); stairs(x0(1:11),'r');
set(gca, 'Xlim', [1, 11])
set(gca, 'Ylim', [-0.5, 1.5])
set(gca,'xtick',[1:1:11],'xticklabel',[0:1:10])
title('Wave of Original Signal')
grid on;
subplot(2,1,2); plot(x2(1:1000),'r')
set(gca, 'Xlim', [0, 1000])
set(gca, 'Ylim', [-1.5, 1.5])
set(gca,'xtick',[0:100:1000],'xticklabel',[0:1:10])
title('Wave of BPSK Modulation')
grid on;
figure(2); plot(abs(X2),'r')
set(gca,'xtick',[0:1000:10000],'xticklabel',[-50:10:50])
xlabel('Frequency/Hz')
ylabel('H(e^j^\omega)')
title('Power Spectrum Density of BPSK Modulation Wave')

% BPSK Coherent Demodulation
xr = sin(2*pi*f0*(0:0.01:99.99)).*x2;
h1 = ones(1,10);
x3 = conv(xr,h1);
x3 = x3(4:10003);
h2 = ones(1,12);
x4 = conv(xr,h2);
x4 = x4(5:10004);
[x5, N] = Sample_Judge(x3, length(x3), 100);
[x6, N] = Sample_Judge(x3, length(x4), 100);
figure(3)
suptitle('BPSK Coherent Modulation and Demodulation')
subplot(4,2,1), stairs(x0(1:11),'r')
set(gca, 'Xlim', [1, 11])
set(gca, 'Ylim', [-0.5, 1.5])
set(gca,'xtick',[1:1:11],'xticklabel',[0:1:10])
title('Wave of Original Signal')
grid on;
subplot(4,2,3), plot(x1(1:1001),'r')       % figure of original signal
set(gca, 'Xlim', [1, 1001])
set(gca, 'Ylim', [-0.5, 1.5])
set(gca,'xtick',[1:100:1001],'xticklabel',[0:1:10])
title('Sample Wave of Original Signal')
grid on
subplot(4,2,5); plot(x2(1:1001),'r');
set(gca, 'Xlim', [1, 1001])
set(gca, 'Ylim', [-1.5, 1.5])
set(gca,'xtick',[1:100:1001],'xticklabel',[0:1:10])
title('Wave after Modulation')
grid on
subplot(4,2,7); plot(xr(1:1001),'r');
set(gca, 'Xlim', [1, 1001])
set(gca, 'Ylim', [-1.5, 1.5])
set(gca,'xtick',[1:100:1001],'xticklabel',[0:1:10])
title('Wave after Multiplied by Carrier')
grid on
subplot(4,2,2); plot(x3(1:1001),'r')
set(gca, 'Xlim', [1, 1001])
set(gca,'xtick',[1:100:1001],'xticklabel',[0:1:10])
title('Wave after Filter by Ten 1')
grid on
subplot(4,2,4); stairs(x5(1:11),'r')
set(gca, 'Xlim', [1, 11])
set(gca, 'Ylim', [-0.5, 1.5])
set(gca,'xtick',[1:1:11],'xticklabel',[0:1:10])
title('Wave after Judged by Ten 1')
grid on
subplot(4,2,6); plot(x4(1:1001),'r')
set(gca, 'Xlim', [1, 1001])
set(gca,'xtick',[1:100:1001],'xticklabel',[0:1:10])
title('Wave after Filter by Twelve 1')
grid on
subplot(4,2,8); stairs(x6(1:11),'r')
set(gca, 'Xlim', [1, 11])
set(gca, 'Ylim', [-0.5, 1.5])
set(gca,'xtick',[1:1:11],'xticklabel',[0:1:10])
title('Wave after Judged by Twelve 1')
grid on

% BPSK Non-coherent Demodulation
f0 = 10.05;
xr = sin(2*pi*f0*(0:0.01:99.99)).*x2;
h1 = ones(1,10);
x3 = conv(xr,h1);
x3 = x3(4:10003);
[x5, N] = Sample_Judge(x3, length(x3), 100);
figure(4)
suptitle('BPSK Modulation and Non-coherent Demodulation')
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
subplot(3,2,6); stairs(x5(1:21),'r')
set(gca, 'Xlim', [1, 21])
set(gca, 'Ylim', [-0.5, 1.5])
set(gca,'xtick',[1:1:21],'xticklabel',[0:1:20])
title('Wave after Judged by Ten 1')
grid on

% DPSK Modulation & Differential Coherent Demodulation x10, x10.25 or x10.5
save('data.mat', 'x0');
clear all;
load data.mat;
f0 = 10;
% f0 = 10.25;
% f0 = 10.5;
xdiff = zeros(1,100);
xdiff(1) = x0(1);
for m = 2:100
    xdiff(m) = (xdiff(m-1) ~= x0(m));
end
xa = zeros(1, 100*100);
t0 = 0:0.01:0.99;
m = 1;
if xdiff(1) == 1
    xa((m-1)*100+1:m*100) = sin(2*pi*f0*t0);
else
    xa((m-1)*100+1:m*100) = sin(2*pi*f0*t0+pi);
end
k0 = xdiff(m);
for m = 2:100
    if xdiff(m) == k0 && k0 == 1
        xa((m-1)*100+1:m*100) = sin(2*pi*f0*t0);
    elseif xdiff(m) == k0 && k0 == 0
        xa((m-1)*100+1:m*100) = sin(2*pi*f0*t0+pi);
    elseif xdiff(m) ~= k0 && k0 == 1
        xa((m-1)*100+1:m*100) = sin(2*pi*f0*t0+pi);
    else
        xa((m-1)*100+1:m*100) = sin(2*pi*f0*t0);
    end
    k0 = xdiff(m);
end
xc = xa(101:10000) .* xa(1:9900);
h0 = ones(1,10);
xd = conv(h0, xc);
[xe, N] = Sample_Judge(xd, length(xd), 100);
xe = -(xe-0.5)+0.5;
figure(5)
suptitle('DPSK Modulation & Differential Coherent Demodulation x10')
% suptitle('DPSK Modulation & Differential Coherent Demodulation x10.25')
% suptitle('DPSK Modulation & Differential Coherent Demodulation x10.5')
subplot(4,2,1); stairs(x0(1:12),'r')
set(gca, 'Xlim', [1, 12])
set(gca, 'Ylim', [-0.5, 1.5])
set(gca,'xtick',[1:1:12],'xticklabel',[0:1:11])
title('Wave of Original Signal')
grid on;
subplot(4,2,3); stairs(xdiff(1:12),'r')
set(gca, 'Xlim', [1, 12])
set(gca, 'Ylim', [-0.5, 1.5])
set(gca,'xtick',[1:1:12],'xticklabel',[0:1:11])
title('Wave of Differential Signal')
grid on;
subplot(4,2,5); plot(sin(2*pi*f0*(0:0.01:10.99)), 'r')
set(gca, 'Xlim', [1, 1101])
set(gca, 'Ylim', [-1.5, 1.5])
set(gca,'xtick',[1:100:1101],'xticklabel',[0:1:11])
title('Wave of the Carrier')
subplot(4,2,7); plot(xa(1:1101), 'r')
set(gca, 'Xlim', [1, 1101])
set(gca, 'Ylim', [-1.5, 1.5])
set(gca,'xtick',[1:100:1201],'xticklabel',[0:1:11])
title('(a): Wave after Modulation')
grid on
subplot(4,2,2); plot(xa(1:1001), 'r')
set(gca, 'Xlim', [-99, 1001])
set(gca, 'Ylim', [-1.5, 1.5])
set(gca,'xtick',[-99:100:1001],'xticklabel',[0:1:11])
title('(b): Wave Delayed')
grid on
subplot(4,2,4); plot(xc(1:1001), 'r')
set(gca, 'Xlim', [-99, 1001])
set(gca, 'Ylim', [-1.5, 1.5])
set(gca,'xtick',[-99:100:1001],'xticklabel',[0:1:11])
title('(c): Wave after Multiplying')
grid on
subplot(4,2,6); plot(xd(1:1001), 'r')
set(gca, 'Xlim', [-99, 1001])
set(gca,'xtick',[-99:100:1001],'xticklabel',[0:1:11])
title('(d): Wave after filtering')
grid on
subplot(4,2,8); stairs(xe(1:12), 'r')
set(gca, 'Xlim', [0, 11])
set(gca, 'Ylim', [-0.5, 1.5])
set(gca,'xtick',[0:1:11],'xticklabel',[0:1:11])
title('(e): Wave after Judge')
grid on

