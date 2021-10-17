%% 6.056 HW 1
%% Kathryn Fung
%% Collab with: Matt Flores, Nic Swanda, Pete Ventola

clear all
close all
clc

% Problem 1.1: see document
% Problem 1.2: see document
% Problem 1.3: see document

% Problem 2: Creating a 7 element array
N = 7;  % Number of elements
lambda= 2; % arbitrary
D = lambda/2; % Element spacing (m)
phi_s = 90;    % steering angle
theta_0 = 90; % broadside
set(gca,'CameraViewAngle',4.4);
ula = phased.ULA('NumElements',N,'ElementSpacing',D);   % just for visual

figure(1)
viewArray(ula,'Title','Uniform Linear Array (ULA)')

fc = 1e9;
ang = [0;0];
% resp = ula(fc,ang)    % some built in function
% for weighting, all uniform
% to turn off an element, change weight to 0


u_s = (D/lambda)*sin(phi_s*pi/180);
angle = -90:0.1:90;
L = length(angle);
C1 = zeros(1,L);

for k=1:L
    u = (d/lambda)*sin(angle(k)*pi/180);
    v = exp(-1i*2*pi*u*(0:M-1).')/sqrt(M); % Azimuth Scanning Steering Vector.
    C1(k) = c'*v;
end
%c = physconst('SoundSpeed');m/s, waterspeed

c = 1500; %
figure(2)
%pattern(ula,fc,-180:180,0,'PropagationSpeed',c,'CoordinateSystem','rectangular','Type','powerdb','Normalize',true)

%%
figure('NumberTitle', 'off','Name','Figure 11.9','Position',[0 0 600 850]);
subplot(2,1,1);
% This plots the instantaneous power for every element (M waveforms).
plot(angle,10*log10(abs(C1).^2));
ylim([-70 5]);
xlim([-90 90]);
grid on;
title('Beampattern Using Definition');
xlabel('Sample Number');
ylabel('Output Power (dB)');
%
subplot(2,1,2);
plot(angle2,10*log10(abs(C2).^2),'r');
grid on;
ylim([-70 5]);
xlim([-90 90]);
title('Beampattern Using fft.m');
xlabel('Sample Number');
ylabel('Output Power (dB)');
tightfig;

%% Problem 3: Van Trees 2.4.6

%% Problem 4: Van Trees 2.7.1
