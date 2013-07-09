% Lists all available Tool Functions with a short description
function lstf()
cwd=pwd;
ii=strfind(cwd,'Dropbox');
if numel(ii)==0
    ii=strfind(cwd,'dropbox');
end
olddir=cd([cwd(1:ii+6),'\Thesis\Tool Functions']);

lines=sprintf('\n');
disp(lines);
files=dir('*.m');

for i=1:numel(files);
fid=fopen(files(i).name);
tline=fgetl(fid);
str=[files(i).name(1:end-2),' :', tline(2:end)];
strout=sprintf('%s',str);
disp(strout);
fclose(fid);
end

disp(lines);

cd(olddir);
