% fatigue life
% 
% assumptions Fracture stress (Sig_f) proportional to 2*max(So)
%
% log_10 N = 14( 1- S/Sig_f )

NEQ = 10.^(14 * ( 1 - meanSO./(1.85*max(meanSO) )) ); % cycles to failure
totCycles = sum(NEQ);
HrYear = 365*24;

JDPatSS = sea.interpolate(tempT, tempH)
%get tid of NaNs
JDPatSS( find(isnan(JDPatSS) == 1) ) = 0;

% figure
% surf(tempT, tempH, JDPPatSS)

LifeC = sum(No*HrYear*JDPatSS./NEQ)


NEQ = 10.^(14 * ( 1 - meanSO/ 6.0697 ) ); % cycles to failure
totCycles = sum(NEQ);
refLifeC = sum(No*HrYear*JDPatSS./NEQ)


% %% work in progress
% vjdp = [];
% for oo = 1:11
%     vjdp = [vjdp JDPatSS'];
% end
% 
% 
% figure; scatter3(pow, So, vjdp)