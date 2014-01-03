function [z,H] = polarFun(x,u)
CD0 = x(1);
KCL = x(2);
KCL2 = x(3);
CL = u;

z = [CD0 + KCL*CL + KCL2*CL^2;
    CL];

H = [1, CL,CL^2;
    0 0 0];