function [CP_stall,CT_stall] = HSp_Stall(Nblade,AF,CLi,Minf,Jadvance)
% Calculate stall power and thrust  coefficient for a propeller.
%
% [CP_stall,CT_stall] = HSp_Stall(Nblade,AF,CLi,Minf,Jadvance)
%
%  Will calculate the stall power and thrust coefficients (CP_stall and 
% CT_stall) for a propeller at a given flight condition.  The propeller
% model is based on the "Advanced General Aviation Propeller Study" (AGAP)
% done by Hamilton Standard in 1972 and published as NASA CR 2066.
%
%  This routine is generally not called by the user.  Instead, it is called
% automatically as needed by the other routines.
%
%  The propeller is parametrically defined by Nblade, AF, and CLi.  Nblade
% is the number of blades [2, 8], AF is the activity factor per blade, and
% CLi is the integrated design lift coefficient per blade.
%
%  The flight condition is defined by Minf, Jadvance.  Minf is the
% free-stream Mach number and Jadvance is the advance ratio.
%

% Rob McDonald
% ramcdona@calpoly.edu
% Cal Poly San Luis Obispo
% 1/30/2012

if(numel(Minf)==1)  % If Minf is a scalar input

  % Calculate critical Mach number
  Mcr = HSp_Mcr(Jadvance,CLi);

  if(Minf < Mcr)  % Use critical Mach for any sub-critical cases.
    Minf = Mcr;
  end
  
  Minf = [Minf 1];  % Make Minf a vector as flag that this check occurred.
end


persistent cpscf firstCall;
if isempty(firstCall)
  firstCall=1;
end

y=zeros(4,1);

% CPSTALL = P4(NOBL,AF/200,CLi,J)

if firstCall
  cpscf =[0.75612652,-0.05536399,0.00364504,0.00012694,-3.92775106,...
    0.30555817,-0.01036619,5.19638729,-0.12897339,-2.06084776,1.28912926,...
    -0.07387567,-0.00163292,-0.34751567,0.05832902,-0.18199238,-1.75580311,...
    0.05230720,0.33273822,0.80694747,-0.38241610,0.06059375,-0.00651502,...
    0.24951375,0.10708075,-0.40481636,-0.51293731,0.03608797,0.22143866,...
    0.21759184,0.25319618,0.00870825,0.09358047,0.05130337,-0.06243081];
end
firstCall=0;

y(1) = Nblade;
y(2) = AF./200.;
y(3) = CLi;
y(4) = Jadvance;

CP_stall = poly4(cpscf,y,35,3);

if(CP_stall < 0.001)
  CP_stall = 0.001;
end;

[CT_stall] = HSp_CT(Nblade,AF,CLi,Minf,Jadvance,CP_stall,CP_stall);

return;
end

% Evaluate a 4-variable cubic polynomial.
function [poly4result]=poly4(a,x,n4,iormlv)

pol4 = a(n4);
i4 = 1;

for  j4 = 1:iormlv;
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
poly4result = pol4;

return;
end
