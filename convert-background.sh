#!/bin/bash

set -eu

BOLD=$(tput bold)
NORMAL=$(tput sgr0)

input=$1
bg_uuid=$(uuidgen | tr "[:upper:]" "[:lower:]")

echo "${BOLD}Convert Background:${NORMAL}"
echo "Input File: $input"

echo "Convert video to gif..."
ffmpeg -i "$input" -loop 0 -f gif "$bg_uuid.png" > /dev/null 2>&1

echo "Extract thumbnail..."
ffmpeg -i "$bg_uuid.png" -vf "select=eq(n\,0)" -vframes 1 "${bg_uuid}_thumb.png" > /dev/null 2>&1

echo "Background File: $bg_uuid.png"
echo "Thumbnail File: ${bg_uuid}_thumb.png"

echo ""
echo "${BOLD}Manual installation:${NORMAL}"
echo "Copy all generated files into the backgrounds folder of your Teams installation."
echo "If a terams installation is detected, there are automatic instructions below."

install_instructions () {
	display_name=$1
	target_dir=$2

	if [ -d "$target_dir" ]; then
		echo ""
		echo "${BOLD}$display_name:${NORMAL}"
		echo "cp ${bg_uuid}*.png \"$target_dir/\""
	fi
}

install_instructions "Teams v1 on macOS" "$HOME/Library/Application Support/Microsoft/Teams/Backgrounds/Uploads"
install_instructions "Teams v2 on macOS" "$HOME/Library/Containers/com.microsoft.teams2/Data/Library/Application Support/Microsoft/MSTeams/Backgrounds/Uploads"