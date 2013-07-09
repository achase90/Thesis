function [hHoriz,hVert,hPoints] = errorbar2(x,y,bnds)


xBnd = [x-bnds(:,1) x+bnds(:,1)];
yBnd = [y-bnds(:,2) y+bnds(:,2)];

% tYTop = [x-.02*yBnd(:,1) x+.02*yBnd(];

% open figure
f=figure;
% xlim([-.2 2.2])
% ylim([-.2 2.2])

hold on

% plot points
% plot error bars
for i=1:length(x)
    hHoriz=plot([xBnd(i,1) xBnd(i,2)],[y(i) y(i)]);
end

for i=1:length(y)
   hVert = plot([x(i) x(i)],[yBnd(i,1) yBnd(i,2)]);
end
disp('bars done')

hPoints = scatter(x,y,100,'.g');
% set(hPoints,'CData',[0 1 0]);
disp('plot done')

% % plot top "T"
% for i=1:length(y)
%    plot([x+.02*norm(yBnd(i,:)) x-.02*norm(yBnd(i,:))],[yBnd(i,2) yBnd(i,2)]) 
% end
% % plot bottom "T"
% for i=1:length(y)
%    plot([x+.02*norm(yBnd(i,:)) x-.02*norm(yBnd(i,:))],[yBnd(i,1) yBnd(i,1)]) 
% end
% disp(' y t''s done')
% % plot left "T"
% for i=1:length(y)
%    plot([xBnd(i,1) xBnd(i,1)],[y+.02*norm(xBnd(i,:)) y-.02*norm(xBnd(i,:))]) 
% end
% % plot right "T"
% for i=1:length(y)
%    plot([xBnd(i,2) xBnd(i,2)],[y+.02*norm(xBnd(i,:)) y-.02*norm(xBnd(i,:))]) 
% end