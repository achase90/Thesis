clear all,close all,clc

files=dir('*.txt');

for i=1:length(files);
    if max(strfind(files(i).name,'apc'))
        movefile(files(i).name,'APC')
    elseif max(strfind(files(i).name,'ance'))
        movefile(files(i).name,'Aeronaut')
    elseif max(strfind(files(i).name,'gr'))
        movefile(files(i).name,'Graupner')
    elseif max(strfind(files(i).name,'gw'))
        movefile(files(i).name,'GWS')
    elseif max(strfind(files(i).name,'kav'))
        movefile(files(i).name,'Kavon')
    elseif max(strfind(files(i).name,'kyosho'))
        movefile(files(i).name,'Kyosho')
    elseif max(strfind(files(i).name,'ma'))
        movefile(files(i).name,'Master Airscrew')
    elseif max(strfind(files(i).name,'ru'))
        movefile(files(i).name,'Rev Up')
    elseif max(strfind(files(i).name,'zin'))
        movefile(files(i).name,'Zingali')
    end
end
