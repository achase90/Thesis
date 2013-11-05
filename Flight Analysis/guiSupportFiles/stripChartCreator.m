function stripChartCreator(hObject,eventdata,handles)

k = strfind(handles.stripSaveDir, 'LaTex');
mainSaveDir = handles.stripSaveDir(1:k+4);
if ~isempty(k)
    if exist([mainSaveDir '\dataGraphs.tex'],'file')==2
        mainFid = fopen([mainSaveDir '\dataGraphs.tex'],'w');
        fclose(mainFid);
    end
        mainFid = fopen([mainSaveDir '\dataGraphs.tex'],'a');
else
    if exist([handles.stripSaveDir '\dataGraphs.tex'],'file')==2
        mainFid = fopen([handles.stripSaveDir '\dataGraphs.tex'],'w');
        fclose(mainFid);
    end
        mainFid = fopen([handles.stripSaveDir '\dataGraphs.tex'],'a');
end

    fprintf(mainFid,'\\chapter{Sample System Ouput}\r\n');
    fprintf(mainFid,'This appendix contains graphs representing typical outputs from the data acquisition system, shown in strip chart format.\r\n');

types = fieldnames(handles.data);
f=figure('visible','off','paperunits','inches','paperposition',[0 0 6 3]);
hhh=axes;
for j=1:numel(types)
    fprintf(mainFid,'\\input{figures/sampleOutput/%s/sampleOutput}\r\n',types{j});
    typeSaveDir = [handles.stripSaveDir '/' types{j}];
    if ~exist(typeSaveDir,'dir')
        mkdir(typeSaveDir)
    end
    fields = fieldnames(handles.data.(types{j}));
    
    if exist([typeSaveDir '\sampleOutput.tex'],'file')==2
        fid = fopen([typeSaveDir '\sampleOutput.tex'],'w');
        fclose(fid);
    end
    
    subFid = fopen([typeSaveDir '\sampleOutput.tex'],'a');
    fprintf(subFid,'\\section{Sample System Ouput - %s Data}\r\n',types{j});
    %fprintf(fid,'Below are charts of all measured signals versus time for a sample flight test.\r\n');
    
    for i=1:numel(fields)
        
        % stuff to deal with too many latex floats
        numFields = numel(fields);
        numPages = ceil(numFields/3);
        if i == ceil(numPages/2);
            clearpageflag = true;
        else
            clearpageflag = false;
        end
        
        
        if ~strcmp(fields{i},'time') && ~strcmp(fields{i},'utcTime')
            if isnumeric(handles.data.(types{j}).(fields{i}).data)
                if length(handles.data.(types{j}).time.data)==length(handles.data.(types{j}).(fields{i}).data)
                    plot(hhh,handles.data.(types{j}).time.data,handles.data.(types{j}).(fields{i}).data)
                    xlabel(hhh,'Time [sec]');
                else
                    if ~strcmp(fields{i},'utcTime')
                        try %assume they didn't match lengths because it was GPS
                            plot(hhh,handles.data.(types{j}).utcTime.data,handles.data.(types{j}).(fields{i}).data)
                            xlabel(hhh,'GPS Time [sec]');
                        catch
                            %                     str=sprintf();
                            warning('Vector lengths did not match for variable ''%s'', and attempted GPS resolution failed.',fields{i});
                        end
                    end
                end
                ylabel(hhh,[fields{i} ' [' handles.data.(types{j}).(fields{i}).units ']']);
                saveas(f,[typeSaveDir '\' fields{i},'.eps'],'epsc')
                writeLatexFigure(subFid,typeSaveDir,fields{i},clearpageflag)
            end
        end
    end
    fclose(subFid);
end
set(handles.outputText,'String',['Strip chart files saved to ' handles.stripSaveDir]);
fclose(mainFid);