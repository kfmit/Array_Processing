%% Lab2_Section5.3
%%

clear all
close all
clc


rng default
% Fs = 1000;
% t = 0:1/Fs:1-1/Fs;
% x = cos(2*pi*100*t) + randn(size(t));

fs = 1000; % Hz (sample/sec)
dt = 1/fs; % seconds per sampl (
TT1 = 30; %length of sample
TT2 = 1;
f0 = 100.33;                        % Hz -- our actual freq
T = 1/f0;                      % period of sampling in s
t1 = [0:dt:TT1];                 % length of time increments, length equal to two period (2*T)
t2 = [0:dt:TT2]; 
w0 = 2*pi*f0;                   % omega of our actual signal

s1 = sin(w0*t1);
s2 = sin(w0*t2);
N = round(2*T*fs); % number of samples, odd
n = 0:N-1;  %

N1=length(s1); 
fft1 =fft(s1);
fft1 = fft1(1:N1/2+1);

psdn1 = (1/(fs*N1))* abs(fft1).^2;
psdn1(2:end-1) = 2*psdn1(2:end-1);
freq1 = 0:fs/length(s1):fs/2;

N2=length(s2); 
fft2 =fft(s2);
fft2 = fft2(1:N2/2+1);

psdn2 = (1/(fs*N2))* abs(fft2).^2;
psdn2(2:end-1) = 2*psdn2(2:end-1); 
freq2 = 0:fs/length(s2):fs/2; 


figure (1)
plot(freq1,10*log10(psdn1))
title('PSD Using FFT T=30')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')

figure (2)
plot(freq2,10*log10(psdn2))
title('PSD Using FFT T=1')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')