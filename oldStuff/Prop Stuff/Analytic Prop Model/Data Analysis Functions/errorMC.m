clear all,close all,clc

nPts=1000;
plotStates=false;
for i=1:nPts
    X(:,i)=randState();
    Cw(:,i) = stateToForces2(X(:,i)');
end

h1=scatter(Cw(1,:),Cw(3,:))
xlabel('C_D')
ylabel('C_L')
title('I''m so fucked')

%% State plots
% Vdot=X(1:3);
% omega=X(4:6);
% V=X(7:9);
% Ft=X(10:12);
% W=X(13);
% alpha=X(14);
% beta=X(15);
% theta=X(16);
% phi=X(17);
% qbar=X(18);

if plotStates
    titleVec={'udot','vdot','wdot','p','q','r','u','v','w','Tx',...
        'Ty','Tz','W','alpha','beta','theta','phi','qbar'};
    for i=2:min(size(X))+1
        figure(i)
        plot(X(i-1,:))
        title(titleVec(i-1))
    end
end