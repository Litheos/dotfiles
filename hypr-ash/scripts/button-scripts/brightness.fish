#!/usr/bin/env fish
# Script for Monitor backlights (if supported) using brightnessctl

set iDIR {$HOME}/.config/swaync/icons
set notification_timeout 1000
set step 10  # INCREASE/DECREASE BY THIS VALUE

# Get brightness
function get_backlight
    brightnessctl -m | cut -d, -f4 | sed 's/%//'
end

# Get icons
function get_icon
    set current (get_backlight)
    if test $current -le 20
        set icon {$iDIR}/brightness-20.png
    else if test $current -le 40
        set icon {$iDIR}/brightness-40.png
    else if test $current -le 60
        set icon {$iDIR}/brightness-60.png
    else if test $current -le 80
        set icon {$iDIR}/brightness-80.png
    else
        set icon {$iDIR}/brightness-100.png
    end
end

# Notify
function notify_user
    notify-send -e -h string:x-canonical-private-synchronous:brightness_notif -h int:value:{$current} -u low -i $icon "Brightness : {$current}%"
end

# Change brightness
function change_backlight
    set current_brightness (get_backlight)

    # Calculate new brightness
    if test $argv[1] = "+"
        set new_brightness (math "$current_brightness + $step")
    else if test $argv[1] = "-"
        set new_brightness (math "$current_brightness - $step")
    end
    echo $new_brightness
    # Ensure new brightness is within valid range
    if test $new_brightness -lt 5
        set new_brightness 5
    else if test $new_brightness -gt 100
        set new_brightness 100
    end

    brightnessctl set {$new_brightness}%
    get_icon
    set -g current $new_brightness
    notify_user
end

# Execute accordingly
switch $argv[1]
    case "--get"
        get_backlight
    case "--inc"
        change_backlight "+"
    case "--dec"
        change_backlight "-"
    case '*'
        get_backlight
end
