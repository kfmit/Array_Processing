%% 6.056 Array Processing
%% Lab 2
%% Kathryn Fung

clear
close all
clc

%% Run and Load Files
filename1 = 'array_process_feels.wav';
[n1,f1] = audioread(filename1);
info1 = audioinfo(filename1);
%% Processing
t1 = 0:seconds(1/f1):seconds(info1.Duration);
t1 = t1(1:end-1);
figure
plot(t1,f1)
xlabel('Time')
ylabel('Audio, idk Units')