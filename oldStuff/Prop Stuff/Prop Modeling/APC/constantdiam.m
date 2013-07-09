clear all,close all,clc

diam=11;
[J7,CT7,CP7,eta7]=prop_data('apce',diam,7);
[J8,CT8,CP8,eta8]=prop_data('apce',diam,8);
[J10,CT10,CP10,eta10]=prop_data('apce',diam,10);
[J55,CT55,CP55,eta55]=prop_data('apce',diam,55);

diam=11;
[J7sp,CT7sp,CP7sp,eta7sp]=prop_data('apcsf',diam,7);
[J38,CT38,CP38,eta38]=prop_data('apcsf',diam,38);
[J47,CT47,CP47,eta47]=prop_data('apcsf',diam,47);

msize=15;

figure(1)
hold on
scatter(J7,CT7,msize,'.k')
scatter(J8,CT8,msize,'.b')
scatter(J10,CT10,msize,'.g')
scatter(J55,CT55,msize,'.r')

figure(2)
hold on
scatter(J7sp,CT7sp,msize,'.k')
scatter(J38,CT38,msize,'.b')
scatter(J47,CT47,msize,'.g')
