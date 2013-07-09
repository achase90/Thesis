function [xdot]=plant(x)
u=x(1);
v=x(2);
w=x(3);
phi=x(4);
theta=x(5);
alpha=x(6);
beta=x(7);
ax=x(8);
ay=x(9);
az=x(10);
p=x(11);
q=x(12);
r=x(13);
V=norm(x(4:6));

g=32.2;

udot=r*v-q*w+ax-g*sind(theta);
vdot=p*w-r*u+ay+g*cosd(theta)*sind(phi);
wdot=q*u-p*v+az+g*cosd(theta)*cosd(phi);
Vdot=(ax*cosd(alpha)+az*sind(alpha))*cosd(beta)+ay*sind(beta)+g*(cosd(theta)*...
    cosd(phi)*sind(alpha)*cosd(beta)+cosd(theta)*sind(phi)*sind(beta)-sind(theta)*...
    cosd(alpha)*cosd(beta));
alphadot=(1/(V*cosd(beta)))*(az*cosd(alpha)-ax*sind(alpha)+g*(cosd(theta)*...
    cosd(phi)*cosd(alpha)+sind(theta)*sind(alpha)))+q-tand(beta)*(p*cosd(alpha)...
    +r*sind(alpha));
betadot=(1/V)*(ay*cosd(beta)-(ax*cosd(alpha)+az*sind(alpha))*sind(beta)+g*...
    (cosd(theta)*sind(phi)*cosd(beta)+(sind(theta)*cosd(alpha)-cosd(theta)*...
    cosd(phi)*sind(alpha))*sind(beta)))+p*sind(alpha)-r*cosd(alpha);

phidot=p+tand(theta)*(q*sind(phi)+r*cosd(phi));

thetadot=q*cosd(phi)-r*sind(phi);

xdot=[udot vdot wdot Vdot alphadot betadot phidot thetadot];