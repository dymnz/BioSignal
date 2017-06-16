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

% Remove truncated window
if segment_indices(end)+win_pts-1 > length(pcg)
   segment_indices = segment_indices(1:end-1);
end    

disp(sprintf('There are %d segments\n', length(segment_indices)));

pcg_segments = zeros(length(segment_indices), win_pts);
for i = 1 : length(segment_indices)
    start = segment_indices(i);
    pcg_segments(i, :) = pcg(start : start+win_pts-1);    
end

% Plot PCG segments 
figure; block_size = 4;
for i = 1 : length(segment_indices)
    start = segment_indices(i);
    subplot_helper(time(start : start+win_pts-1), pcg_segments(i, :), ...
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
fshift = (-win_pts/2:win_pts/2-1)*(fs/win_pts); % zero-centered frequency range
range = (length(fshift)/2+1):length(fshift);
for i = 1 : length(segment_indices)    
    X = fftshift(pcg_psds(i, :));    
    powershift = 10*log10(abs(X));
    subplot_helper(fshift(range), powershift(range), ...
        [block_size ceil(length(segment_indices)/block_size) i], ...
        {'Frequency (Hz)' 'Power (AU)' sprintf('PCG PSD %d', i) });    
    ylim([-15 5]);
end

% Comparing to average PSD
meanPSD = mean(pcg_psds);
meanPSD_power = 10*log10(abs(fftshift(meanPSD)));
for i = 1 : 4       
    X = fftshift(pcg_psds(i, :));
    powershift = log(abs(X));

    figure;
    subplot_helper(fshift(range), powershift(range), [2 1 1], ...
                {'Time (s)' 'Power (dB)' ...
                sprintf('PCG %d PSD', i)});
    hold on;                
    subplot_helper(fshift(range), meanPSD_power(range), ...
                [2 1 1], {'Time (s)' 'Power (dB)' ...
                sprintf('PCG %d PSD', i)});
    
    subplot_helper(time(1:win_pts), pcg_segments(i, :), ...
                [2 1 2], {'Time (s)' 'Power (dB)' ...
                sprintf('PCG %d', i)});
    hold on;                
    subplot_helper(time(1:win_pts), mean(pcg_segments), ...
                [2 1 2], {'Time (s)' 'Power (dB)' ...
                sprintf('PCG %d', i)});                    
end

