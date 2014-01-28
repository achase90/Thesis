function [e,CLa,percError] = eFunXfoil(tag,C2,C1)
if nargin<3
    C1=nan;
end

CLmin = .26;
AR = (7*12)/11.75;

if tag == 1
    K1 = .0085115;
    e = 1/(pi*AR*(C2-K1));
else
    K1 = C1/(-2*CLmin);
    e = 1/(pi*AR*(C2-K1));
end

Cla = 2*pi;
CLa = Cla/(1+(Cla/(pi*e*AR)));
percError = 100*abs(1-CLa/4.76);