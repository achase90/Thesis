function handles = quadraticFitFun(handles)
% CITVal = 2.576; 
% CI = 99;
% CITVal = 2.326; % 98%
% CI = 98;
CITVal = 1.96; % 95%
CI = 95;
% CITVal = 1.645; % 90%
% CI = 90;

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
            xData = handles.data.(type).(xAxis).data;
            yData = handles.data.(type).(yAxis).data;
            if get(handles.ignoreThrust,'Value')
                hasThrust = handles.hasThrust;
                if length(hasThrust(hasThrust == false))>2 %if there's enough data to fit a polynomial to
%                     p1 = polyfit(xData(~hasThrust),yData(~hasThrust),2);
                    [p1,statsRobust] = robustfit([xData(~hasThrust) xData(~hasThrust).^2],yData(~hasThrust));
                    xVec = linspace(min(xData(~hasThrust)),max(xData(~hasThrust)),1000);
                else
                    set(handles.outputText,'String','Not enough data to fit a parabola to. Please deselect "Ignore data with thrust".');
                end
            else
%                 p1 = polyfit(xData,yData,2);
                [p1,statsRobust] = robustfit([xData xData.^2],yData);
                xVec = linspace(min(xData),max(xData),1000);
            end
            if(exist('p1','var')) %check if we actually made the polynomial or if there wasn't enough data
                p1 = flipud(p1);
                yVec = polyval(p1,xVec);
                %             yVec = polyval(p1,xVec);
                axes(handles.dataAxis);
                hold on
                handles.regPlot = plot(xVec,yVec,'--k','linewidth',2);
            hold off
            regStr = sprintf('%5.3fX^2+%5.3fX+%5.3f',p1);
            %         xLimits = get(handles.dataAxis,'xlim');
            %         yLimits = get(handles.dataAxis,'ylim');
            set(handles.quadFormula,'String',regStr,'foregroundcolor',[0 0 0]);
            %todo: redo this to use robustfit in gui window and all
            %regressions and confidence intervals output to the command window
            fprintf(' Estimated coefficients using ''robustfit'' function: \n')
            fprintf(' %10s %17s %20s\n','CD0','C1','C2');
            fprintf('%12.6f %18.6f %18.6f\n\n',[p1(3) p1(2) p1(1)]);
            fprintf(' %i%% CI from ''robustfit'' function : \n',CI)
            fprintf('%9.4f/%6.4f %14.4f/%6.4f %10.4f/%6.4f\n\n',[p1(3)+CITVal*statsRobust.se(3) p1(3)-CITVal*statsRobust.se(3)...
                p1(2)+CITVal*statsRobust.se(2) p1(2)-CITVal*statsRobust.se(2) p1(1)+CITVal*statsRobust.se(1) p1(1)-CITVal*statsRobust.se(1)]);
            fprintf(' As a percentage (+/-) : \n')
            fprintf('%12.4f %19.4f %19.4f\n\n',[(p1(3)+CITVal*statsRobust.se(3))/p1(3)...
                (p1(2)+CITVal*statsRobust.se(2))/p1(2)  (p1(1)+CITVal*statsRobust.se(1))/p1(1)]*100-100);

            end
        end
    end