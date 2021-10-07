%% Lab 2 Section 4
%%

clear all
close all
clc

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

f1 = sin(w0*t);
N = round(2*T*fs); % number of samples, odd
n = 0:N-1;  %
t1=(0:length(f1)-1)/fs;

Ninterp = 10;
vectorsize = Ninterp*N;

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
fft1 = fft(f1,N);
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

%% Pad and Reverse
zeropad = zeros(vectorsize,1);
zeropad(1:4) = fft1(1:4);
zeropad(68:70) = fft1(5:7);

newsignal = 2*ifft(zeropad,N)       % increasing this N DRASTICALLY improves performance
tnew = (0:length(newsignal)-1)/fs;

figure(3)
plot(t1,f1)
hline(0,'black')
hold on
plot(tnew,newsignal)
title(['Sin Signal fs=' num2str(fs)])
xlabel('Time')
ylabel('Amplitude, Unitless')
legend('Sin Wave','Zero Line','Inverse signal')
