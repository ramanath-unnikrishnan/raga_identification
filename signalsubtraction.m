recObj = audiorecorder;
disp('start recording ambient:'); 
recordblocking(recObj,10);
disp('stop recording ambient');
myRecording = getaudiodata(recObj);
audiowrite('noise.wav', myRecording, 8000, 'BitsPerSample',32);
[noise,fs]=audioread('noise.wav');

recObj = audiorecorder;
disp('start recording audio:'); 
recordblocking(recObj,10);
disp('stop recording audio');
myRecording = getaudiodata(recObj);
audiowrite('audio.wav', myRecording, 8000, 'BitsPerSample',32);
[audio,fs]=audioread('audio.wav');

subplot(2,2,1);
plot(noise);
title('noise');

subplot(2,2,2);
plot(audio);
title('audio');

[noiseCancelledAudio] = audio - noise;
subplot(2,2,3);
plot(noiseCancelledAudio);
title('noise cancelled');