% Median frequency stuff

close all;
%% Useful stuff
% pcg_segments
% pcg_psds
% meanPSD
%% 


% Median frequency
meanPSD = abs(fftshift(mean(pcg_psds)));
meanPSD_medfreq = medfreq(meanPSD(range), fshift(range));
fprintf('Median frequency for average PSD: %.2fHz\n', meanPSD_medfreq);

pcg_medfreqs = zeros(seg_num, 1);
for i = 1 : seg_num
    segment = abs(pcg_psds(i, :));
    pcg_medfreqs(i) = medfreq(segment(1:length(segment)/2), fshift(range));
end

% Plot segment PSD median vs. averaged PSD median
figure; hold on;
scatter(1:seg_num, pcg_medfreqs);
plot(1:seg_num, meanPSD_medfreq*ones(size(pcg_medfreqs)));
xlabel('Segment #'); ylabel('Median freq. (Hz)'); ylim([0 150]);
title('Segment PSD median vs. averaged PSD median');

