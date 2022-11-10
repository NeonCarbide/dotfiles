local filesystem = require("gears.filesystem")

local with_dpi = require("beautiful").xresources.apply_dpi
local get_dpi = require("beautiful").xresources.get_dpi
local rofi_command = "env /usr/bin/rofi -dpi" .. get_dpi() .. " -width " .. with_dpi(400) .. " -show drun -theme " .. filesystem.get_configuration_dir() .. "/config/rofi.rasi -run-command '/bin/bash -c -i \"shopt -s expand_aliases; {cmd}\"'"

return {
    default = {
        browser = "vivaldi",
        editor = "nvim",
        editor_cmd = terminal .. " -e " .. editor,
        files = "dolphin",
        music = rofi_command,
        rofi = rofi_command,
        social = "discord",
        terminal = "alacritty",
    },

    run_on_start_up = {
        "picom --config" .. filesystem.get_configuration_dir() .. "/config/picom.conf",
        "numlockx on",
        "~/.config/awesome/config/awspawn"
    }
}
