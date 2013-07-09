function [CP]=HSp_CP_fixed(Nblade,AF,CLi,Jadvance,Beta34)
% Calculate power coefficient for a propeller at given flight condition.
%
% CP = HSp_CP_fixed(Nblade,AF,CLi,Jadvance,Beta34)
%
%  Will calculate the power coefficient (CP) for a propeller at a given
% flight condition.  The propeller model is based on the "Advanced General
% Aviation Propeller Study" (AGAP) done by Hamilton Standard in 1972 and
% published as NASA CR 2066.
%
%  The propeller is parametrically defined by Nblade, AF, and CLi.  Nblade
% is the number of blades [2, 8], AF is the activity factor per blade, and
% CLi is the integrated design lift coefficient per blade.
%
%  The flight condition is defined by Jadvance and Beta34.  Jadvance is the
% advance ratio and Beta34 is the blade angle at 3/4 of the radius.
%

% Rob McDonald
% ramcdona@calpoly.edu
% Cal Poly San Luis Obispo
% 1/30/2012



persistent cpcfx firstCall iormlv;
if isempty(firstCall)
  firstCall=1;
end

x=zeros(1,5); 

% CP = P(NOBL,AF/200,CLi,J,[Beta34/50]^2)
% IORD = (1,1,1,3,4);  ESUM/ASUM = 0.024663

if firstCall
  iormlv =[1,1,1,3,4];
  cpcfx =[0.02891479,-0.01548752,-0.05478436,0.01317444,0.00101040,...
    0.00979109,0.02825860,0.02252849,0.03846985,-0.01252934,-0.10495581,...
    0.01550890,-0.06695641,0.04121517,0.12856273,-0.03956742,-0.16212913,...
    0.04334040,0.24210414,-0.05305049,0.19764100,-0.05661761,-0.18501881,...
    0.15464291,-0.00011129,-0.01851137,-0.32720959,-0.12474918,0.13758627,...
    0.56557506,0.03545899,-0.01175858,-0.04777819,-0.21296591,0.13340412,...
    0.66700757,-0.30502900,-1.24366903,0.14770932,-0.65529239,0.26926908,...
    0.93386036,-1.03330982,-0.01662993,-0.02168856,2.03018785,0.03664399,...
    -0.53093201,0.26981807,0.87334204,-0.01534003,0.55450541,-0.28938776,...
    -1.01803684,2.26120901,0.14798689,0.52186006,-4.21891737,-0.14384417,...
    -1.60737467,-0.14875686,-0.52768224,2.93629718,0.07385901,0.07256654];
end
firstCall=0;

x(1) = Nblade;
x(2) = AF./200.;
x(3) = CLi;
x(4) = Jadvance;
x(5) = (Beta34./50.).^2.0;

CP = polval(cpcfx,65,x,5,iormlv);

return
end

function [polvalresult]=polval(a,nc,xin,nv,iord)
%*******************************************************
%     This function evaluates polynomial               *
%  P(X1, X2, ..., Xn) n can be any integer from 1 to 6 *
%     A      : Array of the polynomial coefficients.   *
%     NC     : Number of coefficients (size of A.)     *
%     XIN    : X = (X1,X2,...,Xnv) vector variable.    *
%     NV     : Number of variables.                    *
%     IORD   : IORD = (I1, I2,..., Inv) where Ij is    *
%              order of Xj                             *
%              I1 <= I2 <= ... <= Inv.                 *
%*******************************************************
%      DOUBLEPRECISION A(84)

x=zeros(1,6); 

iormlv=zeros(1,6);

j = 1;

for  i = 6-nv+1:6;
  iormlv(i) = iord(j);
  x(i) = xin(j);
  j = j + 1;
end

n = nc;
p6 = a(n);
n = n-1;
for  j6 = 1:iormlv(6);
  if(j6 > iormlv(5))
    p5 = 0.;
    jj6 = j6-iormlv(5);
  else
    p5 = a(n);
    n = n-1;
    jj6 = 1;
  end
  for  j5 = jj6:j6;
    if(j5 > iormlv(4))
      p4 = 0.;
      jj5 = j5-iormlv(4);
    else
      p4 = a(n);
      n = n-1;
      jj5 = 1;
    end
    for  j4 = jj5:j5;
      if(j4 > iormlv(3))
        p3 = 0.;
        jj4 = j4-iormlv(3);
      else
        p3 = a(n);
        n = n-1;
        jj4 = 1;
      end
      for  j3 = jj4:j4;
        if(j3 > iormlv(2))
          p2 = 0.;
          jj3 = j3-iormlv(2);
        else
          p2 = a(n);
          n= n-1;
          jj3 = 1;
        end
        for  j2 = jj3:j3;
          p1 = a(n);
          n = n-1;
          jj2 = j2;
          if(j2 > iormlv(1))
            jj2 = iormlv(1);
          end
          for  j1 = 1:jj2;
            p1 = p1 .* x(1) + a(n);
            n = n-1;
          end
          p2 = p2.*x(2) + p1;
        end
        p3 = p3.*x(3) + p2;
      end
      p4 = p4.*x(4) + p3;
    end
    p5 = p5.*x(5) + p4;
  end
  p6 = p6.*x(6) + p5;
end
polvalresult = p6;

return
end