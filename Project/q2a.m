% Load the signal (E1)
fs = 128; % Sampling rate (Hz)
t = (0:length(E1)-1) / fs; % Time vector

% Step 1: R-Peak Detection
[~, r_peaks] = findpeaks(E1, 'MinPeakHeight', threshold, 'MinPeakDistance', fs * 0.6);

% Step 2: Compute RR Intervals
rr_intervals = diff(r_peaks) / fs; % Convert sample indices to seconds

% Step 3: Calculate HR
hr = 60 ./ rr_intervals; % HR in bpm
time_hr = t(r_peaks(1:end-1)) + diff(t(r_peaks))/2; % Midpoint of RR intervals

% Step 4: Plot HR as Function of Time
figure;
plot(time_hr, hr, '-o');
xlabel('Time (s)');
ylabel('Heart Rate (bpm)');
title('Heart Rate as a Function of Time');
grid on;


disp('Average Heart Rates (bpm):');
disp(['E1: ', num2str(mean(HR_E1))]);
disp('Average Heart Rates (bpm):');
disp(['E1: ', num2str(mean(HR_E1))]);
disp(['E2: ', num2str(mean(HR_E2))]);
disp(['E3: ', num2str(mean(HR_E3))]);