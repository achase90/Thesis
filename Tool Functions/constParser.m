function [value]=constParser(filePath,searchTerm,brack1,brack2)

fid=fopen(filePath);

tline =fgetl(fid);
value=[];
while ischar(tline)
    s=strfind(tline,searchTerm);
    if ~isempty(s);
        b1=strfind(tline,brack1);
        b2=strfind(tline,brack2);
        value(end+1)=str2num(tline(b1+1:b2-1));
    end
    tline=fgetl(fid);
end