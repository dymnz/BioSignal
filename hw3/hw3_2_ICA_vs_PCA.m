clear; close all;
addpath('./FastICA_21');

% Signal specification
p1_limit = [3 8];
p2_limit = [-3 3];
N = 1000;

% Generation
p1 = unifrnd(p1_limit(1), p1_limit(2), 1, N);
p2 = unifrnd(p2_limit(1), p2_limit(2), 1, N);

% Mixing
source = [p1;p2];
A = [0.8 0.3;
     0.6 0.4];
mixed = A' * source;

% ICA
[icasig, icaA, icaW] = fastica(mixed, ...
            'verbose', 'off', 'displayMode', 'off');

% Plot mixed
figure;
mixed = mixed - (mean(mixed')')*ones(1, size(mixed, 2));    % Centering
scatter(mixed(1,:), mixed(2,:), 10, [0.8 0.8 0]);
hold on;
plotv(icaA.*max(max(mixed)), '-');
plotv(A'.*max(max(mixed)), '-');
title('ICA', 'FontSize', 20);

% PCA
[processed_source, W, E] = PCA(mixed, false);

% % Plot PC
% figure;
% scatter(mixed(1,:), mixed(2,:), 10, [0.8 0.8 0]);
% hold on;
% plotv(W.*max(max(mixed)), '-');
% title('PCA', 'FontSize', 20);

% Print stuff
fprintf('source var.: %.2f %.2f\n', ...
        var(source(1, :)), var(source(2, :)));
fprintf('mixed var.: %.2f %.2f\n', ...
        var(mixed(1, :)), var(mixed(2, :)));
fprintf('transformed var.: %.5f %.5f\n', ...
        var(processed_source(1, :)), var(processed_source(2, :)));    





