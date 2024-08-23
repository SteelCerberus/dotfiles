#!/usr/bin/env fish

set -l battery_percentage $(cat /sys/class/power_supply/BAT0/capacity)
set -l battery_status $(cat /sys/class/power_supply/BAT0/status)

# Define the battery icons for each 10% segment
set -l battery_icons 󰂃 󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰁹

# Define the charging icon
set -l charging_icon 󰂄

# Calculate the index for the icon array
set -l icon_index $(math floor (math $battery_percentage / 10))

# Get the corresponding icon
set battery_icon $battery_icons[$icon_index]

# Check if the battery is charging
if test $battery_status = "Charging"
    set battery_icon $charging_icon
end

# Output the battery percentage and icon
echo "$battery_percentage% $battery_icon"
