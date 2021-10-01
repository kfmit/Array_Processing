%% 6.056 Array Processing
%% Lab 2
%% Kathryn Fung

clear all
close all
clc

%% Run and Load Files
filename1 = 'ilove.wav';
[n1,f1] = audioread(filename1);
info1 = audioinfo(filename1);
Fs = info1.SampleRate
%% Time Processing
t1 = 0:seconds(1/f1):seconds(info1.Duration);
t1 = t1(1:end-1);
% WE ARE CUTTING OFF BEFORE 1.7 sec


%% Apparently i have two channels? idk
figure(1)
plot(t1,n1)
hline(0,'black')
title('Time vs Freq for Nics Audio')
xlabel('Time')
ylabel('Audio Amplitude, Unitless')
legend('','Channel 1', 'Zero Line')
flim = Fs/2;
%xlim([0 flim])
% for playback:  sound(n1,f1)

%% Plot freq
fft1 = fft(n1(:,1));

ff1 = (0:length(n1)-1)*Fs/length(n1);

% FFT figure
% this looks wrong, will have to check
figure(2)
plot(ff1,abs(fft1))

title('FFT of I love AP')
xlim([0 Fs/2])
xlabel('f (Hz)')
ylabel('Amplitude')
% there 

%% Making a Spectrogram of the Data, Rough, my try
figure(3)
spectrogram(n1(:,1))
title('Spectrogram of I love AP')
%xlim([0 flim])

%%
Nx = length(n1);
nsc = floor(Nx/4.5);
nov = floor(0.75*nsc);
nff = max(256,2^nextpow2(nsc));

figure(4)
[s, f,t] = spectrogram(n1(:,1),hamming(nsc),nov,nff, Fs);
imagesc(t,f,log(abs(s)))
h = colorbar;
set(get(h,'label'),'string','dB no ref');
axis xy
title('Spectrogram of I love AP')
xlabel('Actual f (kHz)')
ylabel('Samples')


%maxerr = max(abs(abs(t(:))-abs(s(:))))








%% Lab 2 Part 2-----------------------------------------------------------------------------------
clear all
close all
clc

%% Run and Load Files
% Julien1 is the phone line tone
filename2 = 'Julien1.wav';
[n1,f1] = audioread(filename2);
info1 = audioinfo(filename2);
Fs = info1.SampleRate
% Time Processing
% t1 = 0:seconds(1/f1):seconds(info1.Duration);
% t1 = 0:(1/f1):(info1.Duration);
% t1 = t1(1:end-1);
t1=(0:length(n1)-1)/Fs;

%% Plotting time series
figure(1)
plot(t1,n1)
hline(0,'black')
title('Phone Tone Audio')
xlabel('Time')
ylabel('Audio Amplitude, Unitless')
legend('Channel 1','Zero Line')
flim = Fs/2;
%xlim([0 flim])
% for playback:  sound(n1,f1)

%% Plot freq
fft1 = fft(n1(:,1));
% just gonna use the first channel her


ff1 = (0:length(n1)-1)*Fs/length(n1);
%ff1 =ff1/1000;

% FFT figure
% this looks wrong, will have to check
figure(5)
plot(ff1,abs(fft1))
xlim([0 Fs/2])
title('FFT of Phone Tone')
xlabel('f (Hz)')
ylabel('Amplitude')
% there 

%% Making a Spectrogram of the Data, Rough, my try
figure(3)
spectrogram(n1)
title('Spectrogram of Phone Tone')
%xlim([0 flim])

%%
Nx = length(n1);
nsc = floor(Nx/4.5);
nov = floor(0.75*nsc);
nff = max(256,2^nextpow2(nsc));

figure(4)
[s,f,t] = spectrogram(n1(:,1),hamming(nsc),nov,nff, Fs);
imagesc(t,f,log(abs(s)))
h = colorbar;
set(get(h,'label'),'string','dB no ref');
axis xy
title('Spectrogram of Phone Tone')
ylabel('Actual f (Hz)')
xlabel('Seconds')

%% Signal Decimation
s = n1;
s_new1 = s(1:N:end);
s_new2 = decimate(s, N);

