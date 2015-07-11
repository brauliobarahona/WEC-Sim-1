% Script to post process a set of batch WecSim simulations
% - WecSim output file names and simulation settings are retrieved from 
%   "..._filenames.mat"
% - Rainflow counts are done with the algorithm found in:
%   http://www.mathworks.com/matlabcentral/fileexchange/3026-rainflow-counting-algorithm
% 
% (!) before post processing run the script check4files
%
clear all; clc;
% Add fatigue and WecSim directories to the pathsea
addpath(genpath('C:\Users\bbarahon\Documents\MATLAB\work\Fatigue'))
addpath(genpath('C:\Users\bbarahon\Documents\GitHub\WEC-Sim-1'))

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

run_name = {'Rv0_1filenames';'Rv0_3filenames';
            'Rv0_5filenames_modX';'Rv0_6filenames';'Rv0_7filenames';
            'Rv0_10filenames_modX';'Rv0_11filenames_modX';'Rv0_12filenames'};
        
% (!) reset location of output files: "resDir"
%resDir = 'E:\wecSim\res';

% (!?) need to know Sea State matrix
sea = SeaState('humboldtBuoy');

load('basepar.mat') % batch simulation settings

cEx99 =[];    % for each output file of each batch: extreme values, 
vecTp = [];   %                                     wave periods,
vecHs = [];   %                                     significant wave heigth
qq = [];    % counter

%load filenames - *make loop to load different batch simulation output
for jj = 1:length(run_name)
    qq = qq +1;
    
    load( run_name{jj} );   % loads output file names -> fn
    
    % (2) Load output files
    for i = 1:length(fn)
        
        % Load: saved output -> ptoout 
        %       simulation parameters -> Tp, Hs, Cpto
        load(['E:\wecSim\resV0_Float3\res\' fn{i} '.mat'])
        
        %check that sizes of fn, Hs, and Tp are consistent
        if (length(Hs) == length(Tp)) == 0 && (length(Hs) == length(fn))
           disp('not same length')
            % break
        end
        
        %calculate number of samples
        % dt, end time, ramp time = 5*Tp
        [ix, nts, dt] = getIndexAt(ptoout.time, tMAX);
        
        % (!)  cut time series to the appropriate length :: 1hr
        t = ptoout.time(ix);
        x = ptoout.pos(ix);
        v = ptoout.vel(ix);
        f = ptoout.forceOrTorque(ix);
        p = ptoout.power(ix);
        
        % (!) reset index according to Tp, Hs 'offset', calculated 
        ikk = i + iOFF(jj);
        
        % get time average of power
        pow(ikk, jj) = mean( p );
        
        % get basic statistics for each output file
        mxf(ikk, jj) = max(f);
        mnf(ikk, jj) = mean(f);
        stf(ikk, jj) = std(f);
        
        % RMS
        RMSf(ikk, jj) = sqrt( mean( abs(f).^2 ) );
        
        % TODO: extreme value analysis load range/absolute force (or moment),
        %       and dispalcements
        % Emphirical CDF
        ecdf{ikk, jj} = [ [1/length(f):1/length(f):1]', sort( abs(f) ) ];
        
        % block maxima method
        nts1min = ceil(nts/60);
        ix1m = ix(1):nts1min:ix(end);
        
        % peak-over-threshold
        i99 = find(ecdf{ikk, jj}(:,1) > 0.9999, 1);
        Ex99_sf = ecdf{ikk, jj}(i99:end, 2);
        
        % (!) Here select which values are stored for extreme value
        % analysis, in POTval an array of values is stored, in cEx99 a 
        % single value is selected 
        %        
        POTval{ikk, jj} = [ [1/length(Ex99_sf):1/length(Ex99_sf):1]', Ex99_sf  ]; % selected values over a given threshold
        
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
        S = 2*rf(1,:);% Cycles amplitude to range
        So(ikk, jj) = ( 1/No *sum( N.*( S.^mm(1) ) ) ).^(1/mm(1));
        
    end
            % save Tp, Hs for 3D plotting
        vecTp = [vecTp Tp];
        vecHs = [vecHs Hs];
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

%% Get basic statistics for each Sea State
for ii=1:length(pow)
    
   kk = find(isnan(pow(ii, :)) == 0 ); %get rid of NaN
   
   meanPOW(ii) = mean(pow(ii,kk));
   stdPOW(ii) = std(pow(ii,kk));
   
   meanSO(ii) = mean(So(ii,kk));
   stdSO(ii) = std(So(ii,kk));
end
run lifeTime.m    % get cycles to failure

% (!) get rid off NaN, before sorting, then sort power and arrange DEL
% accordingly
[spow, I]= sort( pow( find(isnan(pow) == 0 ) ) );

tempSo = So( find(isnan(pow) == 0 ) );
sSo = tempSo(I);

%% (!) Fit data: manually select the polynomial order
[Pfit, Sfit, MU]  = polyfit(spow, sSo, 2);
% [Pfit0, Sfit0]  = polyfitzero(spow, sSo, 2);

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

% Fit binned data
[XBfit, XBS] = polyfit(bcX,  mbX_SO, 2);
%% calculate a sort of conficence interval assuming a Gaussian distribution
up2sigSO =  2*sigX_SO + mbX_SO;
low2sigSO= -2*sigX_SO + mbX_SO;
SigRange = [low2sigSO' up2sigSO'];    % for plotting

%% Extreme values during operation
% Sort combined extreme values from different Sea-states / seeds
sEX99 = sort(cEx99);
eF_Ex = 1/length(sEX99):1/length(sEX99):1;

%% sort things out for plotting 3D plots of averaged values

% set up Tp and Hs "table headers" or x-y axes
for i = 1:NsetsHs  % Significant wave height [m]
        Hs_vec(i) = tempH( iSets{i}(1) );    % just pick first Hs of each set
end

for i = 1:length(iSets)
    % note: for each value of Hs, there are several values of Tp which
    % increase monotonically (and are equally spaced), this is set up in 
    % the batch script/seaState class
    if i ==1
        Tp_vec = tempT(iSets{i});
    end
    tempTPvec = tempT( iSets{i} );
    Tp_vec = [Tp_vec, tempTPvec( find( tempTPvec > Tp_vec(end), 1 ) : end ) ];
end

% initialize matrices to populate
So_mtrx = zeros(NsetsHs, length(Tp_vec));    % matrix/table Hs \ Tp
P_mtrx = So_mtrx;
C_mtrx = So_mtrx;
s_mtrx = So_mtrx;

% populate Hs\Tp table of Eq. loads
for i = 1:NsetsHs
    
    SoRow = meanSO( iSets{i} );
    PowRow= meanPOW( iSets{i} );
    C_Row = tempC( iSets{i} );
%     s_Row = stf( iSets{i} ); % need to compute mead of std if worth it
    
    i0i = find(Tp_vec == min( tempT(iSets{i})  ));
    
    So_mtrx(i, i0i: length( tempT(iSets{i}))+i0i-1  ) = SoRow;
    P_mtrx(i, i0i: length( tempT(iSets{i}))+i0i-1  ) = PowRow;
    C_mtrx(i, i0i: length( tempT(iSets{i}))+i0i-1  ) = C_Row;    
%     s_mtrx(i, i0i: length( tempT(iSets{i}))+i0i-1  ) = s_Row;    
end

%% plots
close all
FS = 14;

% plot sea state
fsea = sea.plot('surf');

% plot DEL vs. Average Power
figName = 'DEL_pow';
LegX = 'P_a_v_g [kW]'; LegY = 'S_o [MN]'; LegC = '';
f1 = sea.post_scatter(pow, So, {figName, LegX, LegY, LegC}); 

hold on;
plot(0:spow(end)/100:spow(end), polyval(Pfit, 0:spow(end)/100:spow(end), [], MU), 'r--')
plot(0:spow(end)/100:spow(end), polyval(XBfit, 0:spow(end)/100:spow(end)), 'g--')
plot(bcX,  mbX_SO, 'bs', 'markerfacecolor', 'b'); % bin average DEL
plot([bcX; bcX], SigRange', 'b:s'); % 
% set(gca, 'yscale', 'lin'); %grid on

% plot Power
figName = '1HRAveragePower';
LegX= 'T_p [s]'; LegY= 'H_s [m]'; LegC = 'P [kW]';
of2 = sea.post_plot(Tp_vec, Hs_vec, P_mtrx, {figName, LegX, LegY, LegC} );

% % plot PTO damping
figName = 'Power take-off damping';
LegC = 'c [kg/s]';
of3 = sea.post_plot(Tp_vec, Hs_vec, C_mtrx, {figName, LegX, LegY, LegC} );
% 
% plot DEL
figName = 'DEL';
LegC = 'S_o [MN]';
of4 = sea.post_plot( Tp_vec, Hs_vec, So_mtrx, {figName, LegX, LegY, LegC} );

%% save figures
dirFig = 'C:\Users\bbarahon\Documents\Wave\OPT\docs\Report\files\figs\F3mono\';
% C:\Users\bbarahon\Documents\Wave\OPT\docs\Report\files\figs
fgHnd = [fsea, f1, of2, of3, of4];
for oo = 1:length(fgHnd)
    figure(fgHnd(oo));
    run resizePaper2PDF
    set(gca, 'fontsize', FS);
    print(fgHnd(oo), '-djpeg100', [dirFig fgHnd(oo).Name]);
        print(fgHnd(oo), '-depsc', [dirFig fgHnd(oo).Name]);
            print(fgHnd(oo), '-dpdf',[dirFig fgHnd(oo).Name]);
end

%% plot ratio of Load to Power
% TODO: figure out a more clever value to normilize, so that the different
% configurations can be compared to each other.
figName = 'Load to Power ratio - normalized by the minimum ratio found';
LegC = 'S_o / P';
of4 = sea.post_plot( Tp_vec, Hs_vec, ( So_mtrx./P_mtrx)/min( min(So_mtrx./P_mtrx) ),...
    {figName, LegX, LegY, LegC} );
% 
%% % plot DEL vs. Average Power
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
% % % fecdf = figure; AXecdf=axes('parent', fecdf);
% % % for i=1:length(ecdf)
% % %         plhndE(i) = plot(AXecdf, log10(  -log( 1- POTval{i}(:, 2)) ), ...
% % %             log10( POTval{i}(:, 1) ), 'c.'); hold on;
% % % end
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
fecdf = figure; AXecdf=axes('parent', fecdf);
for i=1:length(ecdf)
        plhndE(i) = plot(AXecdf, log10(  -log( 1- sEX99) ), ...
            log10( eF_Ex ), 'c.--'); hold on;
end
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