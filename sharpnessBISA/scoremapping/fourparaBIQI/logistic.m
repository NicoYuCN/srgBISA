function yhat = logistic(bayta,X)

bayta1 = bayta(1); 
bayta2 = bayta(2); 
bayta3 = bayta(3); 
bayta4 = bayta(4);
% bayta5 = bayta(5);
%disp(size((1+exp((X-bayta3)/bayta4))));
yhat=(bayta1-bayta2)./(1+exp((X-bayta3)/bayta4))+bayta2;

return;