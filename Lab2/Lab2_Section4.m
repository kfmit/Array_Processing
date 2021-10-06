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

f1 = sin(w0*t)
N = 2*T*fs; % number of samples
n = 0:N-1;
t1=(0:length(f1)-1)/fs;

%f1 = sin(w0*n*t); % f1 of the signal we made, our samples
%% 