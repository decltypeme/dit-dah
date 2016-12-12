recObj = audiorecorder(8000,8,1);
recordblocking(recObj,2);
samples = getaudiodata(recObj);
range = (1:1:recObj.TotalSamples);
fft_original = fft(samples);
filtered = filter(mfilter,samples);
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
starting_index = 1;%find((abs(filtered) > 0.3), 1);
filtered = filtered(starting_index : recObj.TotalSamples);

hypothesis_signal = [0];
returned_morse_code = '';
while(abs(length(hypothesis_signal) - length(filtered) ) > 1000)
    highest_correlated_file = '';
    highest_score = -inf;
    letter = -1;
    i = -1;
    files = dir('recorded\*.wav');
    for file = files'                                   %Check the order of listing
       i = i + 1;
       letter_samples = audioread(strcat('recorded\', file.name));
       test_signal = [hypothesis_signal;letter_samples];
       score = xcorr(filtered, test_signal, 1000);
       if(score > highest_score)
           highest_score = score;
           highest_correlated_file = file.name;
           letter = i;
       end
    end
    hypothesis_signal = [hypothesis_signal; audioread(strcat('recorded\', highest_correlated_file))];
    if(letter == 0)
        character = ' ';
    else
        character = 'a' + letter;
    end
    returned_morse_code = strcat(returned_morse_code, character);
end

disp(returned_morse_code);
