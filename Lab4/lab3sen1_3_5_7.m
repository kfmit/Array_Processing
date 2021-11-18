close all
clear all
clc

load data/dock_data/group1/alldata26_to_38_use.mat %%% endfire
%load data/dock_data/group1/alldata46_to_56_use.mat  %%% 45 degree
%load data/dock_data/group1/alldata63_to_75_use.mat  %%% broadside

% Random Array Files
%load data/dock_data/group1/alldata277_to_279_use.mat %%% time:1523-1525 endfire
%load data/dock_data/group1/alldata261_to_272_use.mat  %%% time: 1520-1522 45 degree
%load data/dock_data/group1/alldata249_to_254_use.mat  %%% time: 1517-1519: broadside

%%% flag to plot spectrograms
plot_spectro=0;


f0=4000; %%% the frequency to beamform
c=1522; %%% water sound speed

p_inches=[0 7.5 13 22 29.5 37 44.25 51.5]; %normal array
%p_inches=[0 15 18.5 22 33.25 37 40 51.5]; %random array
p_=p_inches/39.37;


%% Build frequency domain data before beamforming
Nchan=length(chs);
window=rectwin(Fs); %%% rectangular window of 1 sec
noverlap=0;
nfft=length(window);
for cc=1:Nchan
   x=alldata(:,cc);
   [s, f, t]=spectrogram(x,window,noverlap,nfft, Fs);  
   if plot_spectro
   	figure
   	imagesc(t,f,20*log10(abs(s)))
   	axis xy
   	xlabel('TIme (s)')
   	ylabel('Frequency (Hz)')
   end
   if cc==1
  	[~, ind_f0]=min(abs(f-f0));
   end
   data_ok(:,cc)=s(ind_f0,:);
end


%% Beamform
theta=0:0.2:180;
Ntheta=length(theta);
for ww=1:4
if ww == 1
    w_=rectwin(length(p_))/(length(p_))*2;
    w_(2)=0;
    w_(4)=0;
    w_(6)=0;
    w_(8)=0;
end
if ww == 2 
    wham=hamming(length(p_)-4)/(length(p_)-4).';
    w_(1) =wham(1);
    w_(3) =wham(2);
    w_(5) =wham(3);
    w_(7) =wham(4);
    w_(2)=0;
    w_(4)=0;
    w_(6)=0;
    w_(8)=0;
end
if ww == 3
    wblack=blackman(length(p_)-4)/(length(p_)-4).';
    w_(1) =wblack(1);
    w_(3) =wblack(2);
    w_(5) =wblack(3);
    w_(7) =wblack(4);
    w_(2)=0;
    w_(4)=0;
    w_(6)=0;
    w_(8)=0;
end
if ww == 4
    %Kaiser Weighting
    N = length(p_)-4;
    Zl = (N-1)/2;
    beta1 = 3;
    
    for n = -(N-1)/2:(N-1)/2
       xx = 1-(2*n/N)^2;
       wn1(n+1+(N-1)/2,1) = besseli(0,beta1*sqrt(xx));
    end
    wkai=wn1/sum(wn1);
    w_(1) =wkai(1);
    w_(3) =wkai(2);
    w_(5) =wkai(3);
    w_(7) =wkai(4);
    w_(2)=0;
    w_(4)=0;
    w_(6)=0;
    w_(8)=0;
    
end
    
if ~iscolumn(w_)
	w_=transpose(w_);
end

if ~iscolumn(p_)
	p_=transpose(p_);
end


y=zeros(length(t), Ntheta);
y2=zeros(length(t), Ntheta);

for tt=1:length(t)
	s=transpose(data_ok(tt,:)); %%% this is a column vector
	for aa=1:Ntheta
   	y(tt,aa)=sum(w_.*exp(-1i*cosd(theta(aa))*p_*2*pi*f0/c).*s);
  	 
   	%%% do as in book. Make sure to use column vectors
   	kz=-2*pi*f0/c*cosd(theta(aa));   %%% Eq 2.24 and 2.15  p.29-30
   	v_T=exp(-1i*kz*p_);   %%% Eq 2.28   p.30
   	w_T=w_.*v_T; %%% cf lecture: steering is phase shifting
   	y2(tt,aa)=w_T'*s;
    end
    
end
if ww == 1 
    y_uni = y;
    y2_uni = y2;
end
if ww == 2
    y_ham = y;
    y2_ham = y2;
end
if ww == 3
    y_black = y;
    y2_black = y2;
end
if ww == 4
    y_kai = y;
    y2_kai = y2;
end
end


figure
out_uni = plot(theta,abs(y_uni(1,:))/max(abs(y_uni(1,:))))
hold on
out_ham = plot(theta,abs(y_ham(1,:))/max(abs(y_ham(1,:))))
hold on
out_black = plot(theta,abs(y_black(1,:))/max(abs(y_black(1,:))))
hold on
out_kai = plot(theta,abs(y_kai(1,:))/max(abs(y_kai(1,:))))
grid on
xlim([theta(1) theta(end)])
ylabel('Output (Normalized)')
xlabel('\theta')
legend([out_uni out_ham out_black out_kai],'Uniform','Hamming', 'Blackman', 'Kaiser \beta =3')
title('Output (Normalized) - Endfire Uniform Spacing')


figure
out_uni = plot(theta,abs(y2_uni(1,:))/max(abs(y2_uni(1,:))))
hold on
out_ham = plot(theta,abs(y2_ham(1,:))/max(abs(y2_ham(1,:))))
hold on
out_black = plot(theta,abs(y2_black(1,:))/max(abs(y2_black(1,:))))
hold on
out_kai = plot(theta,abs(y2_kai(1,:))/max(abs(y2_kai(1,:))))
grid on
xlim([theta(1) theta(end)])
ylabel('Output (Normalized)')
xlabel('\theta')
legend([out_uni out_ham out_black out_kai],'Uniform','Hamming', 'Blackman', 'Kaiser \beta =3')
title('Output (Normalized) - Endfire Uniform Spacing')



figure
out_uni = plot(theta, mean(abs(y_uni),1)/max(mean(abs(y_uni),1)))
hold on
out_ham = plot(theta, mean(abs(y_ham),1)/max(mean(abs(y_ham),1)))
hold on
out_black = plot(theta, mean(abs(y_black),1)/max(mean(abs(y_black),1)))
hold on
out_kai = plot(theta, mean(abs(y_kai),1)/max(mean(abs(y_kai),1)))
grid on
xlim([theta(1) theta(end)])
ylabel('Averaged Output')
xlabel('\theta')
legend([out_uni out_ham out_black out_kai],'Uniform','Hamming', 'Blackman', 'Kaiser \beta =3')
title('Averaged Output (Normalized) - Endfire Uniform Spacing')


figure
subplot(2, 2, 1);
imagesc(theta,t,abs(y_uni))
xlabel('Angle (degree)')
ylabel('Time (s)')
title('BRG vs Time (Uniform)');
subplot(2, 2, 2);
imagesc(theta,t,abs(y_ham))
xlabel('Angle (degree)')
ylabel('Time (s)')
title('BRG vs Time (Hamming)');
subplot(2, 2, 3);
imagesc(theta,t,abs(y_black))
xlabel('Angle (degree)')
ylabel('Time (s)')
title('BRG vs Time (Blackman)');
subplot(2, 2, 4);
imagesc(theta,t,abs(y_kai))
xlabel('Angle (degree)')
ylabel('Time (s)')
title('BRG vs Time (Kaiser \beta =3)');