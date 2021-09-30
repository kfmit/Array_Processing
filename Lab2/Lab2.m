%% 6.056 Array Processing
%% Lab 2
%% Kathryn Fung

clear
close all
clc

%% Run and Load Files
filename1 = 'matlab_crash.wav';
[n1,f1] = audioread(filename1);
info1 = audioinfo(filename1);
Fs = info1.SampleRate
%% Time Processing
t1 = 0:seconds(1/f1):seconds(info1.Duration);
t1 = t1(1:end-1);

%% Apparently i have two channels? idk
figure(1)
plot(t1,n1(:,1))
title('MATLAB keeps crashing')
xlabel('Time')
ylabel('Audio, idk Units')
legend('Channel 1', 'Channel 2')
hline(0)
% for playback:  sound(n1,f1)

%% Plot freq
fft1 = fft(n1(:,1));
% just gonna use the first channel her
fft2 = fft(n1(:,2));
L = 1000*info1.Duration;

p2l = round((L/2)+1);
P2 = abs(fft1/L);
P1 = P2(1:p2l);
P1(2:end-1) = 2*P1(2:end-1);

ff1 = Fs.*(0:(L/2))/L;

%% FFT figure
% this looks wrong, will have to check
figure(2)
plot(ff1,P1)
title('FFT of MATLAB crash')
xlabel('f (kHz)')
ylabel('Amplitude')
% there 

%% Making a Spectrogram of the Data
figure(3)
spectrogram(n1(:,1))
xlabel('Samples')
ylabel('Normalized Frequency \pi radians/sample')
title('Spectrogram of MATLAB crash Audio')

Nx = length(n1);
nsc = floor(Nx/4.5);
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));

figure(4)
t = spectrogram(x,hamming(nsc),nov,nff);

maxerr = max(abs(abs(t(:))-abs(s(:))))