% Script to change the end time of WecSim output files, to emulate a random
% wave phase
%
% braulio barahona
clc; clear all; close all;

% (1) set up file names
run_name = {'F1v0_1filenames_mod';'F1v0_2filenames_mod'; ...
            'F1v0_3filenames_mod';'F1v0_4filenames_mod'; ...
            'F1v0_5filenames_mod';'F1v0_6filenames_mod'; ...
            'F1v0_8filenames_mod';'F1v0_9filenames_mod'; ...
            'F1v0_10filenames_mod';'F1v0_11filenames_mod'; ...
            'F1v0_12filenames_mod'};

% (2) set up directories
dirIN = [cd '\res\'];
dirOut = [cd '\resOUT\'];

if exist(dirOut, 'dir') == 0
    mkdir(dirOut)
end
%% resize WEC-Sim output
bufferInSim = 400;  % [s]

for jj = 1:length(run_name)
    load( run_name{jj} )
    
    for ii=1:length(fn)
        
        % load files     
        load([dirIN, fn{ii} '.mat']);
        
        % get time step size
        dt = ptoout.time(end) - ptoout.time(end-1);
        nTsteps = ceil( randi(390,1,1)/ dt); % random number to set end of file
        
        ptoout.time = ptoout.time(1:end - nTsteps);
        ptoout.pos = ptoout.pos(1:end - nTsteps);
        ptoout.vel = ptoout.vel(1:end - nTsteps);
        ptoout.forceOrTorque = ptoout.forceOrTorque(1:end - nTsteps);
        ptoout.power = ptoout.power(1:end - nTsteps);
        
        save([dirOut, fn{ii}, '.mat'], 'ptoout')
    end
end