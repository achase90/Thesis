% http://ugastro.berkeley.edu/infrared/ir_clusters/maxlike.pdf

clear all,close all,clc
sigma=[1 1];
mu=[11 11.5];
w=1./sigma;
lsb=.001;
x=(normrnd(mu(1),sigma(1),1,10000)+normrnd(mu(2),sigma(2),1,10000))/2;

mostLikelyValue=sum(w.*mu)/sum(w)
mean(x)
xStd=std(x)
xPStd=sqrt((1/length(x))*sum((x-mean(x)).^2))

[P,x] = weightedSensors(mu,sigma);
plot(x,P)
hold all
plot([mostLikelyValue mostLikelyValue],[0 1.2*max(P)],'--k');
legend('Multi-sensor Probability','Most Likely Value')