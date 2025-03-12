[audio_signal, fs] = audioread('4.wav');

frame_length = round(0.02 * fs); 
hop_length = round(0.01 * fs);   

num_frames = floor((length(audio_signal) - frame_length) / hop_length) + 1;
rms_energy = zeros(num_frames, 1);

for i = 1:num_frames
    start_index = (i-1) * hop_length + 1;
    end_index = start_index + frame_length - 1;
    frame = audio_signal(start_index:end_index);
    rms_energy(i) = sqrt(mean(frame.^2)); 
end

energy_threshold = mean(rms_energy) * 1.5;

louder_frames = rms_energy > energy_threshold;

time = (0:num_frames-1) * hop_length / fs; 
figure;
plot(time, rms_energy, 'b', 'LineWidth', 1.5); 
hold on;

xlabel('Time (s)');
ylabel('RMS Energy');
title('RMS Energy with Louder Frames Marked');
grid on;