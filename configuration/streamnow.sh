#!/bin/bash

EMAIL="" # Insert your email address here to receive notifications when the ffmpeg script is restarted
SERVICE="ffmpeg"
WEBCAM=192.168.86.219 #Change to your webcam IP address
RTSP_URL="rtsp://$WEBCAM/user=admin&password=tlJwpbo6&channel=2&stream=0.sdp?real_stream"
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"
YOUTUBE_KEY="" # Insert your Youtube Live Stream Key here

COMMAND="/home/pi/ffmpeg/ffmpeg -f lavfi -i anullsrc -thread_queue_size 10240 -rtsp_transport tcp -stimeout 60000000 -i ${RTSP_URL} -tune zerolatency -s 1920x1080 -r 25 -vcodec libx264 -pix_fmt + -c:v copy -c:a aac -strict experimental -f flv ${YOUTUBE_URL}/${YOUTUBE_KEY}"

if sudo /usr/bin/pgrep $SERVICE > /dev/null
then
        >&2 echo "${SERVICE} is already running."
else
        >&2 echo "${SERVICE} is NOT running! Starting now..."
	echo "Restarted ffmpeg!" | mail -s "Restarted ffmpeg" $EMAIL
	$COMMAND
fi
