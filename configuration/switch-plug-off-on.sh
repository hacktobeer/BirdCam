#!/bin/bash
SMARTPLUG=192.168.1.114 # Change to you IP address of your TP-Link smartplug

#/home/pi/tplink/tplink_smartplug.py -t $SMARTPLUG -c info
/home/pi/tplink/tplink_smartplug.py -t $SMARTPLUG -c off
/home/pi/tplink/tplink_smartplug.py -t $SMARTPLUG -c on
