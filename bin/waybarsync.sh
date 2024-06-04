#!/bin/bash

# Commands
inw_cmd="inotifywait -m -e modify $DOTFILES_DIR/.config/waybar"
event_cmd="killall -SIGUSR2 waybar"

$inw_cmd | while read dir action file; do
	$event_cmd
done
