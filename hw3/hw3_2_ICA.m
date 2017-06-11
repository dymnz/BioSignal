clear; close all;
addpath('./FastICA_21');

% Signal specification
p1_limit = [50 60];
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

figure;
% Plot original signal
scatter(p1, p2);

% Plot mixed
figure;
% Centering
mixed = mixed - (mean(mixed')')*ones(1, size(mixed, 2));
scatter(mixed(1,:), mixed(2,:));
hold on;
plotv(icaA, '-');

% Plot ICA
figure;
% Centering
icasig = icasig - (mean(icasig')')*ones(1, size(icasig, 2));
scatter(icasig(1,:), icasig(2,:));

% Print stuff
fprintf('source var.: %.2f %.2f\n', ...
        var(source(1, :)), var(source(2, :)));
fprintf('mixed var.: %.2f %.2f\n', ...
        var(mixed(1, :)), var(mixed(2, :)));
fprintf('ICA var.: %.5f %.5f\n', ...
        var(icasig(1, :)), var(icasig(2, :)));    

figure;
hold on;
plotv(icaA./det(icaA), '-');
plotv(A'./det(A'), '-');


