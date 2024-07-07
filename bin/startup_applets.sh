#!/bin/bash

# This is a collection of all the applets that I want on startup
blueman-applet &
nm-applet &
ckb-next --background &
wait 3
blueman-tray
