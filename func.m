%%% calculate fitness
function out = func(X)

 x1=X(:,1);
out = -0.01488*(sin(x1-pi))+2.2e-5*((x1-10).^2)-0.03428;