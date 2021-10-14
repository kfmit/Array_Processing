close all
clear all
clc

directory= '/home/kfung/Downloads/Array_Processing/Lab3/data/*/'; % adjust to point to the correct directory
%%%% create



files=dir([directory '*.txt']);
Nf=length(files);


for ff=1:Nf

    folder_ff=files(ff).folder;
    name_ff=files(ff).name;

    if str2num(name_ff(end-9)) == 5
        movefile([folder_ff, filesep, name_ff],  ['/home/kfung/Downloads/Array_Processing/Lab3/data/group1', filesep, name_ff]);
    elseif str2num(name_ff(end-9)) == 0
        movefile([folder_ff, filesep, name_ff],  ['/home/kfung/Downloads/Array_Processing/Lab3/data/group2', filesep, name_ff]);
    end
    
end


%% Original Code
% for ff=1:Nf
% 
%     folder_ff=files(ff).folder;
%     name_ff=files(ff).name;
% 
%     if str2num(name_ff(end-9)) == 5
%         movefile([folder_ff, filesep, name_ff],  [folder_ff, filesep,'group1', filesep, name_ff]);
%     elseif str2num(name_ff(end-9)) == 0
%         movefile([folder_ff, filesep, name_ff],  [folder_ff, filesep,'group2', filesep, name_ff]);
%     end
%     
% end