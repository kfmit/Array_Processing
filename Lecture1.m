close all
clear all
% Plot time series with frequency component f0:
Fs=1000;
t=0:1/Fs:10;

f0=100;
x0=sin(f0*2*pi*t);

%add some noise:
x1=x0+2*(randn(size(x0)));
figure(1)
plot(t,x1)
xlabel('time (s)')
ylabel('Votlage (V)')

title('Example time-series signal X(t)')
pause

disp('What is the frequency of the underlying signal?')
%What is the frequency components?
% calculate fft:
L=length(x1);
X1=fft(x1);
P2 = abs(X1/L);
P1 = P2(1:floor(L/2+1));
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure(2)
plot(f,P1)
title('Single-Sided Amplitude Spectrum of X(t), snr=-10m NFFT=10000')
xlabel('f (Hz)')
ylabel('|P1(f)|')

disp('This show the frequency of the signal!  What if we use less data?')
pause
% Less data:
L=1024;
X1=fft(x1,L);
P2 = abs(X1/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure(3)
plot(f,P1)
title('Single-Sided Amplitude Spectrum of X(t), NFFT=1024')
xlabel('f (Hz)')
ylabel('|P1(f)|')

disp('What about if the data is noisier?')
x2=x0+20*(randn(size(x0)));
figure(1)
plot(t,x1)
xlabel('time (s)')
ylabel('Votlage (V)')

title('Example time-series signal X(t): snr=-30')
L=length(x2);
X1=fft(x2);
P2 = abs(X1/L);
P1 = P2(1:floor(L/2+1));
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure(4)
plot(f,P1)
title('Single-Sided Amplitude Spectrum of X(t), snr=-30')
xlabel('f (Hz)')
ylabel('|P1(f)|')
