function handles = quadraticFitFun(handles)

    if handles.xAxisDefined && handles.yAxisDefined
        [type] = getDataType(handles);
        [xAxis,yAxis] = getAxisNames(handles);
        xIsNumeric = isnumeric(handles.data.(type).(xAxis).data);
        yIsNumeric = isnumeric(handles.data.(type).(yAxis).data);
        if length(handles.data.(type).(xAxis).data) ~= length(handles.data.(type).(yAxis).data)
            set(handles.quadFormula,'String','Vectors must be the same length.','Foregroundcolor',[1 1 1]);
        elseif ~xIsNumeric
            set(handles.quadFormula,'String',['Variable ''' xAxis ''' is not numeric.'],'Foregroundcolor',[1 1 1]);
        elseif ~yIsNumeric
            set(handles.quadFormula,'String',['Variable ''' yAxis ''' is not numeric.'],'Foregroundcolor',[1 1 1]);
        else
            [xAxis,yAxis] = getAxisNames(handles);
            xData = double(handles.data.(type).(xAxis).data);
            yData = double(handles.data.(type).(yAxis).data);
            if get(handles.ignoreThrust,'Value')
                hasThrust = handles.hasThrust;
                if length(hasThrust(hasThrust == true))>2 %if there's enough data to fit a polynomial to
                p1 = polyfit(xData(hasThrust),yData(hasThrust),2);
                xVec = linspace(min(xData(hasThrust)),max(xData(hasThrust)));
                else
                    set(handles.outputText,'String','Not enough data to fit a parabola to. Please deselect "Ignore data with thrust".');
                end
            else
                p1 = polyfit(xData,yData,2);
                xVec = linspace(min(xData),max(xData));
            end
            if(exist('p1','var')) %check if we actually made the polynomial or if there wasn't enough data
            yVec = polyval(p1,xVec);
            axes(handles.dataAxis);
            hold on
            handles.regPlot = plot(xVec,yVec,'--k');
            hold off
            regStr = sprintf('%5.3fX^2+%5.3fX+%5.3f',p1);
            %         xLimits = get(handles.dataAxis,'xlim');
            %         yLimits = get(handles.dataAxis,'ylim');
            set(handles.quadFormula,'String',regStr,'foregroundcolor',[1 1 1]);
            %todo: redo this to use robustfit in gui window and all
            %regressions and confidence intervals output to the command window
            end
        end
    end