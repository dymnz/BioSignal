% Median frequency stuff

close all;
%% Useful stuff
% pcg_segments
% pcg_ffts
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
    pcg_medfreqs(i, 1) = medfreq(segment(1:length(segment)/2), fshift(range));
end

% Plot segment PSD median vs. averaged PSD median
figure; hold on;
scatter(1:seg_num, pcg_medfreqs(:, 1));
plot(1:seg_num, meanPSD_medfreq*ones(seg_num));
xlabel('Segment #'); ylabel('Median freq. (Hz)'); ylim([0 150]);
title('Segment PSD median freq & averaged PSD median freq');

% Find the PA/CA for PCG
ratio_freqs = [25 75 150];  % [f1 f2 f3]
ratio_pts = round(ratio_freqs*(win_pts/fs));

pcg_pas = zeros(seg_num, 1);
pcg_cas = zeros(seg_num, 1);
for i = 1 : seg_num    
    pcg_pas(i) = sum( abs(pcg_ffts(i, ratio_pts(2):ratio_pts(3))) );
    pcg_cas(i) = sum( abs(pcg_ffts(i, ratio_pts(1):ratio_pts(2))) );
end


figure; hold on;
scatter(1:seg_num, pcg_pas./pcg_cas)
plot(0:seg_num, mean(pcg_pas./pcg_cas)*ones(1+seg_num));
xlabel('Segment #'); ylabel('PA/CA (AU)'); title('Segment PA/CA & mean PA/CA');
ylim([0 ceil(max(pcg_pas./pcg_cas))]);
fprintf('Mean for average PA/CA: %.2f\n', mean(pcg_pas./pcg_cas));