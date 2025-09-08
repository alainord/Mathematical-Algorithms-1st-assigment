clear; close all; clc;

% Analog signal
t = 0:0.0001:0.01;
f = 100;
x_analog = sin(2*pi*f*t);

figure;
plot(t, x_analog, 'k', 'LineWidth', 1.5);
title('Analog Signal');

% Diferent Nyquist frequencies
Fs_list = [150, 200, 1000]; % Below, at, above Nyquist
colors = {'r', 'g', 'b'};

figure;
for i = 1:length(Fs_list)
    Fs = Fs_list(i);
    Ts = 1/Fs;
    n = 0:Ts:0.01;
    x_sampled = sin(2*pi*f*n);

    subplot(3,1,i);
    stem(n, x_sampled, colors{i}, 'filled');
    hold on;
    plot(t, x_analog, 'k');
    title(['Sampling at Fs = ' num2str(Fs) ' Hz']);
    xlabel('Time (s)'); ylabel('Amplitude');
end

% Diferent quantization levels
bits_list = [3, 4, 6]; % 8,16,64 levels
Fs = 1000;             
Ts = 1/Fs;
n = 0:Ts:0.01;
x_sampled = sin(2*pi*f*n);

figure;
for j = 1:length(bits_list)
    bits = bits_list(j);
    levels = 2^bits;

    x_min = min(x_sampled);
    x_max = max(x_sampled);
    q_step = (x_max - x_min)/levels;

    x_index = round((x_sampled - x_min)/q_step);
    x_quantized = x_index*q_step + x_min;

    subplot(3,1,j);
    stem(n, x_quantized, 'filled');
    hold on;
    plot(t, x_analog, 'k');
    title(['Quantization with ' num2str(levels) ' levels (' num2str(bits) ' bits)']);
    xlabel('Time (s)'); ylabel('Amplitude');
end
