#!/usr/bin/env fish

function i -d "Show generic info"
    echo "Date:      $(set_color magenta) $(date +'%A, %B %_e')$(set_color normal)"

    echo "Time:      $(set_color green) $(date +%r)$(set_color normal)"
    set -l battery_percentage $(cat /sys/class/power_supply/BAT0/capacity)
    set -l battery_status $(cat /sys/class/power_supply/BAT0/status)

    # Define the battery icons for each 10% segment
    set -l battery_icons (set_color red)󰂃 (set_color red)󰁺 (set_color red)󰁻 (set_color yellow)󰁼 (set_color yellow)󰁽 (set_color yellow)󰁾 (set_color yellow)󰁿 (set_color green)󰂀 (set_color green)󰂁 (set_color green)󰁹

    # Define the charging icon
    set -l charging_icon (set_color green)󰂄

    # Calculate the index for the icon array
    set -l icon_index $(math floor (math $battery_percentage / 10))

    # Get the corresponding icon
    set battery_icon $battery_icons[$icon_index]

    # Check if the battery is charging
    if test $battery_status = "Charging"
        set battery_icon $charging_icon
    end

    echo "Battery:   $battery_icon $battery_percentage% ($battery_status)$(set_color normal)"

    set -l connection_status $(nmcli -t general status | string split : | head -n 1)
    if test $connection_status = "connected"
        set -l active_conn $(nmcli -g NAME c show --active | awk '$0 !~ /lo/')
        echo "Internet:  $(set_color blue)󰖩 Connected to $active_conn$(set_color normal)"
    else
        echo "Internet:  $(set_color red)󱚵 Disconnected$(set_color normal)"
    end
end
