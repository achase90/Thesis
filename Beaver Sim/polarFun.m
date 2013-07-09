function [z,H] = polarFun(x,u)
CD0 = x(1);
KCL2 = x(2);
CL = u;

z = [CD0 + KCL2*CL^2;
    CL];

H = [1, CL^2;
    0 0];