%% Simulation Settings and Parameters
% General
simu = simulationClass();               % Create the Simulation Class
simu.explorer = 'off';
simu.mode = 'rapid-accelerator';
simu.simMechanicsFile = 'RM3.slx';      % Name/Location of Simulink Model

% Waves
waves = waveClass('irregular');         % Wave spectrum settings
waves.spectrumType = 'BS';
waves.randPreDefined = 1;

% Body Data setup 
% body 1 - Float
body(1) = bodyClass('hydroData/opt.h5',1);      
    %Create the body(1) Variable, Set Location of Hydrodynamic Data File 
    %and Body Number Within this File.        
body(1).mass = 'equilibrium';                   
    %Body Mass. The 'equilibrium' Option Sets it to the Displaced Water 
    %Weight.
body(1).momOfInertia = [10687826 9603025 17589644]; 
    %Moment of Inertia [kg*m^2]     
body(1).geometryFile = 'geometry/float.stl';    %Geometry File

% (!) Calculated by Jennifer, see spread sheet
body(1).viscDrag.cd = [0.0 0.0 4.9581 0.0 0.0 0.0];
body(1).viscDrag.characteristicArea = [0.0 0.0 2*8.65*15 0.0 0.0 0.0];

% body 2 - Monopile
body(2) = bodyClass('hydroData/opt.h5',2);     
body(2).mass = 'fixed';                   
body(2).geometryFile = 'geometry/monopile.stl'; 

% PTO and Constraint Parameters
constraint(1) = constraintClass('Constraint1'); 
                        %Create Constraint Variable and Set Constraint Name
constraint(1).loc = [0.0 0.0 -5.5];     %Constraint Location [m]

pto(1) = ptoClass('PTO1');                      
                        %Create PTO Variable and Set PTO Name
pto(1).k=0;                    % PTO Stiffness [N/m]
pto(1).loc = [0 0 -5.5];       % PTO Location [m]

%% **********************************************************************
% the following parameters are adjusted for each simulation, depending on
% the wave significant height and peak period, of each sea state (see SeaState 
% class) and the wecSim_RunHere_bat.m file

tend = 1;    % (!) keeping it fixed for now ...Simulation End Time [s]
simu.dt = 0.1;         % Simulation Time-Step [s]
simu.rampT = 100;      % Wave Ramp Time Length [s]

waves.H = 2.5;    % Significant Wave Height [m]
waves.T = 10;     % Peak Period [s]

pto(1).c=1200000;    % PTO Damping [N/(m/s)]

%% batch and output-related variables
% Sea state

%
fnprefix = 'R1_'; 