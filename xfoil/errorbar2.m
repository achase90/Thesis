function [hHoriz,hVert] = errorbar2(handles,bnds)

x = handles.data.State.alphaP.data(~handles.hasThrust);
y = handles.data.State.CL.data(~handles.hasThrust);
bnds = bnds(~handles.hasThrust,:);
xBnd = [x-bnds(:,1) x+bnds(:,1)];
yBnd = [y-bnds(:,2) y+bnds(:,2)];

% open figure
% f=figure('Visbile','off');
% hold(handles.dataAxis,'on');

% plot error bars
for i=1:length(x)
    hHoriz=plot([xBnd(i,1) xBnd(i,2)],[y(i) y(i)],'r');
end

for i=1:length(y)
   hVert = plot([x(i) x(i)],[yBnd(i,1) yBnd(i,2)],'r');
end
disp('bars done')
uistack(hHoriz,'bottom');
uistack(hVert,'bottom');
% plotInGui(hObject,eventData,handles);
% hold(handles.dataAxis,'off');
