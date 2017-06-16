% Plot PCG segments
figure; block_size = 4;
for i = 1 : length(segment_indices)
    subplot_helper(time(1:win_pts), pcg_segments(i, :), ...
        [block_size ceil(length(segment_indices)/block_size) i], ...
        {'Time (s)' 'PCG (AU)' sprintf('PCG segments %d', i) });
    hold on;
    plot(time(1:win_pts), mean(pcg_segments));
end


