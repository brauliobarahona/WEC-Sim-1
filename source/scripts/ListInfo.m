% script to output to simulation settings to Command Window
% 

simu.listInfo(waves.typeNum);

waves.listInfo

fprintf('\nList of Body: ');
fprintf('Number of Bodies = %u \n',simu.numWecBodies)

for i = 1:simu.numWecBodies
    body(i).listInfo
end;  clear i

fprintf('\nList of PTO(s): ');
if (exist('pto','var') == 0)
    fprintf('No PTO in the system\n')
else
    fprintf('Number of PTOs = %G \n',length(pto(1,:)))
    for i=1:simu.numPtos
        pto(i).listInfo
    end; clear i
end

fprintf('\nList of Constraint(s): ');
if (exist('constraint','var') == 0)
    fprintf('No Constraint in the system\n')
else
    fprintf('Number of Constraints = %G \n',length(constraint(1,:)))
    for i=1:simu.numConstraints
        constraint(i).listInfo
    end; clear i
end
fprintf('\n')