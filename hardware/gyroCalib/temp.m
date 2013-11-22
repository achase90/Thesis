L = length(s);
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(s,NFFT)/L;
f = 9/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
plot(f,2*abs(Y(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')