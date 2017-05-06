% Biosignal hw2: Filtering of ECG
clear; close all;


ecg = load('ecg_hfn.dat');
slen = length(ecg);
fs = 1000;	%sampling rate = 1000 Hz

% Original signal
t = [1:slen]/fs;
figure; plot(t, ecg);
axis tight;
xlabel('Time in seconds');
ylabel('ECG');
title('Original signal');

% Filter: Order 2, cutoff 10Hz
result = butter_filter(ecg, 2, 10, fs);
figure; plot(t, result);
