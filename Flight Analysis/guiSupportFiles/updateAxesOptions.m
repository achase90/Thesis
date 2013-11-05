function handles = updateAxesOptions(handles)
[type] = getDataType(handles);
    % set the plot options box to contain the field names of that data type
    set(handles.xAxisVar,'String',fieldnames(handles.data.(type)));
    set(handles.yAxisVar,'String',fieldnames(handles.data.(type)));