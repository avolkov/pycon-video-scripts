#!?bin/bash

for k in $(ls)
do
    if [ -d "$k" ]
    then
        cd $k
        mkdir audio slides
        cd ..
    fi
done
