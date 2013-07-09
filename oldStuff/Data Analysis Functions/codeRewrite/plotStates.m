function plotStates(state)
warning off
fieldnames=fields(state);
for i=1:numel(fieldnames);
    if ~strcmp(fieldnames(i),'time')
        f=figure;
        plot(state.time,state.(fieldnames{i}))
        title(fieldnames{i})
        legend('First','Second','Third');
        set(f,'name',(fieldnames{i}),'numbertitle','off');
    end
end
warning on