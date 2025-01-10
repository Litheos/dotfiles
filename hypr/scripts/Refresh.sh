#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Scripts for refreshing ags waybar, rofi, swaync, wallust
rainbow=false
SCRIPTSDIR=$HOME/.config/hypr/scripts

# Wallust refresh
"${SCRIPTSDIR}"/WallustSwww.sh &

# Kill already running processes
_ps=(waybar rofi swaync ags)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" >/dev/null; then
        pkill "${_prs}"
    fi
done

# quit ags
ags -q

sleep 0.3
#Restart waybar
waybar &

relaunch swaync
sleep 0.5
swaync >/dev/null 2>&1 &

# relaunch ags
ags &

# Relaunching rainbow borders if the script exists
sleep 1
if [ $rainbow = true ]; then
    ${SCRIPTSDIR}/RainbowBorders.sh &
fi

exit 0
