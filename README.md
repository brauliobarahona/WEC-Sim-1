## WEC-Sim
Dynamics simulator of wave energy converters in Matlab/Simulink. WEC-Sim (Wave Energy Converter Simulator) documentation can be found [here](http://wec-sim.github.io/WEC-Sim).

Equations of motion of multiple bodies are handled with SimMechanics blocks, controls can be developed with normal Simulink blocks, formulations of hydrodynamic and mooring forces on rigid bodies are included in the Simulink library. 

<a href="https://raw.githubusercontent.com/brauliobarahona/WEC-Sim-1/master/wecsim_smaller.png"><img src="https://raw.githubusercontent.com/brauliobarahona/WEC-Sim-1/master/wecsim_smaller.png" align="center" width="500"></a>


## In this repository ...
+ Proposed workflow for loads analysis:

<a href='https://raw.githubusercontent.com/brauliobarahona/WEC-Sim-1/master/loads_analysis_workflow.png'><img src="https://raw.githubusercontent.com/brauliobarahona/WEC-Sim-1/master/loads_analysis_workflow.png" align="center" width="550"></a>

+ Sea state class

A collection of sea state occurrence data for Humboldt bay site found in the literature, with the posibility of reducing the number of sea states by specifiyng period and significant wave height to interpolate a given data set.

+ Batch scripts
  
+ Post-processing scripts
  + Gathering of WEC-Sim simulation output for different sea states, damping of power take-off system, and incident wave phase
  + Rainflow counting using [this Matlab Central code](http://www.mathworks.com/matlabcentral/fileexchange/3026-rainflow-counting-algorithm)
  + Basic statistics and damage equivalent loads

## How to ?
+ Download/clone this repository
+ First things, first check that WEC-Sim runs:
  + Run `wecSim_RunHere.m` from the folder `WEC-Sim-1\applications\RM3`
    + **(!)** if this did not run verify that the path was added correctly
      `addpath( genpath('..\..\source') )`
      works on my Windows machine, it should work on yours
  + Alternatively, check out the oficial documentation and do the *installation*, the point is just that you make sure things are running before proceeding to run the batch simulations
+ Now, let's check the workflow for running batch simulations and post-processing
  + If you are not already there, navigate to `WEC-Sim-1\applications\RM3` and run `wecSim_RunHere_bat.m`
    + If things went fine, after several minutes you will find `FirstTimeTestfilenames.mat` in the current folder
  + To test the post-processing script:
    + Get [this repository for Rainflow counting](http://www.mathworks.com/matlabcentral/fileexchange/3026-rainflow-counting-algorithm) or use your own replacing `sig2ext.m` and `rainflow.m` in the post-processing script
    + Remember where you put the Rainflow repository, you will need this in your path, in my case I put it under `Documents\Matlab\work\Fatigue`
    + Run `post_processingV0_FirstTimeTest.m`, it will prompt you to input the path ... then it will give you a couple of plots


  
  
