%% Problem 4: Van Trees 2.7.1
% Note in part (a) the aperture is continuous. In parts (b) and © plot the respective beampatterns (magnitude). 
%In part (c) the equivalent array shoulda also have triangular weighting. Plot the beampatterns out to include
%the 3rd sidelobe away from the mainlobe on each side in each part: 
%Consider a linear aperture with L = 5ƛ. Assume that the weighting function in triangular (peak in middle)
% Find an expression for the beam pattern and plot 

clear all;
close all;
clc

% Plotting the triangle beampattern
lambda = 1;     % amke it something so he's not lonely
L = 5*lambda;    % definition as given by the problem
u = [-1:0.01:1]; % want to be able to see enough
B_tri = (sinc(5*pi*u)).^2;
% B_tri = 10*log(abs(B_tri.^2));

figure(1)
plot(u,B_tri)
xlabel('u')
ylabel('Output Amplitude')
title('Beampattern of triangle')
%% How is the beam pattern in part (a) related to the beam pattern for uniform weighing:
B_uni = sinc(5*pi*u);

figure(2)
plot(u,B_tri)
hold on
plot(u,B_uni)
xlabel('u')
ylabel('Output Amplitude')
title('Beampattern of trianglular and uniform')
legend('Triangular','Uniform')

%%
% with seven elements
N=40;                        % Number of elements, i canchange
D2=[-(N-1)/2:1:(N-1)/2];   % Distance, column vector
D4=[-(N-1)/4:1:(N-1)/4];   % Distance, column vector
w2 = [ones(40,1)]/40;          % weight of 1/N (1/7), unifrom
w4 = [ones(20,1)]/20;          % weight of 1/N (1/7), unifrom

v2 = exp(1i*D2'*u);           % vector of vs e^j*D*psi
v4 = exp(1i*D4'*u);           % vector of vs e^j*D*psi


B_4 = w4'*v4;
B_2 = w2'*v2;


figure(1)
h1 =plot(u, 10*log10(abs(B_tri).^2),'-');
hold on
h2 =plot(u, 10*log10(abs(B_4).^2),'-');
hold on
h3 =plot(u, 10*log10(abs(B_2).^2),'-');
grid on
ylabel('Beampattern(dB)')
title('Triangular and Uniform Weighting')
xlabel('u')
legend([h1 h2 h3],'Triangular','d=\Lambda/4','d =\Lambda/2')

%%
figure(3)
h1 =plot(u, abs(B_tri),'-');
hold on
h2 =plot(u, abs(B_4),'-');
hold on
h3 =plot(u, abs(B_2),'-');
grid on
ylabel('Beampattern abs(B)')
title('Triangular and Uniform Weighting')
xlabel('u')
legend([h1 h2 h3],'Triangular','d=\Lambda/4','d =\Lambda/2')

%%

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
N = 20;
w = (1/N)*ones(N,1);
d = [-(N-1)/2:1:(N-1)/2];
v_u10 = exp(1i*d'*pi/2*u);

N2 = 10;
w2 = (1/N2)*ones(N2,1);
d20 = [-(N2-1)/2:1:(N2-1)/2];
v_u20 = exp(1i*d20'*pi*u);

BW_10u = w'*v_u10;
BW_20u = w2'*v_u20;

figure
plot(u,BW_10u)
grid
hold on
plot(u,BW_20u)
plot(u,BWw)
xlabel('u')
ylabel('BW')