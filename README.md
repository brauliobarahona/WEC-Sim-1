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
++ Gathering of simulation output run in batch for different sea states, damping of power take-off system, and incident wave phase
++ Rainflow counting using [this Matlab Central code](http://www.mathworks.com/matlabcentral/fileexchange/3026-rainflow-counting-algorithm).
