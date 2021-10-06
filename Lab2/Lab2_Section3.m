%% 6.056 Array Prrocessing
%% Kathryn Fung

clear all
clc
close all

% New functions
% generate the signal
fs = 25; % Hz (sample/sec)
dt = 1/fs; % seconds per sampl (
%length of sample
f0 = 7;                        % Hz -- our actual freq
T = 1/f0;                      % period of sampling in s
t = [0:dt:2*T];                 % length of time increments, length equal to two period (2*T)
w0 = 2*pi*f0;                   % omega of our actual signal
zerosize = length([0:dt:10*T]); % this should be 10 periods
%f1 = zeros(zerosize,1);

%for i=1:length(t)
%f1(i) = sin(w0*t(i));                  % f1 of the signal we made, our samples
%end

f1 = sin(w0*t)
N = 2*T*fs; % number of samples
n = 0:N-1;
t1=(0:length(f1)-1)/fs;

%f1 = sin(w0*n*t); % f1 of the signal we made, our samples

%% Plot the Plot
% Time Domain
figure(1)
plot(t1,f1)
hline(0,'black')
title(['Sin Signal fs=' num2str(fs)])
xlabel('Time')
ylabel('Amplitude, Unitless')
legend('Sin Wave','Zero Line')

%% Frequency Domain (FFT)
fft1 = fft(f1,zerosize);
% just gonna use the first channel her
ff1 = ((0:length(fft1)-1)*fs)/length(fft1);
%ff1 =ff1/1000;

% FFT figure
figure(2)
plot(ff1,abs(fft1))
xlim([0 fs/2])
title(['FFT of Sin Signal fs=' num2str(fs)])
xlabel('f (Hz)')
ylabel('Amplitude')

%% Zero Padding Using Matlab function
