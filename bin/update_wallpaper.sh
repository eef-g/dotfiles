#!/bin/bash

# Define the directory
directory=~/dotfiles/resc/wallpapers
target=~/dotfiles/.config/hypr/hyprpaper.conf

# Get list of files in the directory
files=$(ls $directory)

# Create an array to store the filenames
file_array=()

# Loop through each file and add it to the array
for file in $files; do
	file_array+=("$file")
done

dim=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}
# Use smenu to display the list of files and allow the user to select one
chosen_file=$(printf '%s\n' "${file_array[@]}" |
	fzf --preview "/home/eef/dotfiles/bin/fzf-image.sh $directory/{}")

# Display the chosen file
echo "Changing wallpaper to: $chosen_file"

sed -i "s|wallpaper = , ~/dotfiles/resc/wallpapers/\([^/]*\)|wallpaper = , ~/dotfiles/resc/wallpapers/$chosen_file|" \
	$target

# Now update the wallpapers
hyprctl hyprpaper wallpaper "DP-1,~/dotfiles/resc/wallpapers/$chosen_file"
hyprctl hyprpaper wallpaper "DVI-D-1,~/dotfiles/resc/wallpapers/$chosen_file"
