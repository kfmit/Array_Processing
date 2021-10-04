%% 6.056 Array Prrocessing
%% Kathryn Fung

clear all
clc
close all

% New functions
% generate the signal
fs = 25; % Hz
f0 = 7; %Hz
T = 1/fs; % period of sampling
f = 
N = 1024; % number of samples
n = 0:N-1;

w0 = 2*pi/5;
x = sin(w0*n)+10*sin(2*w0*n);