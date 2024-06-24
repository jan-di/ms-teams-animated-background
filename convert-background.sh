#!/bin/bash

set -e

teams_v1_path="$HOME/Library/Application Support/Microsoft/Teams/Backgrounds/Uploads"
teams_v2_path="$HOME/Library/Containers/com.microsoft.teams2/Data/Library/Application Support/Microsoft/MSTeams/Backgrounds/Uploads"
if [[ -d "${teams_v1_path}" ]]; then
  export target_dir="${teams_v1_path}"
fi
if [[ -d "${teams_v2_path}" ]]; then
  export target_dir="${teams_v2_path}"
fi
echo "Teams directory: ${target_dir}"
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

input=$1
bg_uuid=$(uuidgen | tr "[:upper:]" "[:lower:]")

check_if_ffmpeg_is_installed () {
  if [[ ! $(which ffmpeg) ]]; then
    echo "You don't have the ffmpeg converter installed!"
    read -p "Do you want ffmpeg automatically installed using brew? [y/n]: " brew_install_ffmpeg
    if [[ ${brew_install_ffmpeg} == "y" ]]; then
      echo "Installing ffmpeg. This may take a while..."
      brew install ffmpeg --quiet
    else
      echo "You need ffmpeg installed to convert the video! Exiting now!"
      exit 1
    fi
  fi
}

information_before_installation () {
  echo "${BOLD}Convert Background:${NORMAL}"
  echo "Input File: $input"
}

convert_mp4_to_gif () {
  echo "Convert video to gif..."
  ffmpeg -i "$input" -loop 0 -f gif "$bg_uuid.png" > /dev/null 2>&1
}

extract_thumbnail_from_gif () {
  echo "Extract thumbnail..."
  ffmpeg -i "$bg_uuid.png" -vf "select=eq(n\,0)" -vframes 1 "${bg_uuid}_thumb.png" > /dev/null 2>&1
}

move_gif_files_to_teams_folder () {
  mv ${bg_uuid}*.png "${target_dir}"
}

information_after_installation () {
  echo "Background File: $bg_uuid.png"
  echo "Thumbnail File: ${bg_uuid}_thumb.png"
}

install_instructions () {
	display_name=$1
  echo ""
  echo "${BOLD}Manual installation:${NORMAL}"
  echo "Copy all generated files into the backgrounds folder of your Teams installation."
  echo "If a terams installation is detected, there are automatic instructions below."

	echo ""
  echo "${BOLD}$display_name:${NORMAL}"
  echo "cp ${bg_uuid}*.png \"$target_dir/\""
}

information_before_installation
check_if_ffmpeg_is_installed
convert_mp4_to_gif
extract_thumbnail_from_gif
information_after_installation

read -p "Do you want that your gif is moved automatically into the teams folder? [y/n]: " direct_move
if [[ ${direct_move} == "y" ]]; then
  echo "Moving gif to teams backgrounds folder..."
  move_gif_files_to_teams_folder
  exit 0
fi

install_instructions "Teams v1 on macOS"
install_instructions "Teams v2 on macOS"