function [xAxis,yAxis,xUnit,yUnit] = getAxisNames(handles)
    [type] = getDataType(handles);
    
    xAxisVarName = get(handles.xAxisVar,'String');
    xAxis = char(xAxisVarName(get(handles.xAxisVar,'Value')));
    xUnit = handles.data.(type).(xAxis).units;

    yAxisVarName = get(handles.yAxisVar,'String');
    yAxis = char(yAxisVarName(get(handles.yAxisVar,'Value')));
    yUnit = handles.data.(type).(yAxis).units;