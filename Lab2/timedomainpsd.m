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

psd1 = 0;

for nn=1:N1
    psd1 = psd1+(s1(nn)*exp(-1i*w0*nn*dt)*dt);
end
psd1 = 1/N1*(abs(psd1))^2

%% Kat's try
sig_fun = @(t1) abs(sin(w0.*t1)).^2 ;
power = (1/(TT1))*integral(sig_fun,0,30)


