% Find the average of PCG PSD and compare it with individual PCG PSD

%% Useful stuff
% win_pts: Points of each segment
% segment_starts: Starting point of each segment
% segment_windows: Windows of segments
% time: Time axis
%%
close all;

% Retrieve the segments
segment_indices = find(segment_starts);
pcg_segments = zeros(length(segment_indices), win_pts);
for i = 1 : length(segment_indices)
    start = segment_indices(i);
    pcg_segments(i, :) = pcg(start : start+win_pts-1);    
end

% Plot PCG segments
figure; block_size = 4;
for i = 1 : length(segment_indices)
    subplot_helper(time(1:win_pts), pcg_segments(i, :), ...
        [block_size ceil(length(segment_indices)/block_size) i], ...
        {'Time (s)' 'PCG (AU)' sprintf('PCG segments %d', i) });
end

% Find the PSD for each segment
pcg_psds = zeros(length(segment_indices), win_pts);
for i = 1 : length(segment_indices)
    pcg_psds(i, :) = (fft(pcg_segments(i, :))).^2 / win_pts;    
end

% Plot PCG PSD
figure; block_size = 4;
for i = 1 : length(segment_indices)    
    X = fftshift(pcg_psds(i, :));
    fshift = (-win_pts/2:win_pts/2-1)*(fs/win_pts); % zero-centered frequency range
    powershift = log(abs(X));
    subplot_helper(fshift, powershift, ...
        [block_size ceil(length(segment_indices)/block_size) i], ...
        {'Frequency (Hz)' 'Power (AU)' sprintf('PCG PSD %d', i) });    
end