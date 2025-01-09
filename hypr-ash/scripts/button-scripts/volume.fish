#!/usr/bin/env fish

# Scripts for volume controls for audio and mic
set iDIR {$HOME}/.config/swaync/icons
set sDIR {$HOME}/.config/hypr/scripts

# Get Volume
function get_volume
    set volume (pamixer --get-volume)
    if test $volume -eq 0
        echo Muted
    else
        echo "{$volume}%"
    end
end

# Get icons
function get_icon
    set current (get_volume)
    echo $current
    switch $current
        case "Muted"
            echo "{$iDIR}/volume-mute.png"
        case -lt "30"
            echo "{$iDIR}/volume-low.png"
        case -lt "60"
            echo "{$iDIR}/volume-mid.png"
        case
            echo "{$iDIR}/volume-high.png"
    end
end

# Notify
function notify_user
    if test (get_volume) = "Muted"
        #notify-send -e -h string:x-canonical-private-synchronous:volume_notif -u low -i (get_icon) "Volume: Muted"
    else
        #notify-send -e -h int:value:(string replace '%' '' -- (get_volume)) -h string:x-canonical-private-synchronous:volume_notif -u low -i (get_icon) "Volume: (get_volume)"
        #"{$sDIR}/Sounds.sh" --volume
    end
end

# Increase Volume
function inc_volume
    if test (pamixer --get-mute) = "true"
        toggle_mute
    else
        pamixer -i 5 --allow-boost --set-limit 150; #and notify_user
    end
end

# Decrease Volume
function dec_volume
    if test (pamixer --get-mute) = "true"
        toggle_mute
    else
        pamixer -d 5; and notify_user
    end
end

# Toggle Mute
function toggle_mute
    if test (pamixer --get-mute) = "false"
        pamixer -m; #and notify-send -e -u low -i "$iDIR/volume-mute.png" "Volume Switched OFF"
    else if test (pamixer --get-mute) = "true"
        pamixer -u; #and notify-send -e -u low -i (get_icon) "Volume Switched ON"
    end
end

# Toggle Mic
function toggle_mic
    if test (pamixer --default-source --get-mute) = "false"
        pamixer --default-source -m; #and notify-send -e -u low -i "$iDIR/microphone-mute.png" "Microphone Switched OFF"
    else if test (pamixer --default-source --get-mute) = "true"
        pamixer --default-source -u; #and notify-send -e -u low -i "$iDIR/microphone.png" "Microphone Switched ON"
    end
end

# Get Mic Icon
function get_mic_icon
    set current (pamixer --default-source --get-volume)
    if test "$current" -eq 0
        echo "$iDIR/microphone-mute.png"
    else
        echo "$iDIR/microphone.png"
    end
end

# Get Microphone Volume
function get_mic_volume
    set volume (pamixer --default-source --get-volume)
    if test "$volume" -eq 0
        echo Muted
    else
        echo "$volume%"
    end
end

# Notify for Microphone
function notify_mic_user
    set volume (get_mic_volume)
    set icon (get_mic_icon)
    #notify-send -e -h int:value:(string replace '%' '' -- $volume) -h "string:x-canonical-private-synchronous:volume_notif" -u low -i "$icon" "Miclevel: $volume"
end

# Increase MIC Volume
function inc_mic_volume
    if test (pamixer --default-source --get-mute) = "true"
        toggle_mic
    else
        pamixer --default-source -i 5; and notify_mic_user
    end
end

# Decrease MIC Volume
function dec_mic_volume
    if test (pamixer --default-source --get-mute) = "true"
        toggle_mic
    else
        pamixer --default-source -d 5; and notify_mic_user
    end
end

# Execute accordingly
switch $argv[1]
    case "--get"
        get_volume
    case "--inc"
        inc_volume
    case "--dec"
        dec_volume
    case "--toggle"
        toggle_mute
    case "--toggle-mic"
        toggle_mic
    case "--get-icon"
        get_icon
    case "--get-mic-icon"
        get_mic_icon
    case "--mic-inc"
        inc_mic_volume
    case "--mic-dec"
        dec_mic_volume
    case '*'
        get_volume
end
