#!/bin/bash
set -euxo pipefail

if [ -z "$STREAM_KEY" ]; then
	>&2 echo "Missing environment variable STREAM_KEY"
fi

# Environment
ALSA_DEV=${ALSA_DEV:-plughw:CARD=audioinjectorpi,DEV=0}
AUDIO_INPUT="-f alsa -i $ALSA_DEV -acodec mp3 -ar 48000"
OUTPUT_STREAM="rtmp://a.rtmp.youtube.com/live2/$STREAM_KEY"

# These values have proved to work good for me, with only initial warnings
#AUDIO_ARGS='-thread_queue_size 128 -c:a mp3'
VIDEO_ARGS='-protocol_whitelist file'
#-thread_queue_size 128 -fflags nobuffer'

FPS=30
# YouTube 720p Optimals
WIDTH=1280
HEIGHT=720
VIDEO_BITRATE=4000000
# YouTube 1080p Optimals
#WIDTH=1920
#HEIGHT=1080
#VIDEO_BITRATE=6000000

KEYFRAME_INTERVAL=$((FPS*2))

# Start recording from Pi Camera
mkfifo /tmp/vid || true
raspivid -t 0 -w $WIDTH -h $HEIGHT -b $VIDEO_BITRATE -hf -vf -fps $FPS -lev 4.2 -fl -o /tmp/vid &

# Merge audio and video and send to output stream
ffmpeg	-f h264 -framerate $FPS -re $VIDEO_ARGS -i /tmp/vid \
	$AUDIO_INPUT \
	-vcodec copy -acodec mp3 -g $KEYFRAME_INTERVAL -f flv \
	-ar 44100 $OUTPUT_STREAM

