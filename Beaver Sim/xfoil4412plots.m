clear all,close all,clc
% set(0,'defaulttextinterpreter','latex')
load xfoil4412.mat

ii = alpha<12 & alpha > 0;
CLmin = CL(CD == min(CD)); 

p1 = polyfit((CL(ii)-CLmin).^2,CD(ii),1);

CDvisc = polyval(p1,(CL(ii)-CLmin).^2);
% 
% figure(1)
% plot(alpha,CL,'-k','linewidth',1.5)
% xlabel('$\alpha$')
% ylabel('$C_l$')
% 
% figure(2)
% plot(CD,CL,'-k','linewidth',1.5)
% xlabel('$C_d$')
% ylabel('$C_l$')

figure(3)
plot((CL-CLmin).^2,CD,'-k','linewidth',1.5)
hold on
plot((CL(ii)-CLmin).^2,CDvisc,'--r','linewidth',1.5)
str=sprintf('$K_1 = %s$',num2str(p1(1)));
text(0.45,0.025,str)
legend('Actual','Linear Fit','location','northwest')

xlabel('$(C_l - C_{l_{MIN}})^2$')
ylabel('$C_d$')
