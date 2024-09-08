#!/bin/sh
# start.sh

# Delay execution by 60 seconds
sleep 30
while true; do
  sleep 30
  # Run VLC with the provided arguments
  /usr/bin/cvlc --no-audio --no-video https://ntv1.akamaized.net/hls/live/2014075/NASA-NTV1-HLS/master.m3u8 --sout '#duplicate{dst=std{access=http,mux=ts,dst=:8554/relay}}' &
  
  # Sleep for 20 minutes (1200 seconds) before restarting the stream
  sleep 1200
  killall vlc
done

# Run VLC with the provided arguments
#exec /usr/bin/cvlc --no-audio --no-video https://ntv1.akamaized.net/hls/live/2014075/NASA-NTV1-HLS/master.m3u8 --sout '#duplicate{dst=std{access=http,mux=ts,dst=:8554/relay}}'