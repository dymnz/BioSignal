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

% Filters
orders = [2 8 8 8];
FCs = [10 20 40 70];
N = length(orders);

figSignal = figure;
figFreq = figure;
% Filtering
for i = 1 : N
    order = orders(i); fc = FCs(i);
    [result, b, a] = butter_filter(ecg, order, fc, fs);
    
    % Plot filtered signal
    figure(figSignal);
    subplot(N,1,i); plot(t, result);
    title(sprintf('Order: %d, fc = %dHz', order, fc))
    xlabel('Time (sec)')
    ax = gca;
    ax.YLim = [-3 3];
    
    % Plot frequency response
    figure(figFreq);
    subplot(N,1,i);     
    [h, w]= freqz(b, a, fs);
    plot(w/pi*fs, 20*log10(abs(h)));
    title(sprintf('Order: %d, fc = %dHz', order, fc))
    xlabel('Frequency (Hz)')
    ylabel('Magnitude (dB)')
    ax = gca;
    ax.YLim = [-100 20];
    ax.XLim = [0 fs];    
end