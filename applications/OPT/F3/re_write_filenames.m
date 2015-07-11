% *** re-do file names ***
%
% Script to re-write filenames.mat file

% add path
addpath(genpath('C:\Users\bbarahon\Documents\GitHub\WEC-Sim-1\source'))

% from wecSimInputFile_batch_testINIT.m
fnprefix = 'Rv0_9'; 

% (1) Set up variables to loop
%   1.1 Sea state
%     *Humboldt Buoy-reduced, Yu et al., 2014 -> 'humboldtRed'
%     *Humboldt Buoy, Dallman et al., 2014 -> 'humboldtBuoy'
%     *Humboldt hindcast model, Dallman et. al., 2014 -> 'humboldtModel'
sea = SeaState('humboldtBuoy');
[Hs, Tp, JDP] =sea.set4loop;

%   1.2 PTO Damping from Jennifer
% *load
run setPTO_damping

% *interpolate -> (!) use the matrix corresponding to Float and Cd
Cpto = interp2( sea_pto.Tp, sea_pto.Hs, CPTOf3_Cd496, Tp, Hs );

iw = find(isnan(Cpto(:)) == 0); %get rid of NaN
Tp = Tp(iw);
Hs = Hs(iw);
Cpto = Cpto(iw);

% (3) Loop simulations
for jj = 1:length(Cpto)
    
    % make file names for log and output files
    fn{jj} =strcat(fnprefix, '_Tp', num2str( Tp(jj) ), '_Hs', ...
                   num2str( Hs(jj) ), '_dt', num2str( Tp(jj)/200 ), ...
                   '_Cpto', num2str( Cpto(jj) ) );
    
end

% save file/dir names and other variables for the batch 
resDir = 'EXAMPLE DIRECTORY';
save([fnprefix, 'filenames'], 'fn', 'Hs', 'Tp', 'Cpto', 'sea', 'resDir')