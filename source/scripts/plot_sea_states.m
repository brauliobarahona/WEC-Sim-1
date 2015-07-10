% plot sea states
%
% (!) make sure path has WEC-Sim path in
%
close all
FS = 14;
% instanciate class
seaModel = SeaState('humboldtModel');
seaBuoy = SeaState('humboldtBuoy');

% plot
fsea1 = seaModel.plot('surf');
set(gca, 'fontsize', FS)
run resizePaper2PDF.m

fsea2 = seaBuoy.plot('surf');
run resizePaper2PDF.m
set(gca, 'fontsize', FS)

T0 =9; TEnd =12; seg= 20;
H0 =4; HEnd =5.5; 
Xvec = T0: (TEnd-T0)/seg: TEnd;
Yvec = H0: (HEnd-H0)/seg: HEnd;

finerJDP = seaModel.interpolate(Xvec, Yvec');
fN = seaModel.plot('surf', Xvec, Yvec, finerJDP);
run resizePaper2PDF.m
set(gca, 'fontsize', FS); set(fN, 'Name', 'RedHumboldt')

% print figures
dirFig = 'C:\Users\bbarahon\Documents\Wave\OPT\docs\Report\files\figs\';
%fgHnd = [fsea1, fsea2, fN];
fgHnd = fN;

for oo = 1:length(fgHnd)
    print(fgHnd(oo), '-djpeg100', [dirFig fgHnd(oo).Name]);
    print(fgHnd(oo), '-depsc', [dirFig fgHnd(oo).Name]);
    print(fgHnd(oo), '-dpdf',[dirFig fgHnd(oo).Name]);
end