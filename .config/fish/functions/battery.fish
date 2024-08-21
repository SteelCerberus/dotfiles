#!/usr/bin/env fish

function battery -d "Show battery info"
    set -l battery_path (find /sys/class/power_supply -name "BAT*")
    if test (count $battery_path) -eq 0
        echo "No battery found"
        return 1
    end

    echo "Battery level: $(cat $battery_path/capacity)% ($(cat $battery_path/status))"
end
