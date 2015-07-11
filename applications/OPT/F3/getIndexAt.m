function [ix, nts, dt] = getIndexAt(sig, tMAX)
% This function sets up indexes for selecting a 1-hr window of a given time
% series and break-down into 1-min segments
%
% dt: time step of the time series (!) 
% nts: number of time steps 
% ix: vector of indexes of the 1-hr window

dt = diff( sig(1:2) );   % time step (s)
nts= ceil( tMAX / dt );    % number of time steps
ix = length(sig)-nts:length(sig);    % index