clear all,close all,clc
% APCE_11X55
%
load('Props.mat');
clearvars -except APC_19X12 
Jd_19_12=APC_19X12(:,1);
CTd_19_12=APC_19X12(:,2);
CPd_19_12=APC_19X12(:,3);
etad_19_12=Jd_19_12.*(CTd_19_12./CPd_19_12);

[J_19_12,CT_19_12,CP_19_12,eta_19_12]=prop_data('apce',19,12);


markersize=200;

figure(1)
% subplot(1,3,1)
scatter(Jd_19_12,CPd_19_12,markersize,'.b','linewidth',2)
xlabel('Advance Ratio')
ylabel('Power Coefficient')
hold on
scatter(J_19_12,CP_19_12,markersize,'.g','linewidth',2)
legend('Dustin''s data','UIUC','location','southwest')
title('Power Coefficient vs. Advance Ratio for Two APCE 19x12 Props')


figure(2)
% subplot(1,3,2)
scatter(Jd_19_12,CTd_19_12,markersize,'.b','linewidth',2)
xlabel('Advance Ratio')
ylabel('Thrust Coefficient')
hold on
scatter(J_19_12,CT_19_12,markersize,'.g','linewidth',2)
legend('Dustin''s data','UIUC','location','southwest')
title('Thrust Coefficient vs. Advance Ratio for Two APCE 19x12 Props')

figure(3)
% subplot(1,3,3)
scatter(Jd_19_12,etad_19_12,markersize,'.b','linewidth',2)
xlabel('Advance Ratio')
ylabel('Efficinecy, \eta')
hold on
scatter(J_19_12,eta_19_12,markersize,'.g','linewidth',2)
legend('Dustin''s data','UIUC','location','southwest')
title('Efficiency vs. Advance Ratio for Two APCE 19x12 Props')


