#!/bin/bash
# Used for streaming an audio source to a remote location
# Example: rtp-audio-stream.sh 10.10.3.101:4242
set -x
SAMPLERATE='44100'
BITRATE='128k'
DEV='hw:CARD=SB,DEV=0'
ffmpeg -re -f alsa -ar $SAMPLERATE -i $DEV -b:a $BITRATE -c:a mp3 -f mp3 -f rtp rtp://$1
