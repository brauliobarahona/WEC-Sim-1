function check4files(run_name, base_par, varargin)
% check4files(run_name, varargs)
%
% Script to check which output files were saved when a batch simulation failed.
% It also saves parameters that facilitate populating a Hs-Tp matrix when there
% are different number of realizations for each sea state.
%
% Inputs:
% run_name = cell containing simulation file names
% base_par = name for 'base' parameters *.mat
%
% Optional inputs:
% dirF = directory where 'run_name' files are to be found, and where modified
% 'run_name' files will be save
%
% dirOUT = output directory where the 'base_par' file is saved
%
% Outputs:
% saves a *.mat file at 'dirOUT'
%
% braulio barahona
%
nargin
if nargin == 2
    %set directories for the case when no directory was specified
    dirF = [cd '\']; dirOUT = [cd '\'];
elseif nargin ==3
    %input and out directories are the same
    dirOUT = varargin{1};
    dirF = varargin{1};
elseif nargin ==4
    %input and output directories are given
    dirOUT = varargin{2};
    dirF = varargin{1};
end
    

flgFIX = 1;   % set this flag to 1 to discard names of files that where not found
              % and save another *.mat file with names for the simulation
              % output files found

for i = 1:length(run_name) % (!) check that Tp, Hs, and Cpto were the same 
                           % for different batch simulations, these is the
                           % 'base' setup
    if i >=2
        checkSets(i-1, :) = [ isequaln(tempT, Tp), isequaln(tempH, Hs), ...
            isequaln(tempC, Cpto)];
    end
    
    load(run_name{i})  % loads: files names in a batch -> fn,
                       %        (!) Hs, Tp correspond to the set batch, but
                       %        if the start was tweaked or the batch did
                       %        not finish they don't correspond to the the
                       %        actual values run, i.e. length(Hs) will be
                       %        different than length( fn{iF} )
    tempT = Tp;    tempH = Hs;    tempC = Cpto;   %save temp vars for next loop
    
    % TODO: display warning if is not the case that checkSets == 1
end

% compute sets of indexes, for later use in arranging Hs - Tp matrix
trnsTp = find( diff(tempT) <= 1 ); % index of turns, Ts increases at same Hs
NsetsHs = length(trnsTp) + 1;      % number of turns + 1 -> sets of Hs

% sets of indexes of Tp for same Hs (i.e. for each value of Hs there are a
% a number of Tp values)
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
    %        different than length( fn{iF} )
    
    for j = 1:length(fn)
        
        %check if simulation output file is there
        Eflg(j) = exist([dirF, fn{j}, '.mat'], 'file');
        %         Eflg(j) = exist(['.\output\res\' fn{j}, '.mat'], 'file');
    end
    
    iF = find(Eflg == 2);   % index for files found
    
    if isempty( iF ) == 1   % (!) none of the files are in dirF 
        MSGstr1= strcat(' Hey ! you did not provide a directory for the files that you ', ...
       'are looking for. None of the files were found in this directory ->  ', cd);
       error(MSGstr1) 
       break    
    end
    
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
            
            save([dirF, run_name{i}, '_modX'], 'Cpto', 'fn', 'Hs', 'resDir', 'sea', 'Tp');
        end
        
        clearvars fnNotfound Eflg
        
        % index offset
        for ii = 1:length(iSets)
            
            ixHs_inFN = find(tempH == Hs(1),1);   % index, locates the first value
            % of Hs found in the output files in the 'base' Hs setup
            
            if ~isempty( find( iSets{ii} == ixHs_inFN )) %stops loop
                break
            end
        end
        iOFF(i) = iSets{ ii }(1) - 1;    % check the post processing script (!)
    end
    %
    
%     (!) if all the files are there !!!
    
    %
    % TODO: save batch parameters, i.e. Hs(  length(run_name) *
    % length(fn) ), Tp(  length(run_name) * length(fn) )
end

% save *.mat file with 
save([dirOUT, base_par], 'tempT', 'tempH', 'tempC', 'trnsTp', ...
     'NsetsHs', 'iSets', 'iOFF');