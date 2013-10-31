function plotInGui(hObject,eventdata,handles)
[type] = getDataType(handles);
[xAxis,yAxis,xUnit,yUnit] = getAxisNames(handles);
xIsNumeric = isnumeric(handles.data.(type).(xAxis).data);
yIsNumeric = isnumeric(handles.data.(type).(yAxis).data);
if xIsNumeric && yIsNumeric
    if length(handles.data.(type).(xAxis).data) ~= length(handles.data.(type).(yAxis).data)
        set(handles.outputText,'String',['Plot vectors must be the same length. HINT: GPS signals can only be plotted against other GPS signals.']);
    else
        %todo:switch to scatter (for some? strip charts are vs time, so
        %maybe all as scatters are fine)
        if get(handles.ignoreThrust,'Value'); %check if we're ignore data with thrust
            TFHasThrust = handles.hasThrust;
            plot(handles.dataAxis,handles.data.(type).(xAxis).data(TFHasThrust),handles.data.(type).(yAxis).data(TFHasThrust))            
        else
            plot(handles.dataAxis,handles.data.(type).(xAxis).data,handles.data.(type).(yAxis).data)
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