#!/bin/bash

dir=~/dotfiles/resc/wallpapers

for FILE in "$dir"/*; do
	echo "preload = $FILE" >>/tmp/tmphyprpaper
done

cat ~/dotfiles/.config/hypr/hyprpaper.conf >>/tmp/tmphyprpaper && mv /tmp/tmphyprpaper ~/dotfiles/.config/hypr/hyprpaper.conf
