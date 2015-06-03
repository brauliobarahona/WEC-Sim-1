% Post-processing routine from WecSim source modified to save just
% selected variables, reducing storage size
%
% Brsulio Barahona

% Re-arrange data save by Simulink model
% *basically it re-groups the outputs of each structure saved during the
% simulation and saves them into the "output" class
for iBod = 1:simu.numWecBodies
    eval(['body' num2str(iBod) '_out.name = body(' num2str(iBod) ').hydroData.properties.name;']);
    
    if iBod == 1; bodiesOutput = body1_out; end
    
    bodiesOutput(iBod) = eval(['body' num2str(iBod) '_out']);
    eval(['clear body' num2str(iBod) '_out'])
end; clear iBod

if exist('pto','var')
    for iPto = 1:simu.numPtos
        eval(['pto' num2str(iPto) '_out.name = pto(' num2str(iPto) ').name;'])

        if iPto == 1; ptosOutput = pto1_out; end
        ptosOutput(iPto) = eval(['pto' num2str(iPto) '_out']);
        eval(['clear pto' num2str(iPto) '_out'])
    end; clear iPto
else
    ptosOutput = 0;
end
if exist('constraint','var')
    for iCon = 1:simu.numConstraints
        eval(['constraint' num2str(iCon) '_out.name = constraint(' num2str(iCon) ').name;'])
        
        if iCon == 1; constraintsOutput = constraint1_out; end
        constraintsOutput(iCon) = eval(['constraint' num2str(iCon) '_out']);
        eval(['clear constraint' num2str(iCon) '_out'])
    end; clear iCon
else
    constraintsOutput = 0;
end

output = responseClass(bodiesOutput,ptosOutput,constraintsOutput);
clear bodiesOutput ptosOutput constraintsOutput

for iBod = 1:simu.numWecBodies    % (!) *** not sure what this is ***
    %     body(iBod).storeForceAddedMass(output.bodies(iBod).forceAddedMass)
    output.bodies(iBod).forceTotal     = output.bodies(iBod).forceTotal - output.bodies(iBod).forceAddedMass;
    output.bodies(iBod).forceAddedMass = body(iBod).forceAddedMass(output.bodies(iBod).acceleration);
    output.bodies(iBod).forceTotal     = output.bodies(iBod).forceTotal + output.bodies(iBod).forceAddedMass;
end; clear iBod

diary off;

% %save simu class
% save('simumat.mat', 'simu')
% 
% %save output structure
% save('outputmat.mat', 'output')

%save selected body or pto
ptoout = output.ptos;

save([simu.resDir '\' fn{jj} '.mat'], 'ptoout')
% %save workspace to *.mat file
% save(simu.caseFile)