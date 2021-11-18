%% Kathryn Fung
%% Lab 4 Code

% Analysis of 3D array gain
load alldata249_to_368_use.mat
% load alldata417_to_532_use.mat
% load alldata566_to_674_use.mat
% load alldata712_to_848_use.mat
% load alldata894_to_1012_use.mat
% load alldata1150_to_1250_use.mat
% load alldata1358_to_1522_use.mat
% load alldata1554_to_1664_use.mat
% load alldata1688_to_1800_use.mat
% load alldata1838_to_1950_use.mat
% load alldata1994_to_2104_use.mat
% load alldata2152_to_2328_use.mat
% load alldata2628_to_2752_use.mat
% load alldata2770_to_2886_use.mat
% load alldata2918_to_3038_use.mat
% load alldata3078_to_3188_use.mat
% load alldata3240_to_3350_use.mat
% load alldata3392_to_3506_use.mat

%%% flag to plot spectrograms
plot_spectro=0;


f0=9000; %%% the frequency to beamform
c=1522; %%% water sound speed

% p_inches=[0 7.5 13 22 29.5 37 44.25 51.5]; %normal array
% %p_inches=[0 15 18.5 22 33.25 37 40 51.5]; %random array
% p_=p_inches/39.37;

array_dim = [ ; ; ; ; ; ;];

p_ = % array dimension in x dir 
p_ = % array dimension in y dir
p_ = % array dimension in z dir

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
    w_=rectwin(length(p_))/length(p_);
end
if ww == 2 
    w_=hamming(length(p_))/length(p_).';
end
if ww == 3
    w_=blackman(length(p_))/length(p_).';
end
if ww == 4
    %Kaiser Weighting
    N = length(p_);
    Zl = (N-1)/2;
    beta1 = 3;
    
    for n = -(N-1)/2:(N-1)/2
       xx = 1-(2*n/N)^2;
       wn1(n+1+(N-1)/2,1) = besseli(0,beta1*sqrt(xx));
    end
    w_=wn1/sum(wn1);
    
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