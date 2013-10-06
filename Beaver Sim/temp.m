clear all,close all,clc

load 64a716.mat
ii=(CL>0);
CLmin = CL(CD==min(CD));

plot((CL(ii)-CLmin).^2,CD(ii),'-k')
hold all

load 64a216.mat
ii=(CL>0);
CLmin = CL(CD==min(CD));

plot((CL(ii)-CLmin).^2,CD(ii),'-r')

load 4412.mat

CLmin = CL(CD==min(CD));
ii=(CL>0);

plot((CL(ii)-CLmin).^2,CD(ii),'-b')

legend('63716','63216','4412')