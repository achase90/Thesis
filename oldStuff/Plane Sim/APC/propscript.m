clear all,close all,clc

v=linspace(0,200);
for i=1:length(v);
[Q_out(i),Pair(i),T(i),J_des(i),CQ_out(i),CT_out(i),CP_out(i),eta_out(i)]=propmodel('apce',19,12,v(i),4000,100);
end
[J,CT,CP,eta]=prop_data('apce',19,12);

figure(1)
plot(J_des,CP_out)
hold on
scatter(J,CP,20);
xlim([0 1]);

figure(2)
plot(J_des,CT_out)
hold on
scatter(J,CT,20);
xlim([0 1])