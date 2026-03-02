%%% calculate fitness
function out = ftns(X)


x1 = X(:,1);
x2 = X(:,2);      
fx = 0.2092-2.192.*sin(0.2498.*pi.*x1.*x2)+0.7365.*exp(-(0.738.*x2).^2);

for i=1:size(fx,1)
    if fx(i,:)>=0
        fit(i,:) = 1./(1+fx(i,:));
    elseif fx(i,:)<0
        fit(i,:) = 1+abs(fx(i,:));
    end 
    
end

out = fit;



