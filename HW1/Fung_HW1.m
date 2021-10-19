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
lambda= 2; % arbitrary wavelength for fun
D = lambda/2; % Element spacing (m)
phi_s = 90;    % steering angle
theta_0 = 90; % broadside, coming in

% Here's what our array looks like
% ula = phased.ULA('NumElements',N,'ElementSpacing',D,'ArrayAxis','z');   % just for visual
% figure(1)
% viewArray(ula,'Title','Uniform Linear Array (ULA)')

fc = 1e9;   % i can make this whatever i want
% uniform weighting
w = [ 1/7 1/7 1/7 1/7 1/7 1/7 1/7]; % all on
% w = [ 0 1/7 1/7 1/7 1/7 1/7 1/7]; % first out
% w = [ 1/7 1/7 0 1/7 1/7 1/7 1/7]; % third out
% w = [ 1/7 1/7 0 0 1/7 0 1/7]; % 3/4/6 out
% w = [ 1/7 0 1/7 0 1/7 0 1/7]; % 2/4/6 out

%c = 1525;   % water soundspeed, why not
% resp = ula(fc,ang)    % some built in function
% for weighting, all uniform
% to turn off an element, change weight to 0

N=7;                        % Number of elements
D=[-(N-1)/2:1:(N-1)/2].';   % Distance, column vector
%w = [ones(N,1)]/N;          % weight of 1/N (1/7), unifrom

theta = [0:0.01:pi];        % vecotr of thetas from 0 to pi
psi = [-1:0.01:1]*pi;       % vector of psis from -pi to pi

v_psi = exp(1i*D*psi);           % vector of vs e^j*D*psi
% CHECK ON THIS
v_theta = exp(1i*D*cos(theta));           % vector of vs e^j*D*theta DO I NEED COS OR NOT

B_psi = w*v_psi;                   % weights times vector v
B_theta = w*v_theta;
B_theta = 10*log10(abs(B_theta).^2);
B_psi = 10*log10(abs(B_psi).^2);

%%
figure(2);
% This plots the instantaneous power for every element (N waveforms).
subplot(2,1,1)
plot(theta,normalize(B_theta,'range'));
 ylim([0 1.5]);
%xlim([0 pi]);
grid on;
title('Beampattern in \Theta');
xlabel('Theta');
ylabel('Output Power (dB)');
%
% hold on;
subplot(2,1,2)
plot(psi,normalize(B_psi,'range'),'r');
grid on;
ylim([0 1.5]);
%xlim([-90 90]);
title('Beampattern in \Psi');
xlabel('Psi');
ylabel('Output Power (dB)');
%tightfig;








