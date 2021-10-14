close all
clear all
% Demonstrate beampattern changes

theta_s=-pi:pi/100:pi;%look angles
f0=100;% frequency (Hz)
omega0=f0*2*pi;
c=1500;
lambda=c/f0;

%Initial: set d to lambda/2
d=lambda/2;
N=5;

%incident angle of signal
theta_i0=pi/2;
psi_i0=d*omega0/c*cos(theta_i0);
theta_i1=pi/6;
psi_i1=d*omega0/c*cos(theta_i1);
theta_i2=pi;
psi_i2=d*omega0/c*cos(theta_i2);


%get psis:
psi_s=d*omega0/c*cos(theta_s);

%first plot: for each theta_i, plot beampattern

B0=1/N*sin(N*(psi_s-psi_i0)/2)./sin((psi_s-psi_i0)/2)
B1=1/N*sin(N*(psi_s-psi_i1)/2)./sin((psi_s-psi_i1)/2)
B2=1/N*sin(N*(psi_s-psi_i2)/2)./sin((psi_s-psi_i2)/2)


%plot versus theta:
figure(1)
subplot(4,3,1)
plot([0,0,0,0,0],[-d*2,-d,0,d,2*d],'bo');
axis([-1,1,-25,25])
%title(['\omega = ' num2str(omega0) 'rad/s, d=' num2str(d) 'm']) 
xlabel('x (m)')
ylabel('z (m)')

subplot(4,3,2)
plot(theta_s,B0,'r-',theta_s,B1,'b.',theta_s,B2,'g-.')
hold on
plot([theta_i0,theta_i0],[-.25,1],'r-',[theta_i1,theta_i1],[-.25,1],'b-',[theta_i2,theta_i2],[-.25,1],'g-')
axis([0,pi,-0.25,1])
title(['B(\theta_s) for N=' num2str(N) ', d=\lambda/2'])
xlabel('\theta_s')
ylabel('B(\theta_s)')



subplot(4,3,3)
plot(psi_s,B0,'r-',psi_s,B1,'b.',psi_s,B2,'g-.')
hold on
plot([psi_i0,psi_i0],[-.25,1],'r-',[psi_i1,psi_i1],[-.25,1],'b-',[psi_i2,psi_i2],[-.25,1],'g-')
hold on
axis([-pi,pi,-0.25,1])
title(['B(\psi_s) for N=' num2str(N) ', d=\lambda/2'])
xlabel('\psi_s')
ylabel('B(\psi_s)')

%
%Let N=7: same d, up N
N=7
subplot(4,3,4)
plot([0,0,0,0,0,0,0],[-d*3,-d*2,-d,0,d,2*d,3*d],'bo');
axis([-1,1,-25,25])

% steered in three directions:
B0=1/N*sin(N*(psi_s-psi_i0)/2)./sin((psi_s-psi_i0)/2)
B1=1/N*sin(N*(psi_s-psi_i1)/2)./sin((psi_s-psi_i1)/2)
B2=1/N*sin(N*(psi_s-psi_i2)/2)./sin((psi_s-psi_i2)/2)

subplot(4,3,5)
plot(theta_s,B0,'r-',theta_s,B1,'b.',theta_s,B2,'g-.')
hold on
plot([theta_i0,theta_i0],[-.25,1],'r-',[theta_i1,theta_i1],[-.25,1],'b-',[theta_i2,theta_i2],[-.25,1],'g-')
title(['B(\theta_s) for N=' num2str(N) ', d=\lambda/2'])
xlabel('\theta_s')
ylabel('B(\theta_s)')
axis([0,pi,-0.25,1])
subplot(4,3,6)
plot(psi_s,B0,'r-',psi_s,B1,'b.',psi_s,B2,'g-.')
hold on
plot([psi_i0,psi_i0],[-.25,1],'r-',[psi_i1,psi_i1],[-.25,1],'b-',[psi_i2,psi_i2],[-.25,1],'g-')
hold on
axis([-pi,pi,-0.25,1])
title(['B(\psi_s) for N=' num2str(N) ', d=\lambda/2'])
xlabel('\psi_s')
ylabel('B(\psi_s)')


disp('what happens when we decrease N?')
N=3
subplot(4,3,7)
plot([0,0,0],[-d,0,d],'bo');
axis([-1,1,-25,25])
B0=1/N*sin(N*(psi_s-psi_i0)/2)./sin((psi_s-psi_i0)/2)
B1=1/N*sin(N*(psi_s-psi_i1)/2)./sin((psi_s-psi_i1)/2)
B2=1/N*sin(N*(psi_s-psi_i2)/2)./sin((psi_s-psi_i2)/2)

subplot(4,3,8)
plot(theta_s,B0,'r-',theta_s,B1,'b.',theta_s,B2,'g-.')
hold on
plot([theta_i0,theta_i0],[-.25,1],'r-',[theta_i1,theta_i1],[-.25,1],'b-',[theta_i2,theta_i2],[-.25,1],'g-')
axis([0,pi,-0.25,1])
title(['B(\theta_s) for N=' num2str(N) ', d=\lambda/2'])
xlabel('\theta_s')
ylabel('B(\theta_s)')
subplot(4,3,9)
plot(psi_s,B0,'r-',psi_s,B1,'b.',psi_s,B2,'g-.')
hold on
plot([psi_i0,psi_i0],[-.25,1],'r-',[psi_i1,psi_i1],[-.25,1],'b-',[psi_i2,psi_i2],[-.25,1],'g-')
hold on
axis([-pi,pi,-0.25,1])
title(['B(\psi_s) for N=' num2str(N) ', d=\lambda/2'])
xlabel('\psi_s')
ylabel('B(\psi_s)')


subplot(4,3,10)


N=7

d=lambda/2.5
plot([0,0,0,0,0,0,0],[-d*3,-d*2,-d,0,d,2*d,3*d],'bo');
axis([-1,1,-25,25])
%incident angle of signal
theta_i0=pi/2;
psi_s=d*omega0/c*cos(theta_s);
psi_i0=d*omega0/c*cos(theta_i0);
theta_i1=pi/6;
psi_i1=d*omega0/c*cos(theta_i1);
theta_i2=pi;
psi_i2=d*omega0/c*cos(theta_i2);


%second plot: for each theta_i, plot beampattern

B0=1/N*sin(N*(psi_s-psi_i0)/2)./sin((psi_s-psi_i0)/2)
B1=1/N*sin(N*(psi_s-psi_i1)/2)./sin((psi_s-psi_i1)/2)
B2=1/N*sin(N*(psi_s-psi_i2)/2)./sin((psi_s-psi_i2)/2)

subplot(4,3,11)
plot(theta_s,B0,'r-',theta_s,B1,'b.',theta_s,B2,'g-.')
hold on
plot([theta_i0,theta_i0],[-.25,1],'r-',[theta_i1,theta_i1],[-.25,1],'b-',[theta_i2,theta_i2],[-.25,1],'g-')
axis([0,pi,-0.25,1])
title(['B(\theta_s) for d=\lambda/2.5, N=7'])
xlabel('\theta_s')
ylabel('B(\theta_s)')
subplot(4,3,12)
plot(psi_s,B0,'r-',psi_s,B1,'b.',psi_s,B2,'g-.')
hold on
plot([psi_i0,psi_i0],[-.25,1],'r-',[psi_i1,psi_i1],[-.25,1],'b-',[psi_i2,psi_i2],[-.25,1],'g-')
axis([-pi,pi,-0.25,1])
title(['B(\psi_s) for d=\lambda/2.5, N=7'])
xlabel('\psi_s')
ylabel('B(\psi_s)')