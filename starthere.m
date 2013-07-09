%initialization script for thesis
cwd=pwd;
ii=strfind(cwd,'Dropbox');

if numel(ii)==0
    ii=strfind(cwd,'dropbox');
end

addpath(genpath(fullfile([cwd(1:ii+6),'\Thesis\Tool Functions'])));
addpath(genpath(fullfile([cwd(1:ii+6),'\Thesis\Data Logs'])));

%set figure settings

clear all