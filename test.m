%close all;
clc;
fs=44100;
[z,fs]=audioread('C#.wav');
r=277.18;
notes= [r,r*(2^(1/12)), r*(2^(2/12)), r*(2^(3/12)),r*(2^(4/12)),r*(2^(5/12)),r*(2^(6/12)),r*(2^(7/12)),r*(2^(8/12)),r*(2^(9/12)),r*(2^(10/12)),r*(2^(11/12))];
num_of_notes=12;
%program to remove silence from the audio

%step 1- Break the signal into frames of 0.5s
frame_duration = 0.1;
frame_len = frame_duration*fs;
N = length(z);
num_frames = floor(N/frame_len);

new_sig = zeros(N,1);
count = 0;
inp_note_index = 1;
tolerance = 2;

for k = 1:num_frames
       %extract a frame of audio
       frame = z( (k-1)*frame_len+1 : frame_len*k);
       %Step 2-identify non-silent region as regions with amplitude > 0.01
       max_val = max(frame);
       
       if(max_val>0.0001)
           %frame is not silent
           
           count=count+1;
           new_sig((count-1)*frame_len+1 : frame_len*count)=frame;
           temp=new_sig((count-1)*frame_len+1 : frame_len*count);
           f0=pitch(temp,fs);
           %[f0,loc] = pitch(temp,fs, ...
           %'Method', 'PEF',...
           %'Range',[r r*2],...
           %'WindowLength',round(fs*0.1),...
           %'OverlapLength',round(fs*0.065));
         %mapping each f0 to quantized notes
           for j = 1 : num_of_notes
               if(abs(f0 - notes(j)) <= tolerance)
                    f0 = notes(j);
                    break;

               end
           end
       end
end
disp(f0);