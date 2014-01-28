function plotErrorBars(handles)

% pass +/- data into plant

% plot on main figure
[hHoriz,hVert] = errorbar2(x,y,bnds);