#!/bin/bash

# Convert each chunk separately

for in_audio in $(ls audio)
do
    audio_name=$(echo $in_audio | cut -f1 -d. )
    ffmpeg -i "audio/${in_audio}" -map_channel 0.0.0 "wav/${audio_name}_ch1.wav" \
        -map_channel 0.0.1 "wav/${audio_name}_ch2.wav"
done