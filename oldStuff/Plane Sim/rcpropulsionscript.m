clear all,close all,clc

in.prop='apce';
in.diam=11;
in.pitch=8.5;
in.V=10;
in.Kv=870;
in.Ri=.03;
in.I0=2.4;

% h=300;
v=linspace(0,100,20);
% v=50;
h=linspace(0,500,20);
V=linspace(0,20,20);
numCalcs=(length(h)*length(v)*length(V));
% tic
iter=0;
for i=1:length(v)
    for j=1:length(h)
        for k=1:length(V)
            iter=iter+1;
            [Tprop(i,j,k),QProp(i,j,k),QMotor(i,j,k),PMotor(i,j,k),PProp(i,j,k),PReq(i,j,k),etaTotal(i,j,k),etaMotor(i,j,k),etaProp(i,j,k),CT(i,j,k),CP(i,j,k),J(i,j,k),omega_match(i,j,k),Imotor(i,j,k)]=rcpropulsion(in.prop,in.diam,in.pitch,v(i),h(j),in.V,in.Kv,in.Ri,in.I0);
            fprintf('percent finished = %9.6f\n',100*iter/numCalcs);
        end
    end
end
save APCE11x8.5TableLookup.mat;

% toc
% plot(J,Tprop,'-k','linewidth',2)
% xlabel('Advance Ratio [ ]')
% ylabel('Thrust [lbf]')
%
% figure(2)
% plot(J,Imotor,'-k','linewidth',2)
% ylabel('Current [ ]')
% xlabel('Advance Ratio [ ]')
%
% figure(3)
% plot(J,PMotor,'-k','linewidth',2)
% xlabel('Advance Ratio [ ]')
% ylabel('Power Required [Watts]')