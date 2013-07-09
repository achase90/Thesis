clear all,close all,clc
plotFlag=true;

load ('C:\Users\mufasa\Documents\Dropbox\Thesis\Data Logs\XPlaneData-3-5-2013.mat')
index=isfinite(Gloadaxial);
t=totltime-totltime(1);

accelVec=[Gloadaxial Gloadside Gloadnorml]';
theta=pitchdeg*pi/180;
phi=rolldeg*pi/180;
psi=hdingtrue*pi/180;
for i=1:length(psi)
    Rib(:,:,i)=[cos(theta(i))*cos(psi(i)) cos(theta(i))*sin(psi(i)) -sin(theta(i));...
        -cos(phi(i))*sin(psi(i))+sin(phi(i))*sin(theta(i))*cos(psi(i)) cos(phi(i))*cos(psi(i))+sin(phi(i))*sin(theta(i))*sin(psi(i)) sin(phi(i))*cos(theta(i));...
        sin(phi(i))*sin(psi(i))+cos(phi(i))*sin(theta(i))*cos(psi(i)) -sin(phi(i))*cos(psi(i))+cos(phi(i))*sin(theta(i))*sin(psi(i)) cos(phi(i))*cos(theta(i))];
    accelNoG(:,i)=32.2*(accelVec(:,i)-Rib(:,:,i)*[0;0;1]);
end
Vaxial=cumtrapz(t,accelNoG(1,:));
Vnorml=cumtrapz(t,accelNoG(2,:));
Vside=cumtrapz(t,accelNoG(3,:));

for i=1:length(Pds)
    X(1:3,i)=accelNoG(:,i); %Vdot
    X(4:6,i)=[Pds(i);Qds(i);Rds(i)]'*pi/180; %omega
    X(7:9,i)=[Vaxial(i) Vside(i) Vnorml(i)]'; %V
    X(10:12,i)=[thrst1lb(i) 0 0]'; %Ft
    X(13,i)=maximlb(i)-(fueltotlb(1)-fueltotlb(i)); %W
    X(14,i)=alphadeg(i)*pi/180; %alpha
    X(15,i)=betadeg(i)*pi/180; %beta
    X(16,i)=pitchdeg(i)*pi/180; %theta
    X(17,i)=rolldeg(i)*pi/180; %phi
    VtrueCalc(i)=norm(X(7:9,i));
    X(18,i)=.5*.00237*(Vtruemphas(i)*5280/3600)^2;
    X(19,i)=hdingtrue(i)*pi/180;
    
    [Cw(:,i),FAero(:,i)] = stateToForces2(X(:,i)');
end
ii=find(altftagl>20,1,'first');
% ii=1
% ii=520;
% kk=length(Gloadaxial);
kk=500;

figure(1)
scatter(ii:kk,FAero(1,ii:kk),50,'.k')
hold on
scatter(ii:kk,draglb(ii:kk),50,'.b')
xlabel('Index [-]')
ylabel('C_D [-]')
title('Drag')
legend('Crap','Xplane')

figure(2)
scatter(ii:kk,-FAero(3,ii:kk),50,'.k')
hold on
scatter(ii:kk,liftlb(ii:kk),50,'.b')
xlabel('Index [-]')
ylabel('C_L [-]')
title('Lift')
legend('Crap','Xplane')

figure(3)
scatter(FAero(1,ii:kk),-FAero(3,ii:kk),20,'k')
hold on
scatter(draglb(ii:kk),liftlb(ii:kk),20,'b')
title('Polar')
legend('Crap','Xplane')

if plotFlag
    names={'accelAxial','accelSide','accelNormal','p','q','r','Vaxial','Vside','Vnormal','Taxial','Tside','Tnormal','W','alpha','beta','theta','phi','qbar','psi'};
    [a,b]=size(X);
    for i=1:min([a,b])
        figure(i+3)
        if max(i==[4 5 6 14 15 16 17 19])
            names{i}
            X(i,ii:kk)=X(i,ii:kk)*180/pi;
        end
        plot(X(i,ii:kk))
        title(names{i})
    end
end