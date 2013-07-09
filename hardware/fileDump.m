clear all,close all,clc

ard = serial('Com8');

fopen(ard);
pause(4);

fprintf(ard,'dump');

A=fread(ard);

fclose('all');