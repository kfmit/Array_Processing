% matlab script to combine data files into single output per channel
% Erin Fischell (efischell@whoi.edu)
% Woods Hole Oceanographic Institution
clc
close all
clear all



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
directory= '/home/kfung/Downloads/Array_Processing/Lab3/data/group1/'; % adjust to point to the correct directory
NSample=100000; % adjust based on number of lines in file, 100000 is good

Fs=10000; %4000 for indoor daq, 10000 for outside acbox collection
chs=1:8; % leave this alone

files=dir([directory '*.txt']);
length(files)
% the number of the first file you want to process (e.g. 1)
%startnum=6800;
% the number of the last file you want to process (e.g. 1000)
%endnum=7800;
startnum=46;
endnum=56;
if endnum>length(files)
    endnum=length(files);
end
    
if endnum<startnum
    endnum=startnum;
end
if startnum < 1
    startnum=1;
end
numfiles=length(startnum:endnum);

counter=0
startind=1;
endind=NSample;
for ii=startnum:endnum
    filename=[directory files(ii).name]
    if exist(filename, 'file') == 2
        
        filename;
        tsmat = load(filename);
        if length(tsmat)== NSample
            alldata(startind:endind,:)=tsmat;

            startind=startind+NSample;
            endind=startind+NSample-1;
           % specgram(tsmat(:,5),200,50000);
           % pause(1)
            %pause
        end
        
        
        % pause
    end
    
end

%Save to .mat
save([directory 'alldata' num2str(startnum) '_to_' num2str(endnum) '_use.mat'],'-v7.3')

%%
for ii=1:8
    %plot all data from each channel
    figure(ii)
    specgram(alldata(:,ii),200,Fs);
    
    title(['Channel = ' num2str(ii)])   
    if i<8
    figure(9)
    hold on
    plot(alldata(:,ii)+ii/10)
    title('All channels')
    xlabel('Time (s)')
    ylabel('Signal for Channel')
  
    
    end
    
end
