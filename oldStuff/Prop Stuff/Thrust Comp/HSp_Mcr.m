function [Mcr]=HSp_Mcr(Jadvance,CLi)
% Calculate the critical Mach number for a propeller.
%
% Mcr = HSp_Mcr(Jadvance,CLi)
%
%  Will calculate the critical Mach number for a propeller at a given flight
% condition.  The propeller model is based on the "Advanced General
% Aviation Propeller Study" (AGAP) done by Hamilton Standard in 1972 and
% published as NASA CR 2066.
%
%  This routine is generally not called by the user.  Instead, it is called
% automatically as needed by the other routines.
%
%  In the AGAP model, compressibility effects are neglected for freestream
% Mach less than the critical Mach number.  In the implementation, any
% subcritical Mach number is replaced with the critical value.
%
%  The propeller is parametrically defined by CLi, the integrated design
% lift coefficient per blade.
%
%  The flight condition is defined Jadvance, the advance ratio for the
% prop.
%

% Rob McDonald
% ramcdona@calpoly.edu
% Cal Poly San Luis Obispo
% 1/30/2012



% Curve fit to Figure 7 on p. 36 of NASA CR 114399

persistent a firstCall;
if isempty(firstCall)
  firstCall=1;
end;

x = zeros(1,2);

% MCR = P(Jadvance**0.8,CLi)   ESUM/ASUM=0.002499

if firstCall
  a =[-.05289614,.38531297,.02091774,-.02177725,.00427817,-.14699991,...
    .01593769,.04508579,-.00111930,-.03143124];  
end
firstCall=0;

x(1) = 0.;
if(Jadvance > 0.)
  x(1) = Jadvance.^0.8;
end;
x(2) = CLi;

% Find one-d cubic which varies only in x(1) dimension.
a1d = brkdwn(a,x,1);
x1=x(1);

% Evaluate one-d cubic - and its derivative
Mcr = polyval(a1d, x1);
dMcr = polyval(polyder(a1d),x1);

% If slope is negative
if(dMcr < 0 )
  % Use roots to solve for location of maximum of curve.  
  r = roots(polyder(a1d));
  xmx = r(1);
  % Find function value at maximum.
  Mcr = polyval(a1d, xmx);
end

if(Mcr < 0.)
  Mcr = 0.;
end

return
end %function Mcrach

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
a(1) = poly2(cof,x,10,3);
x(indx) = 1.;
p1 = poly2(cof,x,10,3);
x(indx) = -1.;
pm1 = poly2(cof,x,10,3);
x(indx) = -2.;
pm2 = poly2(cof,x,10,3);

a(3) = (p1+pm1)./2. - a(1);
a(4) = a(3) + a(1)./2. - p1./3. - pm2./6.;
a(2) = p1 - a(3) - a(4) - a(1);

a=flipud(a);

return;
end

function [poly2result]=poly2(a,x,n2,iormlv)

pol2 = a(n2);
i2 = 1;

for  j2 = 1:iormlv;
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

poly2result = pol2;

return
end


