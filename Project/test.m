figure;
meanPSD_power = 10*log10(abs(fftshift(mean(pcg_psds))));
meanPSD = abs(fftshift(mean(pcg_psds)));
medfreq(meanPSD(range), fshift(range))
hold on;
plot(fshift(range), 10+meanPSD_power(range))