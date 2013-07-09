clear all,close all,clc

pitch=12;

% for electrics, try x12
%for slow flyers, try x4.7
% for sp, x8, x7, x6,x5 all have the same

[J14,CT14,CP14,eta14]=prop_data('apce',14,pitch);
[J17,CT17,CP17,eta17]=prop_data('apce',17,pitch);
[J19,CT19,CP19,eta19]=prop_data('apce',19,pitch);

pitch=47;
[J9,CT9,CP9,eta9]=prop_data('apcsf',9,pitch);
[J10,CT10,CP10,eta10]=prop_data('apcsf',10,pitch);
[J11,CT11,CP11,eta11]=prop_data('apcsf',11,pitch);


pitch=5;
[J9sp,CT9sp,CP9sp,eta9sp]=prop_data('apcsp',9,pitch);
[J11sp,CT11sp,CP11sp,eta11sp]=prop_data('apcsp',11,pitch);

% pitch=;
% [J9sp7,CT9sp7,CP9sp7,eta9sp7]=prop_data('apcsp',9,pitch);
% [J11sp,CT11sp,CP11sp,eta11sp]=prop_data('apcsp',11,pitch);

msize=15;

figure(1)
hold on
scatter(J14,CT14,msize,'.k')
scatter(J17,CT17,msize,'.g')
scatter(J19,CT19,msize,'.b')

figure(2)
hold on
scatter(J9,CT9,msize,'.k')
scatter(J10,CT10,msize,'.g')
scatter(J11,CT11,msize,'.b')

figure(3)
hold on
scatter(J9sp,CT9sp,msize,'.k')
scatter(J11sp,CT11sp,msize,'.g')
