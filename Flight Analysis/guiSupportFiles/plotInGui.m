function plotInGui(hObject,eventdata,handles)
[xAxis,yAxis,xUnit,yUnit] = getAxisNames(handles);
xIsNumeric = isnumeric(handles.data.(xAxis).data);
yIsNumeric = isnumeric(handles.data.(yAxis).data);
if xIsNumeric && yIsNumeric
    if length(handles.data.(xAxis).data) ~= length(handles.data.(yAxis).data)
        set(handles.outputText,'String',['Plot vectors must be the same length. HINT: GPS signals can only be plotted against other GPS signals.']);
    else
        %todo:switch to scatter (for some? strip charts are vs time, so
        %maybe all as scatters are fine)
        if get(handles.ignoreThrust,'Value'); %check if we're ignore data with thrust
            plot(handles.dataAxis,handles.data.(xAxis).data(handles.data.hasThrust.data),handles.data.(yAxis).data(handles.data.hasThrust.data))            
        else
            plot(handles.dataAxis,handles.data.(xAxis).data,handles.data.(yAxis).data)
        end
        ylabel(handles.dataAxis,[yAxis ' [' yUnit ']']);
        xlabel(handles.dataAxis,[xAxis ' [' xUnit ']']);
        set(handles.outputText,'String','');
        set(handles.dataAxis,'YColor',[1 1 1],'XColor',[1 1 1]);
    end
else
    if ~xIsNumeric
        set(handles.outputText,'String',['Variable ''' xAxis ''' is not numeric. Please choose a numeric variable to plot.']);
    end
    if ~yIsNumeric
        set(handles.outputText,'String',['Variable ''' yAxis ''' is not numeric. Please choose a numeric variable to plot.']);
    end
end