clear all,close all,clc
x=linspace(1,10);
sigma=.1;

[t,y]=ode45(@odetemp,[1 10],0);
xk(1)=x(1);

% [xk,Pk]=kalmanFilter(A,C,Q,R,Pk_1,x_1)
Pk(1)=1;
for i=2:length(x)
[xk(i),Pk(i)]=kalmanFilter(2,1,1,sigma^2,Pk(i-1),xk(i-1));
end

plot(t,y,'-b')
hold on
plot(x,xk,'-r')