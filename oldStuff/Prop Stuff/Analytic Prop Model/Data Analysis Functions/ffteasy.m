function [Y,f,NFFT]=ffteasy(x,sample_freq)

NFFT=2^nextpow2(length(x));
Fs=sample_freq;
f=Fs/2*linspace(0,1,NFFT/2+1);
Y=fft(x,NFFT)/length(x);
