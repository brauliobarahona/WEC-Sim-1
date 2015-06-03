% Script to set up file names on the basis of the simulation parameters
% that were used.
%
% Braulio Barahona
%

% save the results here
saveDIR = 'res'; % directory to save output
saveName= ['TS_' simu.simMechanicsFile(1:end-4) '_']; %
if exist(saveDIR,'dir')==0
    mkdir(saveDIR);
end

% make file names
fn=strcat('dt',num2str(simu.dt),'_wH',num2str(waves.H),'_wT',num2str(waves.T),'_',...
       waves.type,'_zo', ...
       '_lDsurge',num2str(body(2).hydroForce.fDamping(1,1)),...
       '_lDheave',num2str(body(2).hydroForce.fDamping(3,3)),...
       '_vDsurge',num2str(body(2).hydroForce.visDrag(1,1)),...
       '_vDheave',num2str(body(2).hydroForce.visDrag(3,3)),...
       '_mKsurge',num2str(body(2).mooring.k(1,1)),...
       '_mKheave',num2str(body(2).mooring.k(3,3)));

% save selected variables, structures   
save([saveDIR '\' saveName fn '.mat'],'body2_out','pto1_out','simu','waves');