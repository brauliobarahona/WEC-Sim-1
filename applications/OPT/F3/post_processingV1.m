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
%       (!) run_name is the *.mat file name containing parameters of a given
%           batch run, it also includes the WecSim out file names
% run_name = {'R1_filenames';'R2_filenames';'R3_filenames';'R4_filenames';
%     'R5_filenames_mod';'R6_filenames_mod'};

run_name = {'Rv0_1filenames';'Rv0_2filenames_mod';'Rv0_3filenames';'Rv0_4filenames_mod';
            'Rv0_5filenames_mod';'Rv0_6filenames';'Rv0_7filenames';'Rv0_8filenames_mod';
            'Rv0_9filenames_mod';'Rv0_10filenames_mod';'Rv0_11filenames_mod';'Rv0_12filenames'};
% (!) reset location of output files: "resDir"
%resDir = 'E:\wecSim\res';

% fn, Tp, Hs, Cpto
% (!?) need to know Sea State matrix
sea = SeaState('humboldtBuoy');

cEx99 =[];

%load filenames - *make loop to load different batch simulation output
for jj = 1:length(run_name)
    
    load( run_name{jj} );
    
    % (2) Load output files
    for i = 1:length(fn)
        
        %calculate number of samples
        load(['E:\wecSim\resV0_Float3\res\' fn{i} '.mat'])
        
        % dt, end time, ramp time = 5*Tp
        [ix, nts, dt] = getIndexAt(ptoout.time, tMAX);
        
        % (!)  cut time series to the appropriate length :: 1hr
        t = ptoout.time(ix);
        x = ptoout.pos(ix);
        v = ptoout.vel(ix);
        f = ptoout.forceOrTorque(ix);
        p = ptoout.power(ix);
        
        % get average power
        pow(i, jj) = mean( p );
        
        % get basic statistics
        mxf(i, jj) = max(f);
        mnf(i, jj) = mean(f);
        stf(i, jj) = std(f);
        
        % RMS
        RMSf(i, jj) = sqrt( mean( abs(f).^2 ) );
        
        % TODO: extreme value analysis load range/absolute force (or moment),
        %       and dispalcements
        % Emphirical CDF
        ecdf{i, jj} = [ [1/length(f):1/length(f):1]', sort( abs(f) ) ];
        
        % block maxima method
        nts1min = ceil(nts/60);
        ix1m = ix(1):nts1min:ix(end);
        
        % peak-over-threshold
        i99 = find(ecdf{i, jj}(:,1) > 0.9999, 1);
        Ex99_sf = ecdf{i, jj}(i99:end, 2);
        
        % (!) Here select which values are stored for extreme value
        % analysis, in POTval an array of values is stored, in cEx99 a 
        % single value is selected 
        %        
        POTval{i, jj} = [ [1/length(Ex99_sf):1/length(Ex99_sf):1]', Ex99_sf  ]; % selected values over a given threshold
        
        cEx99 = [cEx99; Ex99_sf(1)];   % max(Ex99_sf) : maximum value
                                         % Ex99_sf(1) : 99.99% value
                                         % mean(Ex99_sf) : mean of POT values
        
        % Damage equivalent loads
        % get extrema
        [ext, exttime] = sig2ext(f, t);
        
        % do rainflow counting
        rf = rainflow( ext, exttime );
        
        % calculate eq. loads
        N = rf(3,:);  % Number of cycles (0.5 or 1.0)
        S = 2*rf(1,:);% Cycles amplitude
        So(i, jj) = ( 1/No *sum( N.*( S.^mm(1) ) ) ).^(1/mm(1));
        
    end
    
end
% 
%% Replace zeros with NaN - there will be zeros in these matrices if each
% batch of simulations over sea states (Hs, Tp), were not run for the same
% number of seeds
So( find(So == 0) ) = NaN;   % get rid of zeros
pow( find(pow == 0) ) = NaN;

%% (!) Change units
pow = pow*1e-3;
So = So*1e-6;

%% Get basic statistics for each sea state
for ii=1:length(pow)
    
   kk = find(isnan(pow(ii, :)) == 0 ); %get rid of NaN
   
   meanPOW(ii) = mean(pow(ii,kk));
   stdPOW(ii) = std(pow(ii,kk));
   
   meanSO(ii) = mean(So(ii,kk));
   stdSO(ii) = std(So(ii,kk));
end

% (!) get rid on NaN, before sorting, then sort power and arrange DEL
% accordingly
[spow, I]= sort( pow( find(isnan(pow) == 0 ) ) );

tempSo = So( find(isnan(pow) == 0 ) );
sSo = tempSo(I);

%% (!) Fit data: manually select the polynomial order
[Pfit, Sfit, MU]  = polyfit(spow, sSo, 2);

%% Estimate JPD
% given a data set x, y, bin x and get basic statistics for y values in
% each bin
[N, EDGES, BIN] = histcounts(spow, 'BinMethod', 'fd');
bcX = diff(EDGES)/2 + EDGES(1:end-1);
% figure; bar(bcX, N)
% figure; hist(spow, 20)
for jj=1:length(N)
    mbX_SO(jj) = mean( sSo( find( BIN == jj ))  ) ;
    sigX_SO(jj) = std( sSo( find( BIN == jj ))  ) ;
end

% calculate a sort of conficence interval assuming a Gaussian distribution
up3sigSO =  3*sigX_SO./2 + mbX_SO;
low3sigSO= -3*sigX_SO./2 + mbX_SO;


%% Extreme values during operation
% Sort combined extreme values from different Sea-states / seeds
sEX99 = sort(cEx99);
eF_Ex = 1/length(sEX99):1/length(sEX99):1;

%% sort things out for plotting 3D plots of averaged values
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
    
    SoRow = meanSO( ixTp_sets{i} );
    PowRow= meanPOW( ixTp_sets{i} );
    C_Row = Cpto( ixTp_sets{i} );
%     s_Row = stf( ixTp_sets{i} ); % need to compute mead of std if worth it
    
    i0i = find(Tp_vec == min( Tp(ixTp_sets{i})  ));
    
    So_mtrx(i, i0i: length( Tp(ixTp_sets{i}))+i0i-1  ) = SoRow;
    P_mtrx(i, i0i: length( Tp(ixTp_sets{i}))+i0i-1  ) = PowRow;
    C_mtrx(i, i0i: length( Tp(ixTp_sets{i}))+i0i-1  ) = C_Row;    
%     s_mtrx(i, i0i: length( Tp(ixTp_sets{i}))+i0i-1  ) = s_Row;    
end
% example to check
iexT = find(Tp == Tp_vec(5));

%% plots
close all
FS = 10;

% plot DEL vs. Average Power
figName = 'Damage equivalent loads';
LegX = 'P_a_v_g [kW]'; LegY = 'S_o [MN]'; LegC = '';
sea.post_scatter(pow, So, {figName, LegX, LegY, LegC})

hold on;

plot(0:spow(end)/100:spow(end), polyval(Pfit, 0:spow(end)/100:spow(end), [], MU), 'r--')
plot(bcX,  mbX_SO, 'bo');

% set(gca, 'yscale', 'lin'); %grid on

% plot Power
figName = '1-hr Average power';
LegX= 'T_p [s]'; LegY= 'H_s [m]'; LegC = 'P [kW]';
of2 = sea.post_plot(Tp_vec, Hs_vec, P_mtrx, {figName, LegX, LegY, LegC} );

% % plot PTO damping
% figName = 'Power take-off damping';
% LegC = 'c [kg/s]';
% of3 = sea.post_plot(Tp_vec, Hs_vec, C_mtrx, {figName, LegX, LegY, LegC} );
% 
% plot DEL
figName = 'Damage equivalent loads';
LegC = 'S_o [MN]';
of4 = sea.post_plot( Tp_vec, Hs_vec, So_mtrx, {figName, LegX, LegY, LegC} );

% plot ratio of Load to Power
% TODO: figure out a more clever value to normilize, so that the different
% configurations can be compared to each other.
figName = 'Load to Power ratio - normalized by the minimum ratio found';
LegC = 'S_o / P';
of4 = sea.post_plot( Tp_vec, Hs_vec, ( So_mtrx./P_mtrx)/min( min(So_mtrx./P_mtrx) ),...
    {figName, LegX, LegY, LegC} );
% 
% %plot sea state
% sea.plot('surf')
% 
% % plot DEL vs. Average Power
% figure; semilogy(spow, sSo, 'o');
% hold on;
% semilogy(0:spow(end)/100:spow(end), polyval(Pfit, 0:spow(end)/100:spow(end), [], MU), 'r--')
% 
% %% plot ecdf of force
% %close fecdf
% fecdf = figure; AXecdf=axes('parent', fecdf);
% for i=1:length(ecdf)
%     plhndE(i) = semilogx(AXecdf, ecdf{i}(:, 2), ecdf{i}(:, 1), 'c'); hold on;
% end
% % set(AXecdf,'YLim',[0.9 1])
% 
% %% plot on Weibull paper
% %close fecdf
% fecdf = figure; AXecdf=axes('parent', fecdf);
% for i=1:length(ecdf)
%         plhndE(i) = plot(AXecdf, log10(  -log( 1- ecdf{i}(:, 2)) ), ...
%             log10( ecdf{i}(:, 1) ), 'c'); hold on;
% end
% % set(AXecdf,'YLim',[0.9 1])
% 
% %% plot Extreme values from POT method on Weibull paper
% %close fecdf
% fecdf = figure; AXecdf=axes('parent', fecdf);
% for i=1:length(ecdf)
%         plhndE(i) = plot(AXecdf, log10(  -log( 1- POTval{i}(:, 2)) ), ...
%             log10( POTval{i}(:, 1) ), 'c.'); hold on;
% end
% % set(AXecdf,'YLim',[0.9 1])
% % TODO: save plots
% 
% %% emphirical CFD of maximum vlaues
% figure;
% plot(sEX99, eF_Ex, '.')
% 
% %
%% plot Extreme values from POT method on Weibull paper
%close fecdf
% fecdf = figure; AXecdf=axes('parent', fecdf);
% for i=1:length(ecdf)
%         plhndE(i) = plot(AXecdf, log10(  -log( 1- sEX99) ), ...
%             log10( eF_Ex ), 'c.--'); hold on;
% end
% 
% % TODO: save plots
% % 
% %% plot example
% % fSo = figure('name', figName);
% % axSo = axes('parent', fSo);
% % pltH_So = surf(axSo, Tp_vec, Hs_vec, So_mtrx);
% % 
% % hcb = colorbar; axis tight; view(0,90)
% % xlabel(LegX); ylabel(LegY); hcb.Label.String = LegC;
% % figure, surf(Tp_vec, Hs_vec, P_mtrx)
% % colorbar
% % axis tight
% % view(0,90)
%                                              