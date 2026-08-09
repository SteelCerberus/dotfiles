-- Use the top one when running local LLM
-- hl.env("AQ_DRM_DEVICES", "/dev/dri/amd-igpu:/dev/dri/amd-9070xt")
hl.env("AQ_DRM_DEVICES", "/dev/dri/amd-9070xt:/dev/dri/amd-igpu")

hl.monitor({
    output = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. M27UP 0x01010101",
    mode = "3840x2160@160",
    position = "auto",
    scale = "1.5",
})

-- Change brightness - swayosd doesn't support DDC, so we have to use a custom command to fake the progress, while using ddcutil to actually control the brightness. Open issue: https://github.com/ErikReider/SwayOSD/issues/87
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("ddcutil --brief getvcp 10 | awk '{print $4}' | bc -l <<< \"scale=1; ($(cat)-10)/100\" | xargs -I {} swayosd-client --custom-progress {} --custom-icon display-brightness && ddcutil setvcp 10 - 10"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("ddcutil --brief getvcp 10 | awk '{print $4}' | bc -l <<< \"scale=1; ($(cat)+10)/100\" | xargs -I {} swayosd-client --custom-progress {} --custom-icon display-brightness && ddcutil setvcp 10 + 10"), { repeating = true })
hl.bind("F6", hl.dsp.exec_cmd("ddcutil --brief getvcp 10 | awk '{print $4}' | bc -l <<< \"scale=1; ($(cat)+10)/100\" | xargs -I {} swayosd-client --custom-progress {} --custom-icon display-brightness && ddcutil setvcp 10 + 10"), { repeating = true })
hl.bind("F5", hl.dsp.exec_cmd("ddcutil --brief getvcp 10 | awk '{print $4}' | bc -l <<< \"scale=1; ($(cat)-10)/100\" | xargs -I {} swayosd-client --custom-progress {} --custom-icon display-brightness && ddcutil setvcp 10 - 10"), { repeating = true })

