recObj = audiorecorder(8000,8,1);
recordblocking(recObj,10);
samples = getaudiodata(recObj);
range = (1:1:recObj.TotalSamples);
fft_original = fft(samples);
filtered = filter(myfilter2,samples);
fft_filtered = fft(filtered);

figure(1);
plot(range, samples);
figure(2)
plot(range, filtered);
figure(3);
plot(range, abs(fft_original));
figure(4);
plot(range, abs(fft_filtered));


%play(recObj);

player = audioplayer(filtered,8000);
play(player);

%Truncate silence at the beginning
starting_index = find(abs(filtered > 0.3), 1);
filtered = filtered(starting_index : recObj.TotalSamples);


