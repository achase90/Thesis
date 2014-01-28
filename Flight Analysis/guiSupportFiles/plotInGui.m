function [handles] = plotInGui(hObject,eventdata,handles)
[type] = getDataType(handles);
[xAxis,yAxis,xUnit,yUnit] = getAxisNames(handles);
xIsNumeric = isnumeric(handles.data.(type).(xAxis).data);
yIsNumeric = isnumeric(handles.data.(type).(yAxis).data);
if xIsNumeric && yIsNumeric
    if length(handles.data.(type).(xAxis).data) ~= length(handles.data.(type).(yAxis).data)
        set(handles.outputText,'String',['Plot vectors must be the same length. HINT: GPS signals can only be plotted against other GPS signals.']);
    else
        xPlotVar = handles.data.(type).(xAxis).data;
        yPlotVar = handles.data.(type).(yAxis).data;
        %todo:switch to scatter (for some? strip charts are vs time, so
        %maybe all as scatters are fine)
        if get(handles.ignoreThrust,'Value'); %check if we're ignore data with thrust
            TFHasThrust = handles.hasThrust;
            if max(TFHasThrust) %if there's some data without thrust
%                xPlotVar(TFHasThrust) = nan;
               yPlotVar(TFHasThrust) = nan;
            else
                cla(handles.dataAxis);
                set(handles.outputText,'string','All data has thrust. Please deselct "Ignore data with thrust" and plot again.')
            end
        end
        if strcmpi(xAxis,'time')
            plot(handles.dataAxis,xPlotVar,yPlotVar)
        else
            scatter(handles.dataAxis,xPlotVar,yPlotVar,25,'.')
        end
        set(handles.outputText,'String','');
        ylabel(handles.dataAxis,[yAxis ' [' yUnit ']']);
        xlabel(handles.dataAxis,[xAxis ' [' xUnit ']']);
        box(handles.dataAxis,'on');
    end
else
    if ~xIsNumeric
        set(handles.outputText,'String',['Variable ''' xAxis ''' is not numeric. Please choose a numeric variable to plot.']);
    end
    if ~yIsNumeric
        set(handles.outputText,'String',['Variable ''' yAxis ''' is not numeric. Please choose a numeric variable to plot.']);
    end
end