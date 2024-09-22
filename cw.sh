#!/bin/bash

# name: circadian wallpaper
# date: 21-09-2024
# author: Timo Kats
# description:
# When called, add a path to a folder with image files to pick a background from. The
# script then picks a random wallpaper from the 'brighter' half during the day and from
# the 'darker' half during the night.
#
# Note, set THEME correctly. Only tested on Debian/Gnome environment.

readonly THEME=picture-uri-dark # set to picture-uri if you have a light theme!
readonly EVENING=18
readonly MORNING=6
HOUR=$(date +"%H")
HOUR=$((10#$HOUR)) # mornings can break due to leading zero

if [[ HOUR -ge EVENING || HOUR -lt MORNING ]]; then
  selector="tail"
else
  selector="head"
fi

if [ $# -eq 0 ]; then
  echo "error: Add path to folder with wallpapers as parameter."
  exit 1
else
  wallpapers=$(expr "$(ls "$1" | wc -l)" / 2)
  if [[ wallpapers -lt 1 ]]; then
    echo "no wallpaper found!"
    exit 1
  fi
  selectedLine=$(for filename in $1/*; do
    echo "$(convert "$filename" -format "%[fx:int(mean*100)]" info:):"$filename""
  done | sort -rn -k3 | "$selector" -n $wallpapers | shuf -n 1)
  selectedFile="$(cut -d':' -f2 <<<"$selectedLine")"
  echo "$selectedFile"
  $(gsettings set org.gnome.desktop.background "$THEME" "$selectedFile")
fi
