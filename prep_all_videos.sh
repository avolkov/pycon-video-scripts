#!/bin/bash


function prep_dirs() {
    # Prepare & extract audio audio
    cd audio/

    cat *.mpg > audio.mpg
    ffmpeg -i audio.mpg -map_channel 0.0.0 ch1.wav -map_channel 0.0.1 ch2.wav -map_channel 0.0.2 ch3.wav -map_channel 0.0.3 ch4.wav

    rm audio.mpg

    mv *.wav ../
    cd ../

    # Prepare & convert slide framerate to 29.97 FPS
    cd slides/

    cat *.mpg > slides.mpg

    ffmpeg -y -r 60 -i slides.mpg -r 29.97 slides_2997fps.mpg

    rm slides.mpg

    mv slides_2997fps.mpg ../

    cd ../

    # Prepare speaker video, remove sound track

    cd speaker/

    cat *.mpg > speaker.mpg

    ffmpeg -i speaker.mpg -an -vcodec copy speaker_noaudio.mpg

    rm speaker.mpg

    mv speaker_noaudio.mpg ../

    cd ..

}

for k in $(ls | grep -v remainders)
do
    if [ -f "$k" ]
    then
        continue
    fi

    cd $k
    prep_dirs
    cd ..
done



