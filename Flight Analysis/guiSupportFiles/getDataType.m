function [type] = getDataType(handles)

    plotDataTypeName = get(handles.plotDataType,'String');
    type = char(plotDataTypeName(get(handles.plotDataType,'Value')));