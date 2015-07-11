% /*
%  * ----------------------------------------------------------------------------
%  * "THE BEER-WARE LICENSE" (Revision 42):
%  * <braulio barahona> wrote this file.  As long as you retain this notice you
%  * can do whatever you want with this stuff. If we meet some day, and you think
%  * this stuff is worth it, you can buy me a beer in return.   Poul-Henning Kamp
%  * ----------------------------------------------------------------------------
%  */
% 
% Script to re-size paper and reposition to kill pdf white space
%
factor = 1.05; %(!) this one I guess with a couple iterations

% set units of figure and paper to aviod a mess
set(gcf, 'units', 'centimeters')
set(gcf, 'paperunits', 'centimeters')
%set(gca, 'units', 'centimeters')
%set(gca, 'dataAspectRatio', [1 20 1])
%set(gca, 'PlotBoxAspectRatio', [1 20 1])


% get figure position to guess size of figure
fpos = get(gcf, 'position');
set(gcf, 'papersize', fpos(3:4)*factor)
set(gcf, 'paperposition', [(factor-1)/2 * fpos(3), (factor-1)/2 * fpos(4) , fpos(3:4)])
% set(gcf, 'paperorientation', 'landscape')