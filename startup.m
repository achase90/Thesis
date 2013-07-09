[s,username]=dos('echo %USERNAME%');

if strcmp(username(1:end-1),'atchase');
    cd ('C:\Users\atchase\Documents\Thesis\');
    run starthere
end
disp('this worked');

clear all,clc