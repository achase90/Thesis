function handles = updateAxesOptions(handles)
[type] = getDataType(handles);
% set the plot options box to contain the field names of that data type
set(handles.xAxisVar,'Value',1); % set to standard value so we can update string list
set(handles.yAxisVar,'Value',1);
set(handles.xAxisVar,'String',fieldnames(handles.data.(type)));
set(handles.yAxisVar,'String',fieldnames(handles.data.(type)));