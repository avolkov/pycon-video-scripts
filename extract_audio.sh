#!/bin/bash

ffmpeg -i audio.mpg -map_channel 0.0.0 ch1.wav -map_channel 0.0.1 ch2.wav -map_channel 0.0.2 ch3.wav -map_channel 0.0.3 ch4.wav
