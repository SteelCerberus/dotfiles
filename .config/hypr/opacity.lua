-- Toggle the global transparency
local function toggle_transparency()
    local current = hl.get_config("decoration:inactive_opacity")

    if current and current >= 1.0 then
        hl.config({
            decoration = {
                active_opacity = 1.0,
                inactive_opacity = 0.7,
                fullscreen_opacity = 1.0
            }
        })

        -- Toggle opacity for all running Kitty instances via unix sockets
        local handle = io.popen("find /tmp -maxdepth 1 -type s -name 'kitty-*' 2>/dev/null")
        if handle then
            for socket_path in handle:lines() do
                os.execute(string.format("kitten @ set-background-opacity --to unix:%s 0.7 >/dev/null 2>&1", socket_path))
            end
            handle:close()
        end
    else
        hl.config({
            decoration = {
                active_opacity = 1.0,
                inactive_opacity = 1.0,
                fullscreen_opacity = 1.0
            }
        })

        -- Toggle opacity for all running Kitty instances via unix sockets
        local handle = io.popen("find /tmp -maxdepth 1 -type s -name 'kitty-*' 2>/dev/null")
        if handle then
            for socket_path in handle:lines() do
                os.execute(string.format("kitten @ set-background-opacity --to unix:%s 1.0 >/dev/null 2>&1", socket_path))
            end
            handle:close()
        end
    end

end

hl.bind("SUPER + SHIFT + T", toggle_transparency)


-- Step individual Kitty or Hyprland window opacity
local function adjust_opacity(delta)
    local active_win = hl.get_active_window()
    if not active_win then return end

    if active_win.class == "kitty" then
        -- Send Ctrl+Shift+A followed by M (increase) or L (decrease) to Kitty
        local target_key = (delta > 0) and "M" or "L"
        hl.dispatch(hl.dsp.send_shortcut({ mods = "CTRL SHIFT", key = "A", window = hl.get_active_window() }))
        hl.dispatch(hl.dsp.send_shortcut({ mods = "", key = target_key, window = hl.get_active_window() }))
    else
        -- Adjust global active_opacity for non-Kitty windows
        local current = hl.get_config("decoration:active_opacity") or 1.0
        local next_val = math.max(0.1, math.min(1.0, current + delta))
        hl.config({ decoration = { active_opacity = next_val } })
    end
end

hl.bind("SUPER + Prior", function() adjust_opacity(0.05) end, { repeating = true })
hl.bind("SUPER + Next", function() adjust_opacity(-0.05) end, { repeating = true })


-- Step Hyprland inactive window opacity
local function adjust_inactive_opacity(delta)
    local current = hl.get_config("decoration:inactive_opacity") or 1.0
    local next_val = math.max(0.1, math.min(1.0, current + delta))
    hl.config({
        decoration = {
            inactive_opacity = next_val
        }
    })
end

hl.bind("SUPER + SHIFT + Prior", function() adjust_inactive_opacity(0.05) end, { repeating = true })
hl.bind("SUPER + SHIFT + Next", function() adjust_inactive_opacity(-0.05) end, { repeating = true })

