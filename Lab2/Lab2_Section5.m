%% Lab2_Section5
%%

clear all
close all
clc

% New functions
% generate the signal
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
% t1=(0:length(s1)-1)/fs;
% t2=(0:length(s2)-1)/fs;

%% Time Domain
plot(t1,s1)
hline(0,'black')
hold on
plot(t2,s2)
title(['Sin Signal fs=' num2str(fs)])
xlabel('Time')
ylabel('Amplitude, Unitless')
legend('Sin Wave','Zero Line')

%%
% for T =30
N1=length(s1); 
nfft=N1; 
[psd_s1,f_per1]=periodogram(s1,rectwin(N1),nfft,fs);        %power density
[ps_s1,f_per1]=periodogram(s1,rectwin(N1),nfft,fs,'power'); %power spectrum


% for T = 1
N2=length(s2); 
nfft=N2; 
[psd_s2,f_per2]=periodogram(s2,rectwin(N2),nfft,fs);        % power density
[ps_s2,f_per2]=periodogram(s2,rectwin(N2),nfft,fs,'power'); % power spectrum

%% Plots
figure(2)
plot(f_per1,ps_s1,'o')
hold on
plot(f_per1,psd_s1)


plot(f_per2,ps_s2,'d')
hold on
plot(f_per2,psd_s2,'LineWidth',3)
plot(f_per2,ps_s2)
xlabel('Frequency')
ylabel('Power/frequency (dB/(rad/sample))')
title('Periodogram Power Spectrum and Power Density Estimate')
legend('T=30s Spectral','T=30 Density','T=1s Spectral','T=1 Density')


% plot(f_per2,ps_s2)
