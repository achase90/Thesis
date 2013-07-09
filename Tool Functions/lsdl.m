% Lists available data logs and the number of lines in them
function lsdl()
cwd=pwd;
ii=strfind(cwd,'Dropbox');
if numel(ii)==0
    ii=strfind(cwd,'dropbox');
end
olddir=cd([cwd(1:ii+6),'\Thesis\Data Logs']);

lines=sprintf('\n');
disp(lines);
files=dir('*.log');

for i=1:numel(files);
    numberoflines=perl('countlines.pl',files(i).name);
    str=[files(i).name(1:end),' : Number of Lines : '];
    strout=sprintf('%s %i',str,numberoflines);
    disp(strout);
end

files=dir('*.mat');

for i=1:numel(files);
%     numberoflines=perl('countlines.pl',files(i).name);
    str=[files(i).name(1:end),' : Created : '];
    strout=sprintf('%s %s',str,files(i).date(1:end));
    disp(strout);
end

disp(lines)

cd(olddir);
