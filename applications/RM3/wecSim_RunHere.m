%%% WEC-Sim run file
% modified to run without 'installation' - just adds WEC-Sim folder to the
% path
%
close all; clear all;
%% Add WecSim directories to the path
  % (!) this is a relative path, you may want to change it to an absolute path
  addpath(genpath('..\..\source'))
  %

%% Start WEC-Sim log
%bdclose('all');
clc; diary off;
if exist('simulation.log','file'); delete('simulation.log'); end
diary('simulation.log')

%% Read input file
fprintf('\nWEC-Sim Read Input File ...   \n'); tic;
evalc('wecSimInputFile');
toc;

%% Setup simulation
fprintf('\nWEC-Sim Pre-processing ...   \n'); tic;
simu.numWecBodies = length(body(1,:));
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
    if length(body(1).hydroData.simulation_parameters.w) ~= length(body(ii).hydroData.simulation_parameters.w)
        error('BEM simulations for each body must have the same number of frequencies')
    else
        for jj = 1:length(body(1).hydroData.simulation_parameters.w)
            if body(1).hydroData.simulation_parameters.w(jj) ~= body(ii).hydroData.simulation_parameters.w(jj)
                error('BEM simulations must be run with the same frequencies.')
            end; clear jj;
        end
    end
end; clear ii; toc;

%% HydroForces Pre-Processing: Wave Setup & HydroForcePre
tic;
fprintf('\nWEC-Sim Wave Setup & Model Setup & Run WEC-Sim ...   \n')
simu.rhoDensitySetup(body(1).hydroData.simulation_parameters.rho,body(1).hydroData.simulation_parameters.g)
waves.waveSetup(body(1).hydroData.simulation_parameters.w, body(1).hydroData.simulation_parameters.water_depth, simu.rampT, simu.dt, simu.maxIt, simu.g);

for kk = 1:simu.numWecBodies
    body(kk).hydroForcePre(waves.w,simu.CIkt,waves.numFreq,simu.dt,simu.rho,waves.type,kk,simu.numWecBodies,simu.ssCalc);
end; clear kk

%% Output All the Simulation and Model Setting
run ListInfo

%% Load simMechanics file & Run Simulation
fprintf('\nSimulating the WEC device defined in the SimMechanics model %s...   \n',simu.simMechanicsFile)

simu.loadSimMechModel(simu.simMechanicsFile);

for iBod = 1:simu.numWecBodies; body(iBod).adjustMassMatrix; end; clear iBod

tDelayWarning = 'Simulink:blocks:TDelayTimeTooSmall';
warning('off',tDelayWarning); clear tDelayWarning

if simu.rampT == 0; simu.rampT = 10e-8; end

if strcmp(simu.explorer,'on') &&  ~isfloat(waves.waterDepth)
    waves.waterDepth = 200;
    warning('Invalid water depth given. waves.waterDepth set to 200m for vizualisation.')
end

sim(simu.simMechanicsFile);    % run SimMechanics model

if simu.rampT == 10e-8; simu.rampT = 0; end

for iBod = 1:simu.numWecBodies
    body(iBod).restoreMassMatrix
end; clear iBod

%% %% Post processing and Saving Results
% bodiesOutput = struct();
for iBod = 1:simu.numWecBodies
    eval(['body' num2str(iBod) '_out.name = body(' num2str(iBod) ').hydroData.properties.name;']);
    if iBod == 1; bodiesOutput = body1_out; end
    bodiesOutput(iBod) = eval(['body' num2str(iBod) '_out']);
    eval(['clear body' num2str(iBod) '_out'])
end; clear iBod
if exist('pto','var')
    for iPto = 1:simu.numPtos
        eval(['pto' num2str(iPto) '_out.name = pto(' num2str(iPto) ').name;'])
        if iPto == 1; ptosOutput = pto1_out; end
        ptosOutput(iPto) = eval(['pto' num2str(iPto) '_out']);
        eval(['clear pto' num2str(iPto) '_out'])
    end; clear iPto
else
    ptosOutput = 0;
end
if exist('constraint','var')
    for iCon = 1:simu.numConstraints
        eval(['constraint' num2str(iCon) '_out.name = constraint(' num2str(iCon) ').name;'])
        if iCon == 1; constraintsOutput = constraint1_out; end
        constraintsOutput(iCon) = eval(['constraint' num2str(iCon) '_out']);
        eval(['clear constraint' num2str(iCon) '_out'])
    end; clear iCon
else
    constraintsOutput = 0;
end
output = responseClass(bodiesOutput,ptosOutput,constraintsOutput);
clear bodiesOutput ptosOutput constraintsOutput

for iBod = 1:simu.numWecBodies
    %     body(iBod).storeForceAddedMass(output.bodies(iBod).forceAddedMass)
    output.bodies(iBod).forceTotal = output.bodies(iBod).forceTotal - output.bodies(iBod).forceAddedMass;
    output.bodies(iBod).forceAddedMass = body(iBod).forceAddedMass(output.bodies(iBod).acceleration);
    output.bodies(iBod).forceTotal = output.bodies(iBod).forceTotal + output.bodies(iBod).forceAddedMass;
end; clear iBod

% User Defined Post-Processing
if exist('userDefinedFunctions.m','file') == 2
    userDefinedFunctions;
end


clear ans; toc;
diary off; movefile('simulation.log',simu.logFile)
save(simu.caseFile)

