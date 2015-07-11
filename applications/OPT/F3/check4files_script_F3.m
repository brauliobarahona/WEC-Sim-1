% Script to check that all files are there, to be loaded
%
clc; clear all;
% Run names - files containing each a set of simulation file names
run_name = {'Rv0_1filenames';'Rv0_2filenames';'Rv0_3filenames';'Rv0_4filenames';
            'Rv0_5filenames';'Rv0_6filenames';'Rv0_7filenames';'Rv0_8filenames';
            'Rv0_9filenames';'Rv0_10filenames';'Rv0_11filenames';'Rv0_12filenames'};

flgFIX = 1;   % set this flag to 1 to dicard names of files that where not found

for i = 1:length(run_name)
    load(run_name{i})
  
    for j = 1:length(fn)

        %check if simulation output file are there
        Eflg(j) = exist(['E:\wecSim\resV0_Float3\res\' fn{j}, '.mat'], 'file');
        
    end
    
    iF = find(Eflg == 2);   % index for files found    
    inotF = find(Eflg == 0);   % index for files not found
    
    if isempty(inotF) == 0;
        
        for kk = 1 : length(inotF)
            fnNotfound{kk} = fn{ inotF(kk) };
        end
        
        disp(sprintf('In the batch run " %s " the following simulation files were not found: ', ...
            run_name{i}))
        disp(fnNotfound')
        disp( '***' )
        
        if flgFIX ==1
            fn = { fn{iF} };
            save([run_name{i} '_mod'], 'Cpto', 'fn', 'Hs', 'resDir', 'sea', 'Tp');
        end
        
        clearvars fnNotfound Eflg
    end
end
