clear all,close all,clc

secondDerivBnd = .1;

load 64a716.mat

CLmin = CL(CD==min(CD));
linPts = secondDer(alpha,CL);
p1=polyfit((CL(linPts)-CLmin).^2,CD(linPts),1);


plot((CL-CLmin).^2,CD,'-k')
hold all
plot((CL(linPts)-CLmin).^2,polyval(p1,(CL(linPts)-CLmin).^2),'--k')
%%
load 64a216.mat
CLmin = CL(CD==min(CD));
linPts = secondDer(alpha,CL);
p2=polyfit((CL(linPts)-CLmin).^2,CD(linPts),1);

plot((CL-CLmin).^2,CD,'-r')
plot((CL(linPts)-CLmin).^2,polyval(p2,(CL(linPts)-CLmin).^2),'--r')

%%
load 4412.mat

CLmin = CL(CD==min(CD));
linPts = secondDer(alpha,CL);
p3=polyfit((CL(linPts)-CLmin).^2,CD(linPts),1);

plot((CL-CLmin).^2,CD,'-b')

plot((CL(linPts)-CLmin).^2,polyval(p3,(CL(linPts)-CLmin).^2),'--b')

legend('63716','63216','4412')