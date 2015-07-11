% given a data set x, y, bin x and get basic statistics for y values in
% each bin

[N, EDGES, BIN] = histcounts(spow, 'BinMethod', 'fd');
bcX = diff(EDGES)/2 + EDGES(1:end-1);

figure;
bar(bcX, N)


for jj=1:length(N)
    mbX_SO(jj) = mean( sSo( find( BIN == jj ))  ) ;
    sigX_SO(jj) = std( sSo( find( BIN == jj ))  ) ;
end

% calculate a sort of conficence interval assuming a Gaussian distribution
up3sigSO =  3*sigX_SO./2 + mbX_SO;
low3sigSO= -3*sigX_SO./2 + mbX_SO;


% hold on;
% plot(bcX, up3sigSO, 'c-');
% plot(bcX, low3sigSO, 'c-');
