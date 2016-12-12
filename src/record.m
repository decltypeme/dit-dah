function record(file_name)
recObj = audiorecorder(8000,8,1);
recordblocking(recObj,4);
samples = getaudiodata(recObj);
filtered = filter(mfilter,samples);
range = (1:1:recObj.TotalSamples);

figure(1);
plot(range, filtered);

starting_index = input('Start\n');
end_index = input('End\n');

range = (1:1: end_index - starting_index + 1);
filtered = filtered(starting_index : end_index);
sound(filtered);
plot(range ,filtered);
audiowrite(strcat(file_name, '.wav'), filtered, 8000);
end