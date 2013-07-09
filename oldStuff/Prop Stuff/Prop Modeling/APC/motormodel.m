function [Qshaft,Pshaft,eta]=motormodel(V,omega,Kv,Ri,I0)

Qshaft=((V-omega/Kv)*(1/Ri)-I0)*(1/Kv);
Pshaft=((V-omega/Kv)*(1/Ri)-I0)*(omega/Kv);
eta=(1-(I0*Ri/(V-omega/Kv))*(omega/(V*Kv));