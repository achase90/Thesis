function handles = quadraticFitFun(handles)

    if handles.xAxisDefined && handles.yAxisDefined
        [xAxis,yAxis] = getAxisNames(handles);
        xIsNumeric = isnumeric(handles.data.(xAxis).data);
        yIsNumeric = isnumeric(handles.data.(yAxis).data);
        if length(handles.data.(xAxis).data) ~= length(handles.data.(yAxis).data)
            set(handles.quadFormula,'String','Vectors must be the same length.','Foregroundcolor',[1 1 1]);
        elseif ~xIsNumeric
            set(handles.quadFormula,'String',['Variable ''' xAxis ''' is not numeric.'],'Foregroundcolor',[1 1 1]);
        elseif ~yIsNumeric
            set(handles.quadFormula,'String',['Variable ''' yAxis ''' is not numeric.'],'Foregroundcolor',[1 1 1]);
        else
            [xAxis,yAxis] = getAxisNames(handles);
            xData = double(handles.data.(xAxis).data);
            yData = double(handles.data.(yAxis).data);
            if get(handles.ignoreThrust,'Value')
                p1 = polyfit(xData(handles.data.hasThrust.data),yData(handles.data.hasThrust.data),2);
                xVec = linspace(min(xData(handles.data.hasThrust.data)),max(xData(handles.data.hasThrust.data)));
            else
                p1 = polyfit(xData,yData,2);
                xVec = linspace(min(xData),max(xData));
            end
            yVec = polyval(p1,xVec);
            axes(handles.dataAxis);
            hold on
            handles.regPlot = plot(xVec,yVec,'--k');
            hold off
            regStr = sprintf('%5.3fX^2+%5.3fX+%5.3f',p1);
            %         xLimits = get(handles.dataAxis,'xlim');
            %         yLimits = get(handles.dataAxis,'ylim');
            set(handles.quadFormula,'String',regStr,'foregroundcolor',[1 1 1]);
        end
    end