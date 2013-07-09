function [x_,A,alphaDot,betaDot] = alphaFun(x,in)
alpha = x(1);
beta = x(2);
V = in.V;
ax = in.ax;
ay = in.ay;
az = in.az;
p = in.p;
q = in.q;
r = in.r;
deltaT = in.deltaT;
alphaDot = (1/(V*cos(beta)))*(-ax*sin(alpha)+az*cos(alpha))+q-(p*cos(alpha)+r*sin(alpha))*tan(beta);
betaDot = (1/V)*(-ax*cos(alpha)*sin(beta) + ay*cos(beta)-az*sin(alpha)*sin(beta))+p*sin(alpha)-r*cos(alpha);

A = [ deltaT*(p*cos(alpha) - (az*cos(alpha)*sin(beta) - ax*sin(alpha)*sin(beta))/V + r*sin(alpha)), 1 - (deltaT*(ay*sin(beta) + ax*cos(alpha)*cos(beta) + az*cos(beta)*sin(alpha)))/V;
     deltaT*(p*cos(alpha) - (az*cos(alpha)*sin(beta) - ax*sin(alpha)*sin(beta))/V + r*sin(alpha)), 1 - (deltaT*(ay*sin(beta) + ax*cos(alpha)*cos(beta) + az*cos(beta)*sin(alpha)))/V];


  x_ = [alpha + deltaT*(q - tan(beta)*(p*cos(alpha) + r*sin(alpha)) + (az*cos(alpha) - ax*sin(alpha))/(V*cos(beta)));
      beta - deltaT*(r*cos(alpha) - p*sin(alpha) + (ax*cos(alpha)*sin(beta) - ay*cos(beta) + az*sin(alpha)*sin(beta))/V)];