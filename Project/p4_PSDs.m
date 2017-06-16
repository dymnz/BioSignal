%% Useful stuff
% pcg_segments
% pcg_psds
% meanPSD
%% 


% Median frequency
meanPSD = abs(fftshift(mean(pcg_psds)));
meanPSD_medfreq = medfreq(meanPSD(range), fshift(range))

