clear all,close all,clc

plotFlag=false;

load XPlaneData-2-1-2013.mat


for i=2:length(Gloadaxial)-1
    X(1:3,i)=[Gloadaxial(i)-1 Gloadside(i) Gloadnorml(i)]*32.2;
    X(4:6,i)=[Prads(i) Qrads(i) Rrads(i)];
    X(7:9,i)=[Vtruemphas(i) 0 0]*5280/3600;
    X(10:12,i)=[thrst1lb(i) 0 0];
    X(13,i)=maximlb(i);
    X(14,i)=alphadeg(i)*pi/180;
    X(15,i)=betadeg(i)*pi/180;
    X(16,i)=pitchdeg(i)*pi/180;
    X(17,i)=rolldeg(i)*pi/180;
    X(18,i)=.00237*(Vtruemphas(i)*5280/3600).^2/2;
    
    [Cw(:,i)] = stateToForces2(X(:,i)');
end

figure(1)
scatter(-.005*Cw(1,:)+.06,Cw(3,:)+.39,80,'.k')
xlabel('C_D')
ylabel('C_L')

hold on

scatter(cdtotal,cltotal,80,'.b')

figure(2)
scatter(1:i,Cw(3,:)+.39);
ylabel('C_L')
hold on
scatter(1:length(cltotal),cltotal)
legend('Calc','From Sim')

figure(3)
scatter(1:i,-.005*Cw(1,:)+.06)
ylabel('C_D')
hold on
scatter(1:length(cdtotal),cdtotal)
legend('Calc','From Sim')

if plotFlag
    names={'xaccel','yaccel','zaccel','p','q','r','u','v','w','Tx','Ty','Tz',...
        'W','alpha','beta','pitch','roll','qbar'};
    for i=2:numel(names)+1
        figure(i+3)
        plot(X(i-1,:))
        title(names(i-1))
    end
end