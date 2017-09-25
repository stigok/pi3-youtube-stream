# pi3-youtube-stream (work in progress)
Streaming HD from Raspberry Pi 3 to YouTube with remote audio source

## About
Made to stream HD video to YouTube from a Raspberry Pi 3. But since the Pi
doesn't have any audio in, I'm pulling audio from a remote computer. Video
and audio sync up nicely with the RTP protocol over UDP, and the Pi runs the
streamer service with ~9% CPU load.

## Usage
Clone to `/opt/youtube-streamer`

### On the remote audio box

1. Start streaming the audio by running `rtp-audio-stream.sh $IP:1337`

Where `$IP` is the IP address of the Pi.

### On the Pi

1. Set environment variables in `streamer.env`
2. Update `audio.sdp` with the IP address of the remote audio source (replace `10.10.3.138`)
2. Link service: `cp -s youtube-streamer.service /etc/systemd/system/ && systemctl daemon-reload`
3. Start the service `systemctl start youtube-streamer.service`
