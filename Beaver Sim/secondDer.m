function [linPts] = secondDer(alpha,CL)

delX = min(diff(alpha));

for i=2:length(alpha)-1
    jj(i) = (CL(i-1) - 2*CL(i)+CL(i+1))/delX^2;
end

linPts = jj<std(jj);
linPts = jj<.05;
ii = find(linPts<1,1,'first');
linPts(ii:length(linPts)) = 0;
