order = 8;
fc = 70;

[result, b, a] = butter_filter(ecg, order, fc, fs);
X = fftshift(fft(result));
fshift = (-slen/2:slen/2-1)*(fs/slen); % zero-centered frequency range
powershift = 20*log10(abs(X));     % zero-centered power
figure;
semilogx(fshift, powershift, '-')

title(sprintf('FFT of Order: %d, fc = %dHz', order, fc))
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')