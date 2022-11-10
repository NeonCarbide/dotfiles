local with_dpi = require("beautiful").xresources.apply_dpi
local get_dpi = require("beautiful").xresources.get_dpi

local rofi_command = "env /usr/bin/rofi -dpi " .. get_dpi() .. " -width " .. with_dpi(320) .. " -show drun -run-command '/bin/bash -c -i \"shopt -s expand_aliases; {cmd}\"'"

local default = {
        browser = "vivaldi-stable",
        editor = "nvim",
        files = "dolphin",
        rofi = rofi_command,
        terminal = "alacritty"
}

default.editor_cmd = default.terminal .. " -e " .. default.editor

return default
