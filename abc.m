%
format short
clear all
clc

%% phase 1 : Input parameters
FoodSource = 100;   % Food Sources Bees
D = 2;              % Dimension of the problem
lb = [0.02 0.02];       % Lower bound of the variables
ub = [0.02 0.02];         % Upper bound of the variables 
max_iter = 100;     % Maximum number of iteration
N = FoodSource./2;  % Population Size
limit = (N.*D)./2;     % Used for Scoutt Phase
trial=zeros(N,1);   % initialize ro zero 


%% phase 2 : defining the objective function and fitness value
%% phase 3 : generate initial population 
for i=1:N
    for j = 1:D
        pos(i,j) = lb(:,j) + rand.*(ub(:,j)-lb(:,j));
    end 
end

fx = func(pos);   %%%%%% minimize objective function
fx1 = ftns(pos);  %%%%%  maximize fitness function

%%% ABC main loop start
for iter = 1:max_iter
%%   phase 4 : employed bee phase 
for i=1:N
    Xnew = pos(i,:);       % for new solution "i" foodsource
    p2c = ceil(rand*D);     % choose the variable to change 
    partner = ceil(rand*N);    % choose the partner 
    
    while(partner==i)
        partner = ceil(rand*N);
    end
 
    X = pos(i,p2c);
    Xp = pos(partner,p2c);
    Xnew(p2c) = X + (rand-0.5).*2.*(X-Xp);
    
    
    %%%% check the bounds 
    
    for j = 1:D
        if Xnew(j)>ub(j)
            Xnew(j) = ub(j);
        elseif Xnew(j)<lb(j)
            Xnew(j) = lb(j);
        end
    end

    
    %%% perform greedy selection
       fnew = func(Xnew);
    if fnew < fx(i,:)
        pos(i,:) = Xnew;
        fx(i,:) = fnew;
        trial(i)=0;
    else
        trial(i) = trial(i) + 1;
    end
    
             
end %%% END OF THE LOOP
 

%%%% phase 5 onlocker bee phase


prob = fx./sum(fx)

for i=1:N
    if(rand<prob(i))
        Xnew = pos(i,:);
        p2c = ceil(rand*D);
        partner = ceil(rand*N);
        while(partner==i)
            partner=ceil(rand*N);
        end
        X = pos(i,p2c);
        Xp = pos(partner,p2c);
        Xnew(p2c) = X + (rand-0.5).*2.*(X-Xp);
  
    
    
    %%%% check the bounds 
    
    for j = 1:D
        if Xnew(j)>ub(j)
            Xnew(j) = ub(j);
        elseif Xnew(j)<lb(j)
            Xnew(j) = lb(j);
        end
    end

    
    %%% perform greedy selection
       fnew = func(Xnew);
    if fnew < fx(i,:)
        pos(i,:) = Xnew;
        fx(i,:) = fnew;
        trial(i)=0;
    else
        trial(i) = trial(i) + 1;
    end
    end
             
end %%% END OF THE LOOP      
      
%% memorize the best solution so far 

[fxval, fxind] = min(fx);

Gbest = pos(fxind,:);

Xbest(iter,:) = Gbest;

Fbest(iter) = fxval;

Fbest1(iter) = func(Gbest);

%%% show iteration information

disp(['Iteration ' num2str(iter) ': Best Cost = ' num2str(Fbest(iter))]);
    

%%% phase 6 : scoutt phase 

H = find(trial>limit);

if length(H)>0
    
%%%% generate poplulation randomly for such "H"
for j = 1:D
    pos(H,j) = lb(:,j) + rand.*(ub(:,j)-lb(:,j));
end 
fx(H,:)=func(pos(H,:));
end




%%%% phase 7 : plot the results 

plot(Fbest1, 'r','LineWidth', 2);
xlabel('Iteration');
ylabel('fitness Value');
grid on;

end
