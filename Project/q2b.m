% Load the noisy signals (E2, E3)
fs = 128; % Sampling rate
t_E2 = (0:length(E2)-1) / fs; % Time vector for E2
t_E3 = (0:length(E3)-1) / fs; % Time vector for E3

% Step 1: Noise Removal for E2 and E3
% High-pass filter (for baseline wander removal)
hp_filter = designfilt('highpassiir', 'FilterOrder', 4, ...
                       'HalfPowerFrequency', 0.5, 'SampleRate', fs);

% Low-pass filter (to remove high-frequency noise)
lp_filter = designfilt('lowpassiir', 'FilterOrder', 4, ...
                       'HalfPowerFrequency', 40, 'SampleRate', fs);

% Notch filter (to remove powerline interference)
notch_filter = designfilt('bandstopiir', 'FilterOrder', 2, ...
                          'HalfPowerFrequency1', 49, ...
                          'HalfPowerFrequency2', 51, 'SampleRate', fs);

% Apply filters to E2
E2_filtered = filtfilt(hp_filter, E2); % High-pass
E2_filtered = filtfilt(lp_filter, E2_filtered); % Low-pass
E2_filtered = filtfilt(notch_filter, E2_filtered); % Notch

% Apply filters to E3
E3_filtered = filtfilt(hp_filter, E3);
E3_filtered = filtfilt(lp_filter, E3_filtered);
E3_filtered = filtfilt(notch_filter, E3_filtered);

% Step 2: R-Peak Detection
[~, r_peaks_E2] = findpeaks(E2_filtered, 'MinPeakHeight', threshold_E2, ...
                            'MinPeakDistance', fs * 0.6);
[~, r_peaks_E3] = findpeaks(E3_filtered, 'MinPeakHeight', threshold_E3, ...
                            'MinPeakDistance', fs * 0.6);

% Step 3: Calculate RR Intervals and HR
rr_intervals_E2 = diff(r_peaks_E2) / fs; % RR intervals for E2
hr_E2 = 60 ./ rr_intervals_E2; % HR for E2
time_hr_E2 = t_E2(r_peaks_E2(1:end-1)) + diff(t_E2(r_peaks_E2)) / 2;

rr_intervals_E3 = diff(r_peaks_E3) / fs; % RR intervals for E3
hr_E3 = 60 ./ rr_intervals_E3; % HR for E3
time_hr_E3 = t_E3(r_peaks_E3(1:end-1)) + diff(t_E3(r_peaks_E3)) / 2;

% Step 4: Plot HR
figure;
subplot(2, 1, 1);
plot(time_hr_E2, hr_E2, '-o');
xlabel('Time (s)');
ylabel('Heart Rate (bpm)');
title('Heart Rate as a Function of Time (E2)');
grid on;

subplot(2, 1, 2);
plot(time_hr_E3, hr_E3, '-o');
xlabel('Time (s)');
ylabel('Heart Rate (bpm)');
title('Heart Rate as a Function of Time (E3)');
grid on;
disp('Average Heart Rates (bpm):');
disp(['E1: ', num2str(mean(HR_E1))]);
disp(['E2: ', num2str(mean(HR_E2))]);
disp(['E3: ', num2str(mean(HR_E3))]);