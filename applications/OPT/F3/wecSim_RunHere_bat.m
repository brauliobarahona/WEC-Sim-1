%%% WEC-Sim run file
% This script add the WEC-Sim "source" folder to the path, and sets up
% sequential simulations, storing results for each
%
% Braulio Barahona
%
close all; clear all;
%% add to path
addpath(genpath('C:\Users\bbarahon\Documents\GitHub\WEC-Sim-1\source'))

%% Start WEC-Sim log
% bdclose('all');
clc; diary off;
% if exist('simulation.log','file'); delete('simulation.log'); end
% diary('simulation.log')

%% Read initialization input file
fprintf('\nWEC-Sim Read Input File ...   \n'); tic;
evalc('wecSimInputFile_batch_testINIT');
toc;

%% Setup simulation
fprintf('\nWEC-Sim Pre-processing ...   \n'); tic;
simu.numWecBodies = length(body(1,:));    %count number of bodies in the Simulink model

if exist('constraint','var') == 1
    simu.numConstraints = length(constraint(1,:));
    for ii = 1:simu.numConstraints
        constraint(ii).constraintNum = ii;
    end
end

if exist('pto','var') == 1
    simu.numPtos = length(pto(1,:));
    for ii = 1:simu.numPtos
        pto(ii).ptoNum = ii;
    end
end

%% Check that the hydro data for each body is given for the same frequencies
for ii = 1:simu.numWecBodies
    if length(body(1).hydroData.simulation_parameters.w) ~= ... 
            length(body(ii).hydroData.simulation_parameters.w)
        error('BEM simulations for each body must have the same number of frequencies')
    else
        for jj = 1:length(body(1).hydroData.simulation_parameters.w)
            if body(1).hydroData.simulation_parameters.w(jj) ~= ...
                    body(ii).hydroData.simulation_parameters.w(jj)
                error('BEM simulations must be run with the same frequencies.')
            end; clear jj;
        end
    end
end; clear ii; toc;
%

%% Loop to run various simulations
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

% (2) Set up directories
% setup output directories and log file
if exist(simu.resDir, 'dir') ==0
    mkdir(simu.resDir);
end

% (3) Loop simulations
for jj = 1:length(Cpto)
    
    % update simulation parameters for each case
    waves.H = Hs(jj);     % wave significant height [m]
    waves.T = Tp(jj);     % wave peak perido [s]
    
    simu.dt = Tp(jj)/200;    % simulation time step [s]
    simu.endTime = ceil(tend/simu.dt) * simu.dt; 
    simu.CITime = 2*Tp(jj);    % convolution integral integration time [s]
    simu.rampT = 5*Tp(jj);     % ramp time [s]
    
    pto(1).c= Cpto(jj);    % PTO Damping [ N/ (m/s)]
    
    % make file names for log and output files
    fn{jj} =strcat(fnprefix, '_Tp', num2str(waves.T), '_Hs', ...
                            num2str(waves.H), '_dt',num2str(simu.dt), ...
                            '_Cpto', num2str(pto(1).c) );
    
    % start log
    diary([simu.resDir '\' fn{jj} '.log']);
    
    % (***) HydroForces Pre-Processing: Wave Setup & HydroForcePre
    tic;
    fprintf('\nWEC-Sim Wave Setup & Model Setup & Run WEC-Sim ...   \n')
    
    simu.rhoDensitySetup( body(1).hydroData.simulation_parameters.rho, ...
        body(1).hydroData.simulation_parameters.g )
    
    waves.waveSetup( body(1).hydroData.simulation_parameters.w, ...
        body(1).hydroData.simulation_parameters.water_depth, ...
        simu.rampT, simu.dt, simu.maxIt, simu.g);
    
    for kk = 1:simu.numWecBodies
        body(kk).hydroForcePre( waves.w, simu.CIkt, waves.numFreq, simu.dt, ...
            simu.rho, waves.type, kk, simu.numWecBodies, ...
            simu.ssCalc);
    end; clear kk
    
    % (***) Output All the Simulation and Model Setting
    run ListInfo
    
    % (***) Load simMechanics file & Run Simulation   
    fprintf('\nSimulating the WEC device defined in the SimMechanics model %s...   \n',simu.simMechanicsFile)
    simu.loadSimMechModel(simu.simMechanicsFile);
    
    for iBod = 1:simu.numWecBodies; body(iBod).adjustMassMatrix; end; clear iBod
    
    tDelayWarning = 'Simulink:blocks:TDelayTimeTooSmall';
    warning('off',tDelayWarning); clear tDelayWarning
    
    if simu.rampT == 0; simu.rampT = 10e-8; end
    
    % ********************* run SimMechanics model *********************
    sim(simu.simMechanicsFile);    % 
    % ******************************************************************
    
    if simu.rampT == 10e-8; simu.rampT = 0; end
    
    for iBod = 1:simu.numWecBodies
        body(iBod).restoreMassMatrix
    end; clear iBod
    
    
    % (*) Post processing and Saving Results
    % TODO: just include the scripts here, it's just nicer since they are
    % in the loop
    flgPost = 0;
    if flgPost == 0
        run Post_process.m
    elseif flgPost ==1
        run SaveThisHere.m
    end
    
    clear ans; toc;
end % end of loop

% save file/dir names and other variables for the batch 
save('filenames', 'fn')