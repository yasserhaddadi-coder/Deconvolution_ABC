c = [0.2  0.199  0.196  0.191  0.185  0.179  0.1695  0.1554  0.1415]
d = [3  3  3  3  3  3  3  3  3]
e = [0.02  0.04  0.06  0.08  0.1  0.12  0.14  0.16  0.18]

xlabel('alpha values')
ylabel('blur values')
plot(c,d,c,e)
xlabel('alpha values ')
ylabel('noise value')
title ('fitting function')
legend({'d = blur','e = blur'},'Location','southeast')