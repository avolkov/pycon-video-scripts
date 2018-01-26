#!/bin/bash

for k in *.mpg
do
echo $k $(ffmpeg -i $k 2>&1| grep Duration)
done