%% Problem 3: Van Trees 2.4.6
% assume free space and sound speed is constant value c: Consider the non uniform 4 element linear array
% whose sensor separations are d, 3d, 2d, where d=lambda/2. The sensor outputs are weighted uniformly 
% (ie w_=rectwin(length(p_))/length(p_); p is [d 3d 2d])

%% Compute the beampattern and BWnn
clear all;
close all;
clc

% with seven elements
N=7;                        % Number of elements
D=[-(N-1)/2:1:(N-1)/2].';   % Distance, column vector
w = [ones(N,1)]/N;          % weight of 1/N (1/7), unifrom

psi = [-1:0.01:1]*pi;       % vector of psis from -pi to pi
v = exp(j*D*psi);           % vector of vs e^j*D*psi

B = w'*v;                   % weights times vector v

D4 = [-3 -2 1 3]';          % messing with distances, not equal in length
w4 = ones(4,1)/4;           % even weighting over four elements
v4 = exp(j*D4*psi);         % equation for array manifold vector

B4 = w4'*v4;

figure(1)
h1 =plot(psi, 10*log10(abs(B4).^2),'-');
grid on
ylabel('Beampattern(dB)')
title('Nonuniform 4 Element Beampattern')
xlabel('psi')

%% Compare the results in (a) with a uniform 7 element array where d=/2. Discuss the behavior of the 
% main lobe and sidelobes

%% Compare

figure(2)
h1 =plot(psi, 10*log10(abs(B4).^2),'-');
hold on
h2=plot(psi, 10*log10(abs(B).^2),'-');

%axis([-1 1 -40 0])
grid on
ylabel('Beampattern(dB)')
title('Comparison of 7 and 4 Elements')
legend([h1 h2],'4 Elements','7 Elements')
xlabel('psi')

%% Finding Beamwidth nullnull
u = [0.2:0.0001:0.3];   % u=cos(theta)
vv = exp(j*D4*pi*u);
B = w4'*vv;
[y,I]=min(abs(B));
umin = u(I)
BWmm_u = 2*umin
psimin = pi*umin
BWmm_psi = 2*psimin
Bmin = y





