% Script to post process a single batch of WecSim simulations
% - WecSim output file names and simulation settings are retrieved from 
%   "..._filenames.mat"
% - Rainflow counts are done with the algorithm found in:
%   http://www.mathworks.com/matlabcentral/fileexchange/3026-rainflow-counting-algorithm
%
% Braulio Barahona
%
clear all; clc;
% Add fatigue and WecSim directories to the path
addpath(genpath('C:\Users\bbarahon\Documents\MATLAB\work\Fatigue'))
addpath(genpath('C:\Users\bbarahon\Documents\GitHub\WEC-Sim-1\source'))

% Set up parameters for post-processing
tMAX = 3600;    % Set time for analysis (s)

% Setup stuff for damage eq. loads
mm = [6.5 6.5 6.5 12 12 12 4 4 4 6.5 6.5 6.5]; %Wohler exponent 
% No = 600; % 1 Hz eq. load for 10 min --> this will depend on the time series length !
No = 3600;  % ... 1 hr

% (1) Load file names and loop parameters
%load filenames - *make loop to load different batch simulation output
% load R2_filenames
load R3_filenames
% load R4_filenames

% (!) reset location of output files: "resDir"
%resDir = 'E:\wecSim\res';

% fn, Tp, Hs, Cpto
% (!?) need to know Sea State matrix
sea = SeaState('humboldtBuoy');
% (!) "sea" class - not working
cEx99 =[];
% (2) Load output files
for i = 1:length(fn)
    
    %calculate number of samples
    load(['E:\wecSim\res' '\' fn{i} '.mat'])
    
    % dt, end time, ramp time = 5*Tp
    [ix, nts, dt] = getIndexAt(ptoout.time, tMAX);
    
    % (!)  cut time series to the appropriate length :: 1hr
    t = ptoout.time(ix);
    x = ptoout.pos(ix);
    v = ptoout.vel(ix);
    f = ptoout.forceOrTorque(ix);
    p = ptoout.power(ix);
    
    % get average power
    pow(i) = mean( p );
    
    % get basic statistics
    mxf(i) = max(f);
    mnf(i) = mean(f);
    stf(i) = std(f);
    
    % RMS
    RMSf(i) = sqrt( mean(abs(f).^2) );
    
    % TODO: extreme value analysis load range/absolute force (or moment), 
    %       and dispalcements
    % Emphirical CDF
    ecdf{i} = [ [1/length(f):1/length(f):1]', sort( abs(f) ) ];
    
    % block maxima method
    nts1min = ceil(nts/60); 
    ix1m = ix(1):nts1min:ix(end);
    
    % peak-over-threshold
    i99 = find(ecdf{i}(:,1) > 0.9995, 1);
    Ex99_sf = ecdf{i}(i99:end, 2); 
    
    cEx99 = [cEx99; max(Ex99_sf)];
    
    POTval{i} = [ [1/length(Ex99_sf):1/length(Ex99_sf):1]', Ex99_sf  ]; %here select values over a given threshold
    
    % Damage equivalent loads
    % get extrema
    [ext, exttime] = sig2ext(f, t);
    
    % do rainflow counting
    rf = rainflow( ext, exttime );
    
    % calculate eq. loads
    N = rf(3,:);  % Number of cycles (0.5 or 1.0)
    S = 2*rf(1,:);% Cycles amplitude
    So(i) = ( 1/No *sum( N.*( S.^mm(1) ) ) ).^(1/mm(1));
    
end
%% Save post-processed data

% sort power and DEL
[spow, I] = sort(pow);
sSo = So(I);

% Sort combined extreme values from different Sea-states / seeds
sEX99 = sort(cEx99);
eF_Ex = 1/length(sEX99):1/length(sEX99):1;

%fit data
[Pfit, Sfit, MU]  = polyfit([0 spow], [0 sSo], 3);
% TODO

%% sort things out for plotting 
find( Tp == Tp(1) );    % Tp - Hs matrix is populated irregularly

trnsTp = find( diff(Tp) <= 1 );    % index of turns, Ts increases at same Hs
setsHs = length(trnsTp) + 1;    % number of turns + 1 -> sets of Hs

% sets of indexes of Tp for same Hs, i.e. for each set of Hs
for i = 1:length(trnsTp)
    if i ==1;
        ixTp_sets{i} = 1:trnsTp(i);
   
    elseif i >= 2
        ixTp_sets{i} = trnsTp(i-1)+1: trnsTp(i);
        
    end
end
ixTp_sets{length(trnsTp)+1} = trnsTp(end)+1: length(Tp);
%
%% set up Tp and Hs "table headers" or x-y axes
clear Tp_vec Hs_vec
close all
for i = 1:setsHs  % Significant wave height [m]
    Hs_vec(i) = Hs( ixTp_sets{i}(1) );
end

for i = 1:length(ixTp_sets)
    % note: for each value of Hs, there are several values of Tp which
    % increase monotonically (and are equally spaced), this is set up in 
    % the batch script/seaState class
    if i ==1
        Tp_vec = Tp(ixTp_sets{i});
    end
    tempTp = Tp( ixTp_sets{i} );
    Tp_vec = [Tp_vec, tempTp( find( tempTp > Tp_vec(end), 1 ) : end ) ];
end

% initialize matrices to populate
So_mtrx = zeros(setsHs, length(Tp_vec));    % matrix/table Hs \ Tp
P_mtrx = So_mtrx;
C_mtrx = So_mtrx;
s_mtrx = So_mtrx;

% populate Hs\Tp table of Eq. loads
for i = 1:setsHs
    SoRow = So( ixTp_sets{i} );
    PowRow= pow( ixTp_sets{i} );
    C_Row = Cpto( ixTp_sets{i} );
    s_Row = stf( ixTp_sets{i} );
    
    i0i = find(Tp_vec == min( Tp(ixTp_sets{i})  ));
    
    So_mtrx(i, i0i: length( Tp(ixTp_sets{i}))+i0i-1  ) = SoRow;
    P_mtrx(i, i0i: length( Tp(ixTp_sets{i}))+i0i-1  ) = PowRow;
    C_mtrx(i, i0i: length( Tp(ixTp_sets{i}))+i0i-1  ) = C_Row;    
    s_mtrx(i, i0i: length( Tp(ixTp_sets{i}))+i0i-1  ) = s_Row;    
end
% % example to check
% iexT = find(Tp == Tp_vec(5));

%% plots
close all
FS = 10;
figName = 'Damage equivalent loads';
LegX = 'T_p [s]'; LegY = 'H_s [m]'; LegC = 'S_o [N]';

% plot Damage Equivalent loads
of1 = sea.post_plot(Tp_vec, Hs_vec, So_mtrx, {figName, LegX, LegY, LegC} );

% plot Power
figName = '1-hr Average power';
LegC = 'P [W]';
of2 = sea.post_plot(Tp_vec, Hs_vec, P_mtrx, {figName, LegX, LegY, LegC} );

% plot PTO damping
figName = 'Power take-off damping';
LegC = 'c [kg/s]';
of3 = sea.post_plot(Tp_vec, Hs_vec, C_mtrx, {figName, LegX, LegY, LegC} );

% plot PTO Force standard deviation
figName = 'PTO force standard devation';
LegC = '\sigma [N]';
of4 = sea.post_plot( Tp_vec, Hs_vec, s_mtrx, {figName, LegX, LegY, LegC} );

%plot sea state
sea.plot('surf')

% plot DEL vs. Average Power
figure; plot(spow, sSo, 'o');
hold on;
plot(0:spow(end)/100:spow(end), polyval(Pfit, 0:spow(end)/100:spow(end), [], MU), 'r--')

%% plot ecdf of force
%close fecdf
fecdf = figure; AXecdf=axes('parent', fecdf);
for i=1:length(ecdf)
    plhndE(i) = semilogx(AXecdf, ecdf{i}(:, 2), ecdf{i}(:, 1), 'c'); hold on;
end
% set(AXecdf,'YLim',[0.9 1])8

%% plot on Weibull paper
%close fecdf
fecdf = figure; AXecdf=axes('parent', fecdf);
for i=1:length(ecdf)
        plhndE(i) = plot(AXecdf, log10(  -log( 1- ecdf{i}(:, 2)) ), ...
            log10( ecdf{i}(:, 1) ), 'c'); hold on;
end
% set(AXecdf,'YLim',[0.9 1])

%% plot Extreme values from POT method on Weibull paper
%close fecdf
fecdf = figure; AXecdf=axes('parent', fecdf);
for i=1:length(ecdf)
        plhndE(i) = plot(AXecdf, log10(  -log( 1- POTval{i}(:, 2)) ), ...
            log10( POTval{i}(:, 1) ), 'c.'); hold on;
end
% set(AXecdf,'YLim',[0.9 1])
% TODO: save plots

%% emphirical CFD of maximum vlaues
figure;
plot(sEX99, eF_Ex, '.')

%
%% plot Extreme values from POT method on Weibull paper
%close fecdf
fecdf = figure; AXecdf=axes('parent', fecdf);
for i=1:length(ecdf)
        plhndE(i) = plot(AXecdf, log10(  -log( 1- sEX99) ), ...
            log10( eF_Ex ), 'c.--'); hold on;
end

% TODO: save plots
% 
%% plot example
% fSo = figure('name', figName);
% axSo = axes('parent', fSo);
% pltH_So = surf(axSo, Tp_vec, Hs_vec, So_mtrx);
% 
% hcb = colorbar; axis tight; view(0,90)
% xlabel(LegX); ylabel(LegY); hcb.Label.String = LegC;
% figure, surf(Tp_vec, Hs_vec, P_mtrx)
% colorbar
% axis tight
% view(0,90)
                                             