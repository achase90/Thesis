function [e,CLa] = eFun(C1,C2,CLmin)
AR = (7*12)/11.75;
K1 = C1/(-2*CLmin);
e = 1/(pi*AR*(C2-K1));
Cla = 2*pi;
CLa = Cla/(1+(Cla/(pi*e*AR)));