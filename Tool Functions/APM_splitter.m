% Splits an APM_parser struct into segments of interest, based on toggling "tag" mode
% [DATAOUT]=APM_splitter(DATA,tag)

function [DATAOUT]=APM_splitter(DATA,tag)

indices=strcmpi(tag,DATA.MOD.MODE(:));

% startSwitch=mod(cumsum(indices),2);
% stopSwitch=abs(startSwitch-indices);

% startLine=DATA.MOD.lineNo(logical(startSwitch));
% stopLine=DATA.MOD.lineNo(logical(stopSwitch));
% diff(DATA.MOD.lineNo(indices))>1
linesOfInterest=DATA.MOD.lineNo(indices);
startLine=2:4:length(linesOfInterest);
stopLine=3:4:length(linesOfInterest);

datanames=fieldnames(DATA);
for k=1:length(stopLine)
    for i=1:numel(datanames)
        %         if ~(strcmp(datanames{i},'CMD'));
        datafieldnames=fieldnames((DATA.(datanames{i})));
        for j=1:numel(datafieldnames)
            index1=DATA.(datanames{i}).lineNo>linesOfInterest(startLine(k));
            index2=DATA.(datanames{i}).lineNo<linesOfInterest(stopLine(k));
            [DATAOUT(k).(datanames{i}).(datafieldnames{j})]=DATA.(datanames{i}).(datafieldnames{j})(logical(index1.*index2));
            %             end
        end
    end
    
end