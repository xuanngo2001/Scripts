#!/bin/bash
# Description: Automatically take 8 screenshots of a video using mplayer
#              Screenshots are saved in 01.png, 02.png, ..., 08.png
# Author: Xuan Ngo
# Usage: ./screenshots.sh <videofilename> <# of screenshots>
# Requirements: mpv, grep, sed
# Reference: https://github.com/tkanmae/dotfiles/commit/51bd6d4e12eaebfe484e1d3c29f5fff3a44e6325

### Global variables
filename="$1"

### Error handling
if [ -z ${filename} ]; 
then
    echo "ERROR: No video file supplied. Please enter a video file as argument."
    exit 1;
fi

# For some unknown reason, the last screenshot is not generated by mplayer.
# Therefore, always add 1 more to the total number of screenshots that you want.
NUM_OF_SCREENSHOTS=9
if [ ! -z $2 ]; 
then
  NUM_OF_SCREENSHOTS=$2
  echo "WARNING: Overwrite default number of screenshots to ${NUM_OF_SCREENSHOTS}."
  sleep 3s
fi

 

 
# Get the total length of the video in seconds.
#  Use mplayer to display the info of the video and then get the value of ID_LENGTH, the total number of seconds of the video.
total_length=$(mplayer -identify -frames 0 -vc null -vo null -ao null ${filename} | grep ID_LENGTH | sed 's/ID_LENGTH=//' | sed 's/\..*//')
# Reference https://github.com/mpv-player/mpv/blob/master/TOOLS/mpv_identify.sh

# Remove 4 seconds from the video so that it doesn't take screenshot at the ends.
let total_length-=4
 
# time_slice: At which time interval should mplayer take screenshots.
let time_slice=${total_length}/${NUM_OF_SCREENSHOTS}
 
# time_at: When should mplayer take screenshots.
time_at=${time_slice};
 
# Looping to take screenshots.
for ((i=1; i <= NUM_OF_SCREENSHOTS ; i++))
do
 
  # Create unique filename.
  padding=$(printf %03d ${i})
 
  # Take the screenshot.
  #mplayer -loop 1 -nosound -frames 1 -ss ${time_at} -vo png:z=9 ${filename}
  mpv --quiet --no-audio --vo=image --start=${time_at} --frames=1 ${filename}
 
  # Increment to the next time slice.
  let time_at+=${time_slice}

  # Move the screenshot 00000001.jpg to 0X.jpg
  mv 00000001.jpg ${padding}.jpg

done