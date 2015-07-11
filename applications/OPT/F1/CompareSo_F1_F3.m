% compare stufff


save('..\fromF3.mat', 'spow', 'MU') 


save('..\fromF1.mat', 'spow', 'MU') 

load('fromF1.mat')
Pn = 500;
SoN =  polyval(Pfit, Pn, [], MU)
figure;
plot( (0:spow(end)*1.2/100:spow(end)*1.2) / Pn, ...
    polyval(Pfit, 0:spow(end)*1.2/100:spow(end)*1.2, [], MU) ./SoN, 'k--')

load('fromF3.mat')
SoN =  polyval(Pfit, Pn, [], MU)
hold on
plot( (0:spow(end)*1.2/100:spow(end)*1.2) / Pn, ...
    (polyval(Pfit, 0:spow(end)*1.2/100:spow(end)*1.2, [], MU) )/SoN, 'b--')
% set(gca,'yscale','log')
set(gca,'Fontsize',14); grid on;
xlabel('P/P_n'); ylabel('S_o / S_o_N')
legend('Float 1 - monopile', 'Float 3 - monopile')
legend('location','se')
legend boxoff

run resizePaper2PDF.m
dirF = 'C:\Users\bbarahon\Documents\Wave\OPT\docs\Report\files\figs\';
print(gcf,'-dpdf',[dirF 'DELcomp']); 