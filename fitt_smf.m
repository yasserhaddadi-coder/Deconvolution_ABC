c = [0.2  0.035  0.009  0.003  0.0015  0.00075 0.00042  0.00028  0.00016];
d = [1  2  3  4  5  6  7  8  9];
e = [0.05  0.05  0.05  0.05  0.05  0.05  0.05  0.05  0.05];

xlabel('alpha values')
ylabel('blur values')
plot(c,d,c,e)
xlabel('alpha values ')
ylabel('noise value')
title ('fitting function ')
legend({'d = blur','e = noise'},'Location','southeast')