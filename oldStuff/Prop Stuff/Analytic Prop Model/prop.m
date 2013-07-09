function [T,T1,T2,T3]=prop(B,c,rho,w,R,u,CL,CD)
T3=-B*c*rho/(12*w);
T1=T3*sqrt(R^2*w^2+u^2)*(3*CL*R*u*w-2*CD*(R^2*w^2+u^2));
T2=T3*3*CL*u^3*log(sqrt(R^2*w^2+u^2)+R*w);
T=T1+T2+.05;