%% Problem 4: Van Trees 2.7.1
% Note in part (a) the aperture is continuous. In parts (b) and © plot the respective beampatterns (magnitude). In part (c) the equivalent array shoulda also have triangular weighting. Plot the beampatterns out to include the 3rd sidelobe away from the mainlobe on each side in each part: Consider a linear aperture with L = 5ƛ. Assume that the weighting function in triangular (peak in middle)
% Find an expression for the beam pattern and plot 

clear all;
close all;
clc

% with seven elements
N=7;                        % Number of elements
D=[-(N-1)/2:1:(N-1)/2].';   % Distance, column vector
w = [ones(N,1)]/N;          % weight of 1/N (1/7), unifrom

psi = [-1:0.01:1]*pi;       % vector of psis from -pi to pi
v = exp(j*D*psi);           % ve cot of vs e^j*D*psi

B = w'*v;                   % weights times vector v

D4 = [-3 -2 1 3]';          % messing with distances, not equal in length
w4 = ones(4,1)/4;           % 
v4 = exp(j*D4*psi);

B4 = w4'*v4;

figure(1)
h1 =plot(psi/pi, 10*log10(abs(B4).^2),'-');
grid on
ylabel('Beampattern(dB)')
title('Nonuniform 4 Element Beampattern')
xlabel('psi/pi')

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

figure(2)
h1 =plot(psi/pi, 10*log10(abs(B4).^2),'-');
hold on
h2=plot(psi/pi, 10*log10(abs(B).^2),'-');

axis([-1 1 -40 0])
grid on
ylabel('Beampattern(dB)')
title('Comparison of 7 and 4 Elements')
legend([h1 h2],'4 Elements','7 Elements')
xlabel('psi/pi')

hold off



% How is the beam pattern in part (a) related to the beam pattern for uniform weighing
% Compare the result in part (a) to an equivalent linear array with d=/4 and d=/2