# pi3-youtube-stream (work in progress)
Streaming HD from Raspberry Pi 3 to YouTube with remote audio source

## About
Made to stream HD video to YouTube from a Raspberry Pi 3. But since the Pi
doesn't have any audio in, I'm pulling audio from a remote computer. Video
and audio sync up nicely with the RTP protocol over UDP, and the Pi runs the
streamer service with ~9% CPU load.

## Usage
Clone to `/opt/youtube-streamer`

Run the remote audio binary on the remote computer. Start it with an argument
for IP:PORT of the Pi running the streaming service.

Set environment variables in streamer.env and start the service on the Pi.
