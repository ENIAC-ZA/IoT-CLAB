#!/bin/sh
# start.sh


# Delay execution by 75 seconds before starting the stream
sleep 40
while true; do
  sleep 30
  # Run VLC with the provided arguments
  /usr/bin/cvlc --no-audio --no-video "http://192.168.2.4:8554/relay" &
  
  # Sleep for 20 minutes (1200 seconds) before restarting the stream
  sleep 1200
  killall vlc
done
