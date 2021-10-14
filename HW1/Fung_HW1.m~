%% 6.056 HW 1
%% Kathryn Fung
%% Collab with: Matt Flores, Nic 

clear all
close all
clc

% Problem 1.1: see document
% Problem 1.2: see document
% Problem 1.3: see document

% Problem 2: Creating a 7 element array
N = 7;  % Number of elements
D = 0.5; % Element spacing (m)
set(gca,'CameraViewAngle',4.4);
ula = phased.ULA('NumElements',N,'ElementSpacing',D);
viewArray(ula,'Title','Uniform Linear Array (ULA)')

fc = 1e9;
ang = [0;0];
resp = ula(fc,ang)

%c = physconst('SoundSpeed');m/s, waterspeed

c = 1500; %
pattern(ula,fc,-180:180,0,'PropagationSpeed',c,...
    'CoordinateSystem','rectangular',...
    'Type','powerdb','Normalize',true)

%% Problem 3: Van Trees 2.4.6

%% Problem 4: Van Trees 2.7.1
