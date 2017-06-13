% QRS detection %
clear; close all;

% Parameter
sig = load('./data/pec41.dat');
fs = 1000;
limit = 4500:16000;   % Using only mid-section signal

% Separating pcg, ecg, and carotid signals
pcg = sig(limit, 1);
ecg = sig(limit, 2);
carotid = sig(limit, 3);
time = [1:length(pcg)]/fs;

%% Preprocessing 
% Orignal
figure;
subplot_helper(time, ecg, [4 1 1], ...
                {'Time in seconds' 'Original'});
                       
% Low-pass
signal = ecg; order = 8; fc = 90;
[f_ecg, cb, ca] = butter_filter(signal, order, fc, fs);
subplot_helper(time, f_ecg, [4 1 2], ...
                {'Time in seconds' 'Low-passed'})

% Downsample        
fs_d = 200;
d_f_ecg = downsample(f_ecg, fs/fs_d);
d_time = [1:length(d_f_ecg)]/fs_d;
subplot_helper(d_time, d_f_ecg, [4 1 3], ...
                {'Time in seconds' 'Downsampled'})

% Normalization
n_d_f_ecg = d_f_ecg / max(d_f_ecg);
subplot_helper(d_time, n_d_f_ecg, [4 1 4], ...
                {'Time in seconds' 'Normalized'})

%% QRS detection
% Orignal
figure;
subplot_helper(d_time, n_d_f_ecg, [4 1 1], ...
                {'Time in seconds' 'Normalized'});

% First derivative
d1_ecg = abs([n_d_f_ecg; 0; 0;] - [0; 0; n_d_f_ecg]);   % Derivative
d1_time = [1:length(n_d_f_ecg)+2]/fs_d; % Extend the time vector
subplot_helper(d1_time, d1_ecg, [4 1 2], ...
                {'Time in seconds' 'Normalized'})
            
            