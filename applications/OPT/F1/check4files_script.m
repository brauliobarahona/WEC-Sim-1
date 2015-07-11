% Script to check that output files are there, to be loaded. It also saves
% the corresponding Hs, Tp parameters to keep track for 3D plotting.
%
clc; clear all;
% Run names - files containing each a set of simulation file names
run_name = {'F1v0_1filenames';'F1v0_2filenames';'F1v0_3filenames';'F1v0_4filenames';
            'F1v0_5filenames';'F1v0_6filenames';'F1v0_8filenames';
            'F1v0_9filenames';'F1v0_10filenames';'F1v0_11filenames';'F1v0_12filenames'};

flgFIX = 1;   % set this flag to 1 to discard names of files that where not found
              % and save another *.mat file with names for the simulation
              % output files found
              
for i = 1:length(run_name) % (!) check that Tp, Hs, and Cpto were the same 
                           % for different batch simulations
    if i >=2
        checkSets(i-1, :) = [ isequaln(tempT, Tp), isequaln(tempH, Hs), ...
            isequaln(tempC, Cpto)];
    end
    
    load(run_name{i})  % loads: files names in a batch -> fn,
                       %        (!) Hs, Tp correspond to the set batch, but
                       %        if the start was tweaked or the batch did
                       %        not finish they don't correspond to the the
                       %        actual values run, i.e. length(Hs) will be
                       %        different than length( fn{iF} c)
    tempT = Tp;    tempH = Hs;    tempC = Cpto;   %save temp vars for next loop
    
    % TODO: display warning if is not the case that checkSets == 1
end

% compute sets of indexes, for later use in arranging Hs - Tp matrix
trnsTp = find( diff(tempT) <= 1 ); % index of turns, Ts increases at same Hs
NsetsHs = length(trnsTp) + 1;      % number of turns + 1 -> sets of Hs

% sets of indexes of Tp for same Hs, i.e. for each set of Hs
for i = 1:length(trnsTp)
    if i ==1;
        iSets{i} = 1:trnsTp(i);   % first set
   
    elseif i >= 2
        iSets{i} = trnsTp(i-1)+1: trnsTp(i);
        
    end
end
iSets{length(trnsTp)+1} = trnsTp(end)+1: length(tempT); % last set

for i = 1:length(run_name) % check if files exist and discard names to files 
                           % that are not found

    load(run_name{i})  % loads: files names in a batch -> fn,
    %        (!) Hs, Tp correspond to the set batch, but
    %        if the start was tweaked or the batch did
    %        not finish they don't correspond to the the
    %        actual values run, i.e. length(Hs) will be
    %        different than length( fn{iF} c)
    
    for j = 1:length(fn)
        
        %check if simulation output file is there
        Eflg(j) = exist(['E:\wecSim\resV0_Float1\res\' fn{j}, '.mat'], 'file');
        %         Eflg(j) = exist(['.\output\res\' fn{j}, '.mat'], 'file');
    end
    
    iF = find(Eflg == 2);   % index for files found
    inotF = find(Eflg == 0);   % index for files not found
    
    if isempty(inotF) == 0;  % if there are files missing
        
        for kk = 1 : length(inotF)
            fnNotfound{kk} = fn{ inotF(kk) };
        end
        
        disp(sprintf('In the batch run " %s " the following simulation files were not found: ', ...
            run_name{i}))
        disp(fnNotfound')
        disp( '***' )
        
        if flgFIX ==1
            fn = { fn{iF} };
            Tp = Tp(iF);
            Hs = Hs(iF);
            Cpto = Cpto(iF);
            save([run_name{i} '_mod'], 'Cpto', 'fn', 'Hs', 'resDir', 'sea', 'Tp');
        end
        
        clearvars fnNotfound Eflg
    end
    % index offset
    for ii = 1:length(iSets)
        if ~isempty( find( iSets{ii} == find(tempH == Hs(1),1) ))
            break
        end
    end
    iOFF(i) = iSets{ii}(1) - 1;
    % TODO: save batch parameters, i.e. Hs(  length(run_name) *
    % length(fn) ), Tp(  length(run_name) * length(fn) )
end

% save *.mat file with 
save('base_parameters_F1v0', 'tempT', 'tempH', 'tempC', 'trnsTp', ...
     'NsetsHs', 'iSets', 'iOFF');