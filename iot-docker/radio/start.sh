#!/bin/sh
# start.sh

# Delay execution by 60 seconds
#!/bin/sh
# start.sh

# Delay execution by 60 seconds
sleep 45
while true; do
  sleep 12
  # Run VLC with the provided arguments
  /usr/bin/cvlc --no-audio --no-video https://npr-ice.streamguys1.com/live.mp3 &
  /usr/bin/cvlc --no-audio --no-video http://direct.franceinter.fr/live/franceinter-midfi.mp3 &
  /usr/bin/cvlc --no-audio --no-video https://kexp-mp3-128.streamguys1.com/kexp128.mp3 &
  /usr/bin/cvlc --no-audio --no-video https://media-ice.musicradio.com/ClassicFMMP3 &
  /usr/bin/cvlc --no-audio --no-video https://fm939.wnyc.org/wnycfm-web &

  # Sleep
  sleep 4000
  killall vlc
done


# Run VLC with the provided arguments
#exec /usr/bin/cvlc --no-audio --no-video https://ntv1.akamaized.net/hls/live/2014075/NASA-NTV1-HLS/master.m3u8 --sout '#duplicate{dst=std{access=http,mux=ts,dst=:8554/relay}}'