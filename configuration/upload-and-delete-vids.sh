#!/bin/bash

EMAIL="" # Insert your email address here to receive a notification when new motion vids are uploaded to Google.

# Sync the files in /var/lib/motion to Google Drive and delete them.
rclone -v move --config /home/pi/.config/rclone/rclone.conf /var/lib/motion/ birdcam:birdcam --delete-after --include *.jpg --include *.avi

# Send an email to recipients that motion has been detected and synced to Google Drive
echo "Movie created in Google Drive" |  mail -s "Bird Camera has detected Motion!" $EMAIL
