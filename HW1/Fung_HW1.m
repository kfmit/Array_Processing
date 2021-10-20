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
%D = lambda/2; % Element spacing (m)
phi_s = 90;    % steering angle
theta_0 = 90; % broadside, coming in

% Here's what our array looks like
% ula = phased.ULA('NumElements',N,'ElementSpacing',D,'ArrayAxis','z');   % just for visual
% figure(1)
% viewArray(ula,'Title','Uniform Linear Array (ULA)')

fc = 1e9;   % i can make this whatever i want
% uniform weighting
w1 = [ 1/7 1/7 1/7 1/7 1/7 1/7 1/7]; % all on
w2 = [ 0 1/7 1/7 1/7 1/7 1/7 1/7]; % first out
w3 = [ 1/7 1/7 0 1/7 1/7 1/7 1/7]; % third out
w4 = [ 1/7 1/7 0 0 1/7 0 1/7]; % 3/4/6 out
w5 = [ 1/7 0 1/7 0 1/7 0 1/7]; % 2/4/6 out

%c = 1525;   % water soundspeed, why not
% resp = ula(fc,ang)    % some built in function
% for weighting, all uniform
% to turn off an element, change weight to 0

N=7;                        % Number of elements
D=[-(N-1)/2:1:(N-1)/2].';   % Distance, column vector
%w = [ones(N,1)]/N;          % weight of 1/N (1/7), unifrom
n = [1:1:N];

theta = [0:0.01:pi];        % vecotr of thetas from 0 to pi
psi = [-1:0.01:1]*pi;       % vector of psis from -pi to pi

v_psi = exp(1i*D*psi);           % vector of vs e^j*D*psi
% CHECK ON THIS
v_theta = exp(1i*D*cos(theta));           % vector of vs e^j*D*theta DO I NEED COS OR NOT

B1_psi = w1*v_psi;                   % weights times vector v
B1_theta = w1*v_theta;
B2_psi = w2*v_psi;                   % weights times vector v
B2_theta = w2*v_theta;
B3_psi = w3*v_psi;                   % weights times vector v
B3_theta = w3*v_theta;
B4_psi = w4*v_psi;                   % weights times vector v
B4_theta = w4*v_theta;
B5_psi = w5*v_psi;                   % weights times vector v
B5_theta = w5*v_theta;

% B_theta = 10*log10(abs(B_theta).^2); % turn to power
% B_psi = 10*log10(abs(B_psi).^2);
%Normalize
B1n_psi = max(abs(B1_psi))./abs(B1_psi);
B2n_psi = max(abs(B2_psi))./abs(B2_psi);
B3n_psi = max(abs(B3_psi))./abs(B3_psi);
B4n_psi = max(abs(B4_psi))./abs(B4_psi);
B5n_psi = max(abs(B5_psi))./abs(B5_psi);

B1n_theta = max(abs(B1_theta))./abs(B1_theta);
B2n_theta = max(abs(B2_theta))./abs(B2_theta);
B3n_theta = max(abs(B3_theta))./abs(B3_theta);
B4n_theta = max(abs(B4_theta))./abs(B4_theta);
B5n_theta = max(abs(B5_theta))./abs(B5_theta);
%%
figure(2);
% This plots the instantaneous power for every element (N waveforms).
subplot(2,1,1)
% plot(theta,normalize(B_theta,'range'));
plot(theta,10*log10(abs(B1_theta).^2));
%  ylim([0 1.5]);
%xlim([0 pi]);
grid on;
title('Normalized Beampattern in \Theta');
xlabel('Theta');
ylabel('Output Power (dB)');
%
% hold on;
 subplot(2,1,2)
% plot(psi,normalize(B_psi,'range'),'r');
plot(psi,10*log10(abs(B1_psi).^2));
grid on;
%ylim([0 1.5]);
%xlim([-90 90]);
title('Normalized Beampattern in \Psi');
xlabel('Psi');
ylabel('Output Power (dB)');
%tightfig;


%% Making one figure to rule them all

figure(3)
subplot(2,1,1)
% plot(theta,normalize(B_theta,'range'));
hold on
plot(theta,10*log10(abs(B1_theta).^2));
plot(theta,10*log10(abs(B2_theta).^2));
plot(theta,10*log10(abs(B3_theta).^2));
plot(theta,10*log10(abs(B4_theta).^2));
plot(theta,10*log10(abs(B5_theta).^2));
hold off
%ylim([0 1.5]);
%xlim([0 pi]);
grid on;
title('Beampattern in \Theta');
xlabel('Theta');
ylabel('Output Power (dB)');
legend('All on','1 out','3 out','3/4/6 out','2/4/6 out')
%
% hold on;
subplot(2,1,2)
% plot(psi,normalize(B_psi,'range'),'r');
hold on
plot(psi,10*log10(abs(B1_psi).^2));
plot(psi,10*log10(abs(B2_psi).^2));
plot(psi,10*log10(abs(B3_psi).^2));
plot(psi,10*log10(abs(B4_psi).^2));
plot(psi,10*log10(abs(B5_psi).^2));
hold off
grid on;
%ylim([0 1.5]);
%xlim([-90 90]);
title('Beampattern in \Psi');
xlabel('Psi');
ylabel('Output Power (dB)');
legend('All on','1 out','3 out','3/4/6 out','2/4/6 out')

%%
figure(4)
subplot(2,1,1)
% plot(theta,normalize(B_theta,'range'));
hold on
plot(theta,abs(B1_theta));
plot(theta,abs(B2_theta));
plot(theta,abs(B3_theta));
plot(theta,abs(B4_theta));
plot(theta,abs(B5_theta));
hold off
%ylim([0 1.5]);
%xlim([0 pi]);
grid on;
title('Normalized Beampattern in \Theta');
xlabel('Theta');
ylabel('Output Amplitude Normalized');
legend('All on','1 out','3 out','3/4/6 out','2/4/6 out')
%
% hold on;
subplot(2,1,2)
% plot(psi,normalize(B_psi,'range'),'r');
hold on
plot(psi,abs(B1_psi));
plot(psi,abs(B2_psi));
plot(psi,abs(B3_psi));
plot(psi,abs(B4_psi));
plot(psi,abs(B5_psi));
hold off
grid on;
%ylim([0 1.5]);
%xlim([-90 90]);
title('Normalized Beampattern in \Psi');
xlabel('Psi');
ylabel('Output Amplitude Normalized');
legend('All on','1 out','3 out','3/4/6 out','2/4/6 out')

%%
figure(5)
subplot(2,1,1)
% plot(theta,normalize(B_theta,'range'));
hold on
plot(theta,B1_theta);
plot(theta,B2_theta);
plot(theta,B3_theta);
plot(theta,B4_theta);
plot(theta,B5_theta);
hold off
%ylim([0 1.5]);
%xlim([0 pi]);
grid on;
title('Raw Beampattern in \Theta');
xlabel('Theta');
ylabel('Output Amplitude Raw');
legend('All on','1 out','3 out','3/4/6 out','2/4/6 out')
%
% hold on;
subplot(2,1,2)
% plot(psi,normalize(B_psi,'range'),'r');
hold on
plot(psi,B1_psi);
plot(psi,B2_psi);
plot(psi,B3_psi);
plot(psi,B4_psi);
plot(psi,B5_psi);
hold off
grid on;
%ylim([0 1.5]);
%xlim([-90 90]);
title('Raw Beampattern in \Psi');
xlabel('Psi');
ylabel('Output Amplitude Raw');
legend('All on','1 out','3 out','3/4/6 out','2/4/6 out')


