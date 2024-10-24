#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for Random Wallpaper ( CTRL ALT W)

wallDIR="$HOME/Pictures/wallpapers"
scriptsDir="$HOME/.config/hypr/scripts"

# Retrieve image files using null delimiter to handle spaces in filenames
mapfile -d '' PICS < <(find -L ${wallDIR} -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print0)
RANDOMPICS=${PICS[$RANDOM % ${#PICS[@]}]}

# Transition config
FPS=60
TYPE="random"
DURATION=1
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

swww query || swww-daemon --format xrgb && swww img ${RANDOMPICS} $SWWW_PARAMS

${scriptsDir}/Refresh.sh
