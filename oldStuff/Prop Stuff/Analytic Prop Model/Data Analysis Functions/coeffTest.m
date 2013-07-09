clear all,close all,clc


x=linspace(0,10);
c1=4;
c2=1;
randVal=2;
for i=1:10000
    y=c1*x+c2+randVal*rand(size(x))-randVal*rand(size(x));
    %%
    A=[x' ones(size(x'))];
    
    u=A\y';
    coeffError(:,i)=u-[c1;c2];
    error=A*u-y';

errorStd=std(error);

errorVar=errorStd^2;

varU1=errorVar/(sum((x-mean(x)).^2))
varU2=errorVar*sum(x.^2)/(length(x)*sum((x-mean(x)).^2))
end
%%
% figure(1)
% plot(x,y,'-b','linewidth',2)
% hold all
% plot(x,A*u,'-r','linewidth',2)

figure(1)
scatter(1:i,coeffError(1,:)/c1)

figure(2)
scatter(1:i,coeffError(2,:)/c2)