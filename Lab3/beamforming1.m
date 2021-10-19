%% Beamforming% 1. For each sensor,
% 1.1 create snapshots and go to the frequency domain (use the spectrogram function)
% 1.2 focus on the frequency of interest (i.e. select one line of the spectrogram)
% → obtain a matrix of complex numbers (in frequency domain) of size Nsnapshot * Nsensors
% (N.B : Nsnapshot << Ntime)
% 2. For many steering angles, for all snapshots, beamform
% → obtain a matrix of complex number of size Nsnapshot * Nangle
% 3. Plot the square modulus of the result


clear all
close all
clc

% STEP ONE: Load the data, depending on what we want
load('/home/kfung/Downloads/Array_Processing/Lab3/data/group1/63_to_75_broadside.mat');
whos
%% Obtain a matrix of real number of size Ntime*Nsensors
% this is matrix1 = tsmat;


%%% flag to plot spectrograms
plot_spectro=1;

% Set what we want and already know
f0=4000; %%% the frequency to beamform, EITHER 4k or 6k. Changing to a diff number works less 
c=1525; %%% water sound speed (NEEDS TO BE ADJUSTED???)

p_inches=[0 7.5 13 22 29.5 37 44.25 51.5];  % absolute value of the hydrophone locations
p_=p_inches/39.37;                          % convert from inchies to meters


%% Build frequency domain data before beamforming

Nchan=length(chs);  % number of channels
window=rectwin(Fs); %%% rectangular window of 1 sec, Fs is 10000
noverlap=0;         % no overlap of windows
nfft=length(window); 

% 1. For each sensor,
% 1.1 create snapshots and go to the frequency domain (use the spectrogram function)

for cc=1:Nchan
   x=tsmat(:,cc);    % set variable x to that column of tsmat
   [s, f, t]=spectrogram(x,window,noverlap,nfft,Fs);  % create spctrogram of x alled s
   
   % turn plot_spectro to 1 if want graphs
   if plot_spectro
   	subplot(4,2,cc)
   	imagesc(t,f,20*log10(abs(s)))
   	axis xy
    title(['Spectrogram of 4kHz Broadside: Channel' num2str(cc)])
   	xlabel('TIme (s)')
   	ylabel('Frequency (Hz)')
   end
   
   if cc==1     % if we're on channel 1
  	[~, ind_f0]=min(abs(f-f0)); % set ind_f0 to the min between f minus f0
   end
   % Add to the complex matrix
   % → obtain a matrix of complex numbers (in frequency domain) of size Nsnapshot * Nsensors
   % (N.B : Nsnapshot << Ntime)
   data_ok(:,cc)=s(ind_f0,:);   % add to column cc of data_ok (complex) of s from ind_f0 (index of f0)
end

%% 1.2 focus on the frequency of interest (i.e. select one line of the spectrogram)
% our frequency of interest is 4khz OR 6kHz (for later)





% 2. For many steering angles, for all snapshots, beamform
% → obtain a matrix of complex number of size Nsnapshot * Nangle


% 3. Plot the square modulus of the result

%% Beamforming
theta=0:0.2:180;        % these are the angles we wamt to look over
Ntheta=length(theta);   % number of thetas to iterate over

w_=rectwin(length(p_))/length(p_);  %length of the number of point of array/creates N point rectglr window
% w_=hamming(length(p_))/length(p_).'; % creates N point symmetric hamming window
% w_=blackman(length(p_))/length(p_).'; % creates N point blackman window
% of symmetric

if ~iscolumn(w_)
	w_=transpose(w_);
end

if ~iscolumn(p_)
	p_=transpose(p_);
end

% Methods 1 and 2: t is created by the spectrogram function (its time, duh)
y=zeros(length(t), Ntheta);     % one straight up equation for y, in THETA SPACE
y2=zeros(length(t), Ntheta);    % multiple equtaions make up this one: function of PHI

for tt=1:length(t)
	s=transpose(data_ok(tt,:)); %%% this is a column vector
    
	for aa=1:Ntheta
   	y(tt,aa)=sum(w_.*exp(-1i*cosd(theta(aa))*p_*2*pi*f0/c).*s); % the equation
  	 
   	%%% do as in book. Make sure to use column vectors
   	kz=-2*pi*f0/c*cosd(theta(aa));   %%% Eq 2.24 and 2.15  p.29-30
   	v_T=exp(-1i*kz*p_);   %%% Eq 2.28   p.30
   	w_T=w_.*v_T; %%% cf lecture: steering is phase shifting
   	y2(tt,aa)=w_T'*s;
	end
end

% For angle
%  	Steer array weitg
% 	For snapshot
% 		beamform

figure,
plot(theta,abs(y(1,:)))
hold on
plot(theta, abs(y2(1,:)),'d')
grid on
xlim([theta(1) theta(end)])

