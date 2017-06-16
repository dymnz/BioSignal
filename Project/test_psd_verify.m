% PSD verify
close all;

[pxx,f] = periodogram(pcg_segments(3, :),[],length(pcg_segments(3, :)),fs);
figure;
plot(f, 10*log10(pxx))
hold on;
X = 10*log10(abs(fftshift(pcg_psds(3, :))));
plot(fshift(range), X(range))
