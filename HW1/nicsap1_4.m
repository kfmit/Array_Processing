clear all
close all

u= [-1:0.001:1]; 
% L = 5*lambda;
% u*L/lambda
% triangular = (arg/2.*sin(arg)-2*cos(arg)+2)/(2*arg.^2);
uniform  = sinc(5*pi*u);
triang = (-10*pi*u.*sin(-5*pi*u)-2*cos(-5*pi*u)+2)./(8*pi*u.^2);

N=21;
D=[-(N-1)/2:1:(N-1)/2].'; %uniform array spacing
D= D/2;
w = [ones(N,1)]/N;
for ii=0:N-1
    
    w(ii+1) = 1-(2*abs(ii-(N-1)/2))/N;
end
c = sum(w)^(-1);
w = w*c;

psi = [-1:0.01:1]*pi;
v = exp(j*D*psi);
B = w'*v;

N2=11;
D2=[-(N2-1)/2:1:(N2-1)/2].';
D2= D2/2; %uniform array spacing
w2 = [ones(N2,1)]/N2;
for ii=0:N2-1
    
    w2(ii+1) = 1-(2*abs(ii-(N2-1)/2))/N2;
end
c2 = sum(w2)^(-1);
w2 = w2*c2;

psi = [-1:0.01:1]*pi;
v2 = exp(j*D2*psi);
B2 = w2'*v2;


h1 = plot(u,uniform);
hold on
h2 = plot(u,(triang)/max(abs(triang)));
h3 = plot(psi/pi, (B),'g');
h4 = plot(psi/pi, (B2),'m');
xlim([-1 1])
grid on
hold off
title('Prob 1.4 (Book 2.7.1)')
ylabel('Beam pattern')
xlabel('{\itu}')
legend([h1 h2 h3 h4],'Uniform','Triangular', 'N=21 Tri', 'N=11 Tri')