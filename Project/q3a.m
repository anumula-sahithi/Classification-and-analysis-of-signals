audioFileName = '9.mp3';
textFileName = '9.txt';

[audio, fs] = audioread(audioFileName);

fileID = fopen(textFileName, 'r');
data = textscan(fileID, '%s %f %f %d'); 
fclose(fileID);

words = data{1};
start_times = data{2};
end_times = data{3};
loudness_indicator = data{4};

rms_values = zeros(length(words), 1);
for i = 1:length(words)
    start_sample = round(start_times(i) * fs);
    end_sample = round(end_times(i) * fs);
    segment = audio(start_sample:end_sample);
    
    rms_values(i) = sqrt(mean(segment.^2)); 
end

rms_threshold = mean(rms_values);

louder_indices = find(loudness_indicator == 1 & rms_values > rms_threshold);

louder_times = [start_times(louder_indices), end_times(louder_indices)];

t = (0:length(audio)-1) / fs;
figure;
plot(t, audio, 'b'); 
hold on;

for i = 1:length(louder_indices)
    start_sample = round(louder_times(i, 1) * fs);
    end_sample = round(louder_times(i, 2) * fs);
    plot(t(start_sample:end_sample), audio(start_sample:end_sample), 'r'); 
end


title('Waveform');
xlabel('Time (seconds)');
ylabel('Amplitude');
hold off;

fprintf('Louder words in %s:\n', textFileName);
for i = 1:length(louder_indices)
    fprintf('%s (%.2f - %.2f seconds)\n', words{louder_indices(i)}, louder_times(i, 1), louder_times(i, 2));
end