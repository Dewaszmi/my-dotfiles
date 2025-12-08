#!/usr/bin/bash

TARGET_DIR="$HOME/.config"

for dir in */; do
	dir_name="${dir%/}"
	TARGET_PATH="$TARGET_DIR/$dir_name"

	if [ -e "$TARGET_PATH" ]; then
		echo "Skipping "$dir_name", target path $TARGET_PATH already exists (remove it manually to overwrite)"
	else
		stow -d . -t "$TARGET_DIR" "$dir_name"
		if [ $? -eq 0 ]; then
			echo "Linked $dir_name dotfiles to $TARGET_DIR"
		else
			echo "There was an error while stowing $dir_nameto $TARGET_DIR"
		fi
	fi
done
echo "Linking finished."
