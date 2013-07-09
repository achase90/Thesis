function [CT] = HSp_CT(Nblade,AF,CLi,Minf,Jadvance,CP,CP_stall)
% Calculate thrust coefficient for a propeller at given flight condition.
%
% CT = HSp_CT(Nblade,AF,CLi,Minf,Jadvance,CP)
%
%  Will calculate the thrust coefficient (CT) for a propeller at a given
% flight condition.  The propeller model is based on the "Advanced General
% Aviation Propeller Study" (AGAP) done by Hamilton Standard in 1972 and
% published as NASA CR 2066.
%
%  The propeller is parametrically defined by Nblade, AF, and CLi.  Nblade
% is the number of blades [2, 8], AF is the activity factor per blade, and
% CLi is the integrated design lift coefficient per blade.
%
%  The flight condition is defined by Minf, Jadvance, and CP.  Minf is the
% free-stream Mach number, Jadvance is the advance ratio, and CP is the
% operating power coefficient for the prop.
%
%  One optional argument can be supplied.  CP_stall specifies the stall
% power coefficients for the propeller as calculated by:
%
% [CP_stall] = HSp_Stall(Nblade,AF,CLi,Minf,Jadvance);
%
%  If it is not specified, this routine will calculate CP_stall
% automatically.  This is the normal use of this routine.  If you are
% calculating multiple CTs for various CPs at the same (Minf, Jadvance),
% then some savings can be had by calculating the stall parameter yourself
% and passing it to this routine.
%

% Rob McDonald
% ramcdona@calpoly.edu
% Cal Poly San Luis Obispo
% 1/30/2012




%     INPUTS:
%        Nblade    : NO. OF BLADES
%        AF        : ACTIVITY FACTOR PER BLADE
%        CLi       : INTEGRATED LIFT COEFF.
%        Minf      : MACH NO.
%        Jadvance  : ADVANCE RATIO
%        CP        : POWER COEFF.
%     OUTPUT:
%        CT        : THRUST COEFF

if(numel(Minf)==1)  % If Minf is a scalar input

  % Calculate critical Mach number
  Mcr = HSp_Mcr(Jadvance,CLi);

  if(Minf < Mcr)  % Use critical Mach for any sub-critical cases.
    Minf = Mcr;
  end
  
  Minf = [Minf 1];  % Make Minf a vector as flag that this check occurred.
end


if(nargin < 7)
  [CP_stall] = HSp_Stall(Nblade,AF,CLi,Minf,Jadvance);
end

persistent CTcf firstCall;
if isempty(firstCall)
  firstCall=1;
end

x = zeros(6,1);

%  CT = P3(NOBL, AF/200,CLi, MACH, J, ZCP)
% ZCP = (CP+0.2)**.18;  ZM=Minf;  ESUM/ASUM = 0.02704

if firstCall
  CTcf =[-1.41806686,0.08663657,0.01509042,0.00043071,0.07818969,0.06585485,...
    0.00193150,1.11085284,0.01345958,-0.08098634,1.20481932,0.04723723,...
    0.00183810,0.24497673,-0.01117757,0.09118718,-0.26043856,-0.02165079,...
    -0.10491000,0.20288552,3.87672019,0.06027392,0.00064748,0.62487578,...
    -0.00726646,0.00140443,0.31940123,-0.05553865,-0.19871506,0.05981529,...
    -1.67633235,-0.08064920,-0.43464670,-0.79114026,0.52338958,0.20811565,...
    0.04764314,0.00172386,0.20113505,0.00566794,0.09084684,0.39932489,...
    0.00374315,0.01253951,-0.08949900,1.01562428,0.02340906,0.15877408,...
    0.14513716,-0.45567027,-0.01961098,0.00009677,0.00507334,-0.00174682,...
    0.10135338,-0.00531363,-0.72757202,-0.62019026,-0.03205906,-3.36648035,...
    -0.12981719,-1.39584268,-3.94156480,-0.03954630,-0.28195909,0.15452172,...
    -9.10840416,-0.02434824,-0.53461570,0.20007479,2.97368526,-1.53134644,...
    -0.09887486,-0.54787809,-0.45531923,-1.30286098,-0.00028698,9.95648670,...
    0.75258416,4.37509251,3.01637340,4.62905979,1.71611106,-8.54662418];

end
firstCall=0;

del = 0.2;
pw = 0.18;

if(CP < 0.)
  CP = 0.;
end

%MW_11/02 Modification to compute when Jadvance < 0.5
Jadvance_sv = Jadvance;
if(Jadvance < 0.5)
  Jadvance   = 0.5;
end

CP1 = 0.06;

x(1) = Nblade;
x(2) = AF./200.;
x(3) = CLi;
x(4) = Minf(1);
x(5) = Jadvance;

if(CP > CP_stall)
%  disp(' WARNING ... CP > CP_STALL ');
%  disp([' CP, CPSTALL =',num2str(CP),'  ',num2str(CP_stall)]);
  CT = nan;
  return
end

CorJ = 1.;
if(Jadvance > 2.)
  CorJ = Jadvance.*(0.092-0.023.*Jadvance) + 0.908;
end

if(CP < CP_stall)
  x(6) =(CP+del).^pw;
elseif(CP < 1.5*CP_stall) ;
  x(6) =(2.0*CP_stall-CP+del).^pw;
else
  x(6) =(CP_stall./2+del).^pw;
end

CT = poly6(CTcf,x,84,3).*CorJ;

if(Jadvance < 0.9 && CP < CP1)
  x(6) =(CP1+del).^pw;

  x1 = x(6);
  a = brkdwn(CTcf,x,6);

  y1 = polyval(a, x1);
  dy1 = polyval(polyder(a),x1);

  x0 = x1 -y1./dy1;
  if(x0 < .7485)
    x0 = 0.4*x0 + 0.6*x1;
    if(x0 < 0.01)
      x0 = 0.01;
    end
    d = x1-x0;
    a2 =(dy1 - y1./d) ./ d;
    a1 = dy1 - 2.0.*a2.*x1;
    a0 = -(a2.*x0 + a1).*x0;
    zCP =(CP+del).^pw;
    CT =(((a2.*zCP + a1).*zCP) + a0).*CorJ;
  end
end

%     CORRECTION FACTOR FOR CT IN THE REGION OF LOW J, HIGH CP
CTC = CT_corr(Jadvance, CP, CP_stall);
CT = CT.*CTC;

%MW 11/02  Continuation of Modification to compute CTVAL when J < 0.5
if(Jadvance_sv < 0.5)
  Jadvance   = Jadvance_sv;
  CTjp5 = CT;
  CTj0 = Jzero(Nblade,AF,CLi,CP);
  CT = CTj0 +(CTjp5 - CTj0).*Jadvance/0.5;
end

return
end

function [CTC]=CT_corr(Jadvance, CP, CP_stall)
%     CORRECTION FACTOR FOR CP IN THE REGION OF LOW J AND HIGH CP
%     Jadvance : ADVANCED RATIO (101.4*VKTS/(RPM*DIA)
%     CP : POWER COEFF.
%     CP_stall: STALLED CP

persistent CPvec CTCmat Jvec firstCall ; 
if isempty(firstCall)
  firstCall=1;
end;

if firstCall
  CPvec =[0.65,0.81,1.0001];
  Jvec   =[0.00,0.30,0.6001];
  CTCmat =[1.00,0.77,0.50;...
         1.00,0.87,0.77;...
         1.00,1.00,1.00];
end
firstCall=0;

CPbar = CP/CP_stall;
if(CPbar < 0.65 || Jadvance > 0.6)
  CTC = 1.;
else
  if(CPbar > 1.)
    CPbar = 1.;
  end
  CTC = interp2(CPvec,Jvec,CTCmat,CPbar,Jadvance,'linear');
end

return
end

function [CTJ0, Beta_34J0]=Jzero(Nblade,AF,CLi,cp)
% In this routine, the value of CP is an input, and it is the value at some J,which
% is between 0 and 0.5.  The value of CT at J = 0.5 has  been computed in
% subroutine CTVAL.  The value of CT at J = 0 is computed in this routine.
% The final value at the original
% value will be computed by interpolation in routine CTVAL.

persistent aaf ab342 ab344 ab346 ab348 acpe2 acpe4 acpe6 acpe8 acpee...
  acte2 acte4 acte6 acte8 actee apaf apCLi7 apCLi8 ataf atCLi7 atCLi8...
  firstCall pfCLi tfCLi; 
if isempty(firstCall)
  firstCall=1;
end

if firstCall
  % 2 BLADES J = 0
  % Figure 4A & 5A of NASA CR 114289
  acpe2=[0.020,0.030,0.050,0.075,0.100,0.150,0.200];
  ab342=[2.5,7.0,12.5,16.0,18.5,23.8,27.5];
  acte2=[0.049,0.083,0.126,0.151,0.167,0.183,0.187];
  % 4 BLADES J = 0
  % Figure 6A & 7A of NASA CR 114289
  acpe4=[0.030,0.040,0.060,0.100,0.150,0.200,0.300,0.400];
  ab344=[2.0,6.0,8.5,13.2,17.3,20.4,25.5,29.6];
  acte4=[0.064,0.110,0.157,0.210,0.260,0.292,0.328,0.340];
  % 6 BLADES J = 0
  % Figure 8A & 9A of NASA CR 114289
  acpe6=[0.045,0.050,0.060,0.075,0.100,0.200,0.300,0.400,0.550];
  ab346=[0.0,3.5,5.0,8.0,10.5,17.1,22.0,25.9,30.6];
  acte6=[0.049,0.095,0.120,0.168,0.210,0.326,0.400,0.443,0.470];
  % 8 BLADES J = 0
  % Figure 10A & 11A of NASA CR 114289
  acpe8=[0.050,0.060,0.075,0.120,0.200,0.300,0.400,0.600];
  ab348=[0.0,3.0,6.0,10.4,15.1,19.8,23.5,30.1];
  acte8=[0.054,0.093,0.140,0.230,0.326,0.415,0.472,0.539];
  
  % Figure 7 or 3A of NASA CR 114289
  % ACTIVITY FACTOR CORRECTION for J = 0
  aaf  =[80.,100.,120.,140.,160.,180.,200.];
  ataf =[1.45,1.27,1.15,1.05,0.97,0.90,0.86];
  apaf =[1.67,1.37,1.20,1.06,0.96,0.87,0.81];

  % FOLLOWING DATA FOR 4 BLADED PROP WITH CLi = 0.7 OR 0.8 only
  % FOR J = 0
  % Figure 10 or 12A of NASA CR 114289
  pfCLi=[2.6];
  tfCLi=[1.7];
  % Figure 11 or 13A of NASA CR 114289
  acpee =[0.000,0.040,0.053,0.075,0.100,0.150,0.200,0.300,0.400,0.600,0.800,1.000,1.600];
  apCLi7=[0.000,0.000,0.380,0.460,0.580,0.720,0.770,0.840,0.882,0.932,0.950,0.957,0.970];
  apCLi8=[0.000,0.000,0.000,0.160,0.370,0.580,0.660,0.750,0.803,0.880,0.929,0.957,0.970];
  % Figure 12 or 14A of NASA CR 114289
  actee =[0.000,0.030,0.038,0.050,0.070,0.100,0.150,0.200,0.300,0.400,0.480];
  atCLi7=[0.000,0.000,0.320,0.470,0.600,0.700,0.790,0.840,0.890,0.900,0.900];
  atCLi8=[0.000,0.000,0.000,0.260,0.460,0.600,0.690,0.760,0.850,0.870,0.870];
end
firstCall=0;

% Step 16 of NASA CR 114289
paf = interp1(aaf,apaf,AF,'linear','extrap');

% Step 17 which is section E steps 29-31 of NASA CR 114289
pCLi = 1.0;
if(Nblade == 4)
  cpee = cp.*paf.*pfCLi;
  if(CLi == 0.7)
    pCLi = interp1(acpee, apCLi7, cpee, 'linear', 'extrap');
  end
  if(CLi == 0.8)
    pCLi = interp1(acpee, apCLi8, cpee, 'linear', 'extrap');
  end
end

% Step 18 of NASA CR 114289
cpe = cp.*paf.*pCLi;

% Step 19 & 20 of NASA CR 114289

if(Nblade <= 8. && Nblade >= 6.)
  b348 = interp1(acpe8, ab348, cpe, 'linear', 'extrap');
  cte8 = interp1(ab348, acte8, b348, 'linear', 'extrap');

  b346 = interp1(acpe6, ab346, cpe, 'linear', 'extrap');
  cte6 = interp1(ab346, acte6, b346, 'linear', 'extrap');

  if(Nblade == 8)
    cte = cte8;
    Beta_34J0 = b348;
  end
  if(Nblade == 6)
    cte = cte6;
    Beta_34J0 = b346;
  end
  if(Nblade == 7)
    cte =(cte6 + cte8)./2.;
    Beta_34J0 =(b346 + b348)./2.;
  end  
end

if(Nblade < 6. && Nblade >= 4.)
  b346 = interp1(acpe6, ab346, cpe, 'linear', 'extrap');
  cte6 = interp1(ab346, acte6, b346, 'linear', 'extrap');
    
  b344 = interp1(acpe4, ab344, cpe, 'linear', 'extrap');
  cte4 = interp1(ab344, acte4, b344, 'linear', 'extrap');

  if(Nblade == 4)
    cte = cte4;
    Beta_34J0 = b344;
  end
  if(Nblade == 5)
    cte =(cte4 + cte6)./2.;
    Beta_34J0 =(b344 + b346)./2.;
  end
end

if(Nblade < 4. && Nblade >= 2.)
  b344 = interp1(acpe4, ab344, cpe, 'linear', 'extrap');
  cte4 = interp1(ab344, acte4, b344, 'linear', 'extrap');

  b342 = interp1(acpe2, ab342, cpe, 'linear', 'extrap');
  cte2 = interp1(ab342, acte2, b342, 'linear', 'extrap');
  
  if(Nblade == 2)
    cte = cte2;
    Beta_34J0 = b342;
  end
  if(Nblade == 3)
    cte =(cte2 + cte4)./2.;
    Beta_34J0 =(b342 + b344)./2.;
  end
end


% Step 21 of NASA CR 114289
taf = interp1(aaf, ataf, AF, 'linear', 'extrap');

% Step 22 which is steps 32-36 of NASA CR 114289

tCLi = 1.0;
ct = cte./(taf.*tCLi);
if(Nblade == 4)
  if(CLi == 0.7 || CLi == 0.8)
    
    ct = cte;
    err=1;
    kount=1;
    while(err > 0.001 && kount <=10)
      
      ctm1 = ct;
      ctee = ct.*taf.*tfCLi;
      if(CLi == 0.7)
        tCLi = interp1(actee, atCLi7, ctee, 'linear', 'extrap');
      end;
      if(CLi == 0.8)
        tCLi = interp1(actee, atCLi8, ctee, 'linear', 'extrap');
      end;
      ct = cte./(taf.*tCLi);
      err = abs((ct - ctm1)./ct);
      kount = kount + 1;
    end
  end
end

CTJ0 = ct;
return
end

function [a]=brkdwn(cof,x,indx)
% BRINGING AN N-VARIABLE POLYNOMIAL OF ORDER 3 TO A SINGLE VARIABLE CUBIC.
% COF   : COEFF. OF THE 'BIG' POLYNOMIAL
% X     : VECTOR X = (X1,X2,...,XL,...,XN) WHERE
%         X1,...,X(L-1),X(L+1),...,XN ARE FIXED
% N     : Dimension of original input 'X' vector
% indx  : Index of X to produce cubic around.  All other X(i~=indx) are
%         held constant at the input values.
% A     : COEFF. OF THE POLY. WITH RESPECT TO X(indx)

a=zeros(4,1);

x(indx) = 0.;
a(1) = poly6(cof,x,84,3);
x(indx) = 1.;
p1 = poly6(cof,x,84,3);
x(indx) = -1.;
pm1 = poly6(cof,x,84,3);
x(indx) = -2.;
pm2 = poly6(cof,x,84,3);

a(3) = (p1+pm1)./2. - a(1);
a(4) = a(3) + a(1)./2. - p1./3. - pm2./6.;
a(2) = p1 - a(3) - a(4) - a(1);

a = flipud(a);

return;
end

% Evaluate a 6-variable cubic polynomial.
function [poly6result]=poly6(a,x,n6,iormlv)

pol6 = a(n6);
i6 = 1;

for  j6 = 1:iormlv;
  n5 = n6 - i6;
  pol5 = a(n5);
  i5 = 1;
  for  j5 = 1:j6;
    n4 = n5 - i5;
    pol4 = a(n4);
    i4 = 1;
    for  j4 = 1:j5;
      n3 = n4 - i4;
      pol3 = a(n3);
      i3 = 1;
      for  j3 = 1:j4;
        n2 = n3 - i3;
        pol2 = a(n2);
        i2 = 1;
        for  j2 = 1:j3;
          n1 = n2 - i2;
          pol1 = a(n1);
          i1 = 1;
          for  j1 = 1:j2;
            pol1 = pol1 .* x(1) + a(n1-j1);
            i1 = i1 + 1;
          end
          i2 = i2 + i1;
          pol2 = pol2.*x(2) + pol1;
        end
        i3 = i3 + i2;
        pol3 = pol3.*x(3) + pol2;
      end
      i4 = i4 + i3;
      pol4 = pol4.*x(4) + pol3;
    end
    i5 = i5 + i4;
    pol5 = pol5.*x(5) + pol4;
  end
  i6 = i6 + i5;
  pol6 = pol6.*x(6) + pol5;
end
poly6result = pol6;

return
end