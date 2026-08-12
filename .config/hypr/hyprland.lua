-- Monitor, keyboard-specific shortcuts
require("device_specific")

-- Set programs that you use
local terminal = "kitty"
local browser = "helium-browser"
local alternatebrowser = "google-chrome-stable"
local passwordmanager = "keepassxc"
local launcher = "rofi -show drun"

--############################
--## ENVIRONMENT VARIABLES ###
--############################

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "12")
hl.env("HYPRCURSOR_THEME", "catppuccin-mocha-dark")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULES", "wayland;fcitx;ibus")
hl.env("XMODIFIERS", "@im=fcitx")

hl.permission({ binary = "/usr/(bin|local/bin)/hyprpm", type = "plugin", mode = "allow" })

hl.config({
    plugin = {
        hyprexpo = {
            columns = 3,
            gaps_out = 5,
            border_width = 2,

            bg_col = "rgb(111111)",
            workspace_method = "first 1", -- [center/first] [workspace] e.g. first 1 or center m+1,

            label_enable = 0,

            border_color_current = "rgba(33ccffee) rgba(00ff99ee) 45deg",
            border_color_focus = "rgb(ffcc66)",
            border_color_hover = "rgb(aabbcc)",

            gesture_distance = 300,

            keynav_enable = 1,
            number_key_mode = passthrough,
            keynav_wrap_h = 1,
            keynav_wrap_v = 1,
            keynav_reading_order = 0,
        },
    },
})

hl.define_submap("hyprexpo", function()
    hl.bind("h",      function() hl.plugin.hyprexpo.kb_focus("left") end)
    hl.bind("l",      function() hl.plugin.hyprexpo.kb_focus("right") end)
    hl.bind("k",      function() hl.plugin.hyprexpo.kb_focus("up") end)
    hl.bind("j",      function() hl.plugin.hyprexpo.kb_focus("down") end)
    hl.bind("return", function() hl.plugin.hyprexpo.kb_confirm() end)
    hl.bind("escape", function() hl.plugin.hyprexpo.expo("cancel") end)
    hl.bind("SUPER + g", function() hl.plugin.hyprexpo.expo("cancel") end)
end)

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 7,
    bezier = "myBezier",
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 7,
    bezier = "default",
    style = "popin 80%",
})
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 10,
    bezier = "default",
})
hl.animation({
    leaf = "borderangle",
    enabled = true,
    speed = 8,
    bezier = "default",
})
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 7,
    bezier = "default",
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 6,
    bezier = "default",
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

local mainMod = "SUPER"

hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("fish -c \"randwallpaper ~/.config/hypr/wallpapers\""), { locked = true })
hl.bind(mainMod .. " + SHIFT + ALT + W", hl.dsp.exec_cmd("fish -c \"randwallpaper ~/.config/papers/other\""), { locked = true })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(launcher))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(alternatebrowser))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(passwordmanager))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprpicker --autocopy"))
hl.bind(mainMod .. " + V", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("[float; size 30% 30%; center 1] " .. terminal .. " fish -c \"tty-clock -Ssct -C 4\""))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("~/.config/hypr/scripts/open_lf.fish"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("~/.config/hypr/scripts/open_nvim.fish"))

hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("reboot"), { locked = true })

hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd("hyprlock & sleep 0.5 && systemctl suspend"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume +1"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume -1"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locked = true })

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })

hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window -o ~/screenshots"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region -o ~/screenshots"))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + h", hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + l", hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + k", hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + j", hl.dsp.window.alter_zorder({ mode = "top" }))

hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))

hl.bind(mainMod .. " + bracketLeft", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + bracketRight", hl.dsp.focus({ workspace = "e+1" }))

-- Move to different workspace 
hl.bind("ALT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind("ALT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind("ALT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind("ALT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind("ALT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind("ALT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind("ALT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind("ALT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind("ALT + 9", hl.dsp.window.move({ workspace = 9 }))

-- Scratchpad
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Caps Lock + Left Mouse Buttom moves, Right Mouse Button resizes
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- Toggle opaque for active window
-- If you want terminal fully opaque, also run kitten @ set-background-opacity 1.0
local function toggle_transparency()
    local current = hl.get_config("decoration:active_opacity")

    if current and current >= 1.0 then
        -- Set to transparent (e.g., 0.8)
        hl.config({
            decoration = {
                active_opacity = 0.93,
                inactive_opacity = 0.7,
                fullscreen_opacity = 1.0
            }
        })
    else
        -- Reset to fully opaque (1.0)
        hl.config({
            decoration = {
                active_opacity = 1.0,
                inactive_opacity = 1.0,
                fullscreen_opacity = 1.0
            }
        })
    end
end
hl.bind(mainMod .. " + SHIFT + T", toggle_transparency)

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + G", function()
    hl.plugin.hyprexpo.expo("toggle")
end)

hl.window_rule({
    name = "suppress-maximize-events",
    match = {
        class = ".*",
        float = "tile",
    },
    -- Ignore maximize requests from all apps. You'll probably like this.
    suppress_event = "maximize",
    -- No floating windows
})

hl.window_rule({
    match = {
        class = "^(ghidra-.*)$",
    },
    opaque = true,
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    -- Fix some dragging issues with XWayland
    no_focus = true,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = {
        class = "hyprland-run",
    },
    move = "20 monitor_h-120",
    float = true,
})

hl.config({
    cursor = {
        hide_on_key_press = true,
        no_hardware_cursors = 1,
    },
    general = {
        gaps_in = 7.5,
        gaps_out = 15,
        border_size = 0,
        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,
        -- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false,
        layout = "dwindle",
    },
    -- https://wiki.hyprland.org/Configuring/Variables/#decoration
    decoration = {
        rounding = 15,
        -- Change transparency of focused and unfocused windows
        active_opacity = 0.93,
        inactive_opacity = 0.7,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        -- https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
            enabled = true,
            size = 4,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    -- Default animations
    animations = {
        enabled = true,
    },
    -- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    dwindle = {
        preserve_split = true, -- You probably want this
    },
    -- Don't need these with hyprpaper
    misc = {
        force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
    --############
    --## INPUT ###
    --############
    -- https://wiki.hyprland.org/Configuring/Variables/#input
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "caps:super",
        kb_rules = "",
        -- Cursor doesn't affect focus unless mouse is pressed
        follow_mouse = 2,
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
        touchpad = {
            natural_scroll = false,
            middle_button_emulation = true,
            scroll_factor = 0.8,
            clickfinger_behavior = true,
        },
    },
    -- Prevents things like VMs from grabbing Hyprland keybinds
    binds = {
        disable_keybind_grabbing = true,
    },
    xwayland = {
        force_zero_scaling = true,
    },
})

hl.on("hyprland.start", function()
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("hyprpm reload")
end)

