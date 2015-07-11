addpath(genpath('C:\Users\bbarahon\Documents\GitHub\WEC-Sim-1\'))
% Run names - files containing each a set of simulation file names
run_name = {'Rv0_1filenames';'Rv0_3filenames';
    'Rv0_5filenames';'Rv0_6filenames';'Rv0_7filenames';
    'Rv0_10filenames';'Rv0_11filenames';'Rv0_12filenames'};

dirIN = 'E:\wecSim\resV0_Float3\res\';
dirOUT = 'C:\Users\bbarahon\Documents\GitHub\WEC-Sim-1\applications\OPT\F3\';
check4files(run_name, 'basepar',dirIN, dirOUT)