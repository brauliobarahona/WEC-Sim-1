% /*
%  * ----------------------------------------------------------------------------
%  * "THE BEER-WARE LICENSE" (Revision 42):
%  * <braulio barahona> wrote this file.  As long as you retain this notice you
%  * can do whatever you want with this stuff. If we meet some day, and you think
%  * this stuff is worth it, you can buy me a beer in return.   Poul-Henning Kamp
%  * ----------------------------------------------------------------------------
%  */
%
% Class to set up Sea state data (and PTO damping) for calculation of the
% power matrix for a given device

classdef SeaState   
    properties
        Hs         % Significant height [m]: average of 1/3 highest waves
        Te         % Energy period [s]
        Ta         % Average period [s], Ta = 0.711*Tp
        Tp         % Peak-period [s], Tp = 1.16*Te
        JDP        % Occurrence of Sea States, i.e. joint-probability
        % distribution of period and wave height
        JDPred     % JDP resolved to the specified Te/Hs
        Hsvec      %  Hs re-arrage for simple 'looping'
        Tevec      %  Te re-arrage for simple 'looping'
        Tavec      %  Ta re-arrage for simple 'looping'
        Tpvec      %  Tp re-arrage for simple 'looping'
        JDPvec     %  JDP re-arranged for simple 'looping'
    end
    properties (Dependent)
        %here dependent properties, if any
        
    end
    methods
        function sstt = SeaState(varargin)% class constructor sets data in object
            if nargin == 1
               % here different predefined data sets, given in the form of
               % a Table with rows from low to high Te, and columns from
               % low Hs at the top to high Hs at the bottom.
               if strcmpi(varargin{1}, 'humboldtBuoy')   % from Dallman and Neary, 2014
                   % 9 years of data from buoy NDBC 46212 
                   sstt.Hs = 0.25: 0.5: 6.75;
                   sstt.Te = 4.5: 18.5;
                   sstt.JDP = [
0.000	0.000	0.000	0.020	0.034	0.000	0.000	0.000	0.000	0.000	0.000	0.000	0.000	0.000	0.000
0.020	0.465	1.487	2.681	1.906	1.104	0.534	0.171	0.016	0.000	0.000	0.000	0.000	0.000	0.000
0.013	0.589	4.107	5.558	4.479	2.736	1.277	0.674	0.328	0.068	0.018	0.017	0.000	0.000	0.000
0.000	0.119	3.270	5.140	4.625	3.926	2.108	1.236	0.762	0.309	0.097	0.029	0.000	0.000	0.000
0.000	0.000	0.919	5.250	3.676	4.139	2.865	1.311	0.843	0.423	0.198	0.076	0.020	0.000	0.000
0.000	0.000	0.137	2.428	2.596	2.818	2.847	1.566	0.796	0.317	0.145	0.056	0.018	0.000	0.000
0.000	0.000	0.000	0.445	1.543	1.470	1.959	1.420	0.790	0.319	0.107	0.040	0.020	0.012	0.010
0.000	0.000	0.000	0.048	0.491	0.629	1.077	1.006	0.628	0.291	0.102	0.048	0.018	0.000	0.000
0.000	0.000	0.000	0.000	0.094	0.209	0.449	0.559	0.416	0.211	0.068	0.023	0.021	0.000	0.000
0.000	0.000	0.000	0.000	0.020	0.082	0.121	0.264	0.266	0.187	0.072	0.023	0.010	0.000	0.000
0.000	0.000	0.000	0.000	0.000	0.027	0.027	0.106	0.151	0.131	0.070	0.021	0.000	0.000	0.000
0.000	0.000	0.000	0.000	0.000	0.000	0.000	0.022	0.073	0.055	0.046	0.018	0.000	0.000	0.000
0.000	0.000	0.000	0.000	0.000	0.000	0.000	0.000	0.033	0.040	0.021	0.012	0.000	0.000	0.000
0.000	0.000	0.000	0.000	0.000	0.000	0.000	0.000	0.000	0.021	0.018	0.000	0.000	0.000	0.000];

               
               elseif strcmpi(varargin{1}, 'humboldtModel')   % from Dallman and Neary, 2014
                   % 10 years of data from hindcast model 
                   sstt.Hs = 0.25: 0.5: 7.25;
                   sstt.Te = 3.5: 17.5;
                   sstt.JDP = [
0	0	0	0	0	0	0	0	0	0.02	0.01	0	0	0	0
0	0	0	0	0	0	0	0	0	0.03	0.03	0.02	0	0	0
0	0	0	0	0	0	0	0	0.02	0.07	0.03	0.05	0	0	0
0	0	0	0	0	0	0	0.02	0.08	0.16	0.09	0.03	0	0	0
0	0	0	0	0	0	0	0.06	0.2	0.22	0.11	0.07	0	0	0
0	0	0	0	0	0	0.02	0.21	0.42	0.34	0.13	0.08	0.02	0	0
0	0	0	0	0	0.01	0.12	0.71	0.81	0.44	0.24	0.12	0.05	0	0
0	0	0	0	0	0.07	0.74	1.54	1.33	0.55	0.31	0.16	0.05	0.02	0
0	0	0	0	0.09	0.49	1.62	2.3	1.54	0.93	0.41	0.16	0.06	0.03	0.01
0	0	0	0.18	1.7	1.66	3.18	3.04	1.82	0.9	0.42	0.2	0.04	0.01	0
0	0	0	3.43	4.2	3.58	4.27	2.88	1.56	0.8	0.61	0.14	0.02	0	0
0	0	0.9	6.11	4.83	4.84	3.47	1.83	1.01	0.55	0.27	0.02	0	0	0
0	0.02	1.7	4.16	5.25	3.46	1.99	0.85	0.4	0.14	0.04	0.02	0	0	0
0	0.02	0.36	1.41	2.16	1.2	0.63	0.14	0.05	0.01	0	0	0	0	0
0	0	0	0	0.01	0.03	0	0	0	0	0	0	0	0	0];
                    % (!) flip matrix to form table
                    sstt.JDP = sstt.JDP( length(sstt.JDP):-1:1, : );

               elseif strcmpi(varargin{1}, 'humboldtRed') 
                   % Reduced Sea State Matrix from Yu et al., 2014
                   sstt.Hs = 0.75: 4.75;      % Hs_red
                   sstt.Te = 6.7: 2: 16.7;    % Te_red

                   sstt.JDP= [4.6,  5.4,  2.8,  1.4,  1.1,  1.3
                       7.4, 12.2, 10.0,  5.8,  3.4,  2.0
                       1.6,  7.2,  7.5,  6.3,  3.6,  2.0
                       0.1,  1.3,  2.3,  2.9,  2.3,  1.2     % Note:
                       0.0,  0.1,  0.4,  0.6,  0.9,  0.8];   % (!) sum( sum(JDP_red) ) == 1 !??
               
               elseif strcmpi(varargin{1}, 'humboldtJennifer')
                   sstt.Hs = 0.75: 0.5: 5.75;
                   sstt.Te = 4.5: 17.5;
   
                   sstt.JDP = [
   0.02	0.46	1.49	2.68	1.91	1.10	0.53	0.17	0.02	0.00	0.00	0.00	0.00	0.00
   0.01	0.59	4.11	5.56	4.48	2.74	1.28	0.67	0.33	0.07	0.02	0.02	0.00	0.00
   0.00	0.12	3.27	5.14	4.62	3.93	2.11	1.24	0.76	0.31	0.10	0.03	0.00	0.00
   0.00	0.00	0.92	5.25	3.68	4.14	2.87	1.31	0.84	0.42	0.20	0.08	0.02	0.00
   0.00	0.00	0.14	2.43	2.60	2.82	2.85	1.57	0.80	0.32	0.14	0.06	0.02	0.00
   0.00	0.00	0.00	0.45	1.54	1.47	1.96	1.42	0.79	0.32	0.11	0.04	0.02	0.01
   0.00	0.00	0.00	0.05	0.49	0.63	1.08	1.01	0.63	0.29	0.10	0.05	0.02	0.00
   0.00	0.00	0.00	0.00	0.09	0.21	0.45	0.56	0.42	0.21	0.07	0.02	0.02	0.00
   0.00	0.00	0.00	0.00	0.02	0.08	0.12	0.26	0.27	0.19	0.07	0.02	0.01	0.00
   0.00	0.00	0.00	0.00	0.00	0.03	0.03	0.11	0.15	0.13	0.07	0.02	0.00	0.00
   0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.02	0.07	0.05	0.05	0.02	0.00	0.00];                   
               
               %... here other sites/data sets
               else
                   error('The name " %s " does not correspond to a data set', varargin{1});
               end
               
               sstt.Tp = sstt.Te*1.16;
               sstt.Ta = 0.711*sstt.Tp;
               
               k=0;
               for i = 1:length(sstt.Hs)   %re-arrange to form vectors
                   for j = 1:length(sstt.Tp)
                       k = k+1;
                       sstt.Hsvec(k) = sstt.Hs(i);
                       sstt.Tevec(k) = sstt.Te(j);
                       sstt.Tavec(k) = sstt.Ta(j);
                       sstt.Tpvec(k) = sstt.Tp(j);
                       sstt.JDPvec(k) = sstt.JDP(i,j);
                   end
               end
               
            else
               % TODO: assign the arguments to each property from outside
               % " sstt = SeaState(Hs, Te, JDP, ... ) "
               %
            end
        end
        
        % Operations:

        function JDPred = interpolate(sstt, Xq, Yq)
        %  Interpolate to reduce the number of sea states, trying to keep
        %  the total occurrence close to 100%, i.e. sum(sum(JDP)) == 100
            % example:
            % Xq -> Te = [4.5: 12.5, 14, 15, 17, 18]
            % Yq -> Hs = [0.25: 0.5: 3.75, 4.5, 5.5, 6.5] 
            datint = interp2(sstt.Te, sstt.Hs, sstt.JDP, Xq, Yq);
            
            k=0;
            while  sum(sum(datint)) <= sum(sum(sstt.JDP))
                k= k+1;
                datint = datint + datint.* abs( sum( sum(datint)) - ...
                                                sum( sum(sstt.JDP)) )...
                                                 / numel(datint)/2;
                if k>=20
                    break
                end
            end
            % (!) TODO: display warinigns of previous trick
            JDPred = datint;
        end
        function varargout = set4loop(sstt, varargin)
            % Re-arrange data for easier 'looping', discard values with zero
            % ocurrence or below a given threshold
            if nargin == 2; %set threshold
                thr = varargin{1};
            else
                thr = 0;
            end
            k=0;
            for i = 1:length(sstt.Hs)
                for j = 1:length(sstt.Tp)
                    k = k+1;
                    Hs(k) = sstt.Hs(i);
                    Te(k) = sstt.Te(j);
                    Ta(k) = sstt.Ta(j);
                    Tp(k) = sstt.Tp(j);
                    JDP(k) = sstt.JDP(i,j);
                end
            end
            
            %filter out values below JDP threshold
            ix = find(JDP > thr);
            
            %set outputs up
            if nargout ==3
                varargout = {Hs(ix), Tp(ix), JDP(ix)};
            elseif nargout == 5
                varargout = {Hs(ix), Tp(ix), Te(ix), Ta(ix), JDP(ix)};
            else
                error('wrong number of outputs, this functions takes 3 or 5 outputs');
            end
            % TODO: maybe make tables for easier view/handling of data?
        end
        
        % Plot stuff
        function varargout = plot(sstt, pltflg)
            % Plot sea state percentage of occurrence, set pltflg = 'surf' 
            % to plot with surf command
            % 
            Lbls{1} = 'Sea state at Humbolt from buoy measurements'; % make this a variable
            Lbls{2} = 'T_p [s]';
            Lbls{3} = 'H_s [m]';
            Lbls{4} =  'Occurrence [%]';          
            fhnd =figure('name', Lbls{1});
            
            if strcmpi(pltflg, 'mesh')
                plthnd = mesh(sstt.Te, sstt.Hs, sstt.JDP);
                
            elseif strcmpi(pltflg, 'surf')
                % (2) surface
                plthnd = surf(sstt.Te, sstt.Hs, sstt.JDP);
                
                % TODO: ... other:
                % (3) matrix
                % get add points in the graps
                %hold on;
                %plot(sstt.Te_red(1), sstt.Hs_red(1,:), '*k')
            end
            %set color bar and view
            hcb = colorbar; axis tight; view(0,90)
            
            %legends
            xlabel( Lbls{2} ); ylabel( Lbls{3} ); hcb.Label.String = Lbls{4};
            % TODO: pimp the plots
            %
            varargout = {fhnd, plthnd, hcb};
        end
        
        function varargout = post_plot(sstt, x, y, z, varargin)
            % plot the inputs x, y, z in a 3D surface; get the plot handles
            % as output in the following order: figure, axes, plot
            
            %TODO: set style (i.e., Font, Fontsize)
            Lbls = varargin{1};
            
            %set figure up
            f = figure('name', Lbls{1});
            ax = axes('parent', f);
            
            % plot
            pltH = surf(x, y, z);
            
            %set color bar and view
            hcb = colorbar; axis tight; view(0,90)
            
            %legends
            xlabel( Lbls{2} ); ylabel( Lbls{3} ); hcb.Label.String = Lbls{4};
            
            %TODO: set fontsize
            
            % output handles
            varargout = {f, ax, pltH};
            
        end
        function varargout = post_scatter(sstt, x, y, varargin)
            % scatter plot the inputs x, y, z; get the plot handles
            % as output in the following order: figure, axes, plot

                        %TODO: set style (i.e., Font, Fontsize)
            if isempty(varargin) == 0
                Lbls = varargin{1};
            else
                Lbls = {'', '', '', ''};
            end
            
            %TODO: check that x and y have same size
            [m n] = size(x);
            
            %set figure up
            f = figure('name', Lbls{1});
            ax = axes('parent', f);

            
            % plot
            for ii= 1: n;                
                pltH(ii) = scatter(ax, x(:,ii), y(:,ii), 'co'); hold on;
            end

            %legends
            xlabel( Lbls{2} ); ylabel( Lbls{3} ); hcb.Label.String = Lbls{4};
            
            %TODO: set fontsize
            
            % output handles
            varargout = {f, ax, pltH};
        end
    end
end

% Other things TODO:
%
%  >load coefficients from X
%  >plot Sea State matrix
%  >plot Power matrix