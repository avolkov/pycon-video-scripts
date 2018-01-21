#!/usr/bin/env python3

"""
Given organized speaker videos 0xx_talk_name/speaker
move all related audio and presentation slides to directories
audio, slides
"""

import os
from shutil import move

def extract_timestamp(filename):
    parts = filename.split(",")
    parts[3] = parts[3].split(".")[0]
    parts[3] = parts[3][:-2]
    return ",".join(parts[2:4])



def speaker_stamps(talk_dir):
    """
    Given a dir with 'speakers' subdir extract timestamps for each talk
    """
    files = []
    for speaker_file in os.scandir(os.path.join(talk_dir.path, 'speaker')):
        files.append(speaker_file.name)

    for file in files:
        yield extract_timestamp(file)


def timestamped_mpgs(top_level_files):
    files = {}
    for file in top_level_files:
        if not file.is_file():
            continue
        if not file.name.endswith(".mpg"):
            continue

        if extract_timestamp(file.name) not in files:
            files[extract_timestamp(file.name)] = [file.path]
        else:
            files[extract_timestamp(file.name)].append(file.path)
    return files



top_level_files = [x for x in os.scandir('.')]

uncategorized_mpgs = timestamped_mpgs(top_level_files)

for talk_dir in top_level_files:
    if not talk_dir.is_dir():
        continue
    print(talk_dir)
    for timestamp in  speaker_stamps(talk_dir):
        try:
            matching_uncategorized = uncategorized_mpgs[timestamp]
        except KeyError:
            print('No matching {}'.format(timestamp))
            continue
        for value in matching_uncategorized:
            dest = ''
            if "audio" in value:
                dest = os.path.join(talk_dir, 'audio')
            else:
                dest = os.path.join(talk_dir, 'slides')

            move(value, dest)
