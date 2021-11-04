# -*- coding: utf-8 -*-

# IMPORTS
import os
import re
import socket
import subprocess

from libqtile import bar, layout, hook, qtile, widget
from libqtile.command import lazy
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.dgroups import simple_key_binder
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from typing import List  # noqa: F401

# VARIABLES
browser = "qutebrowser"
font_family = "FantasqueSansMono Nerd Font"
font_size = 12
mod = "mod4"
terminal = "alacritty"

# COLOURS
colors = [
    ["#1d2021", "#1d2021"],
    ["#cc241d", "#cc241d"],
    ["#98971a", "#98971a"],
    ["#d79921", "#d79921"],
    ["#458588", "#458588"],
    ["#b16286", "#b16286"],
    ["#689d6a", "#689d6a"],
    ["#a89984", "#a89984"],
    ["#928374", "#928374"],
    ["#fb4934", "#fb4934"],
    ["#b8bb26", "#b8bb26"],
    ["#fabd2f", "#fabd2f"],
    ["#83a598", "#83a598"],
    ["#d3869b", "#d3869b"],
    ["#8ec07c", "#83c07c"],
    ["#ebdbb2", "#ebdbb2"],
]

# KEYBINDINGS
keys = [
    ### Essential keybinds
    Key([mod, "control"], "Pause",
        lazy.restart(),
        desc = "Restart QTile",
    ),
    Key([mod, "mod1"], "Pause",
        lazy.shutdown(),
        desc = "Shutdown QTile",
    ),
    Key([mod], "c",
        lazy.window.kill(),
        desc = "Kill focused window",
    ),
    Key([mod, "shift"], "Return",
        lazy.spawn("dmenu_run -p 'run: '"),
        desc = "Launch run prompt",
    ),
    Key([mod], "Return",
        lazy.spawn(terminal),
        desc = "Launch terminal",
    ),
    Key([mod], "v",
        lazy.spawn(terminal + " -e vim"),
        desc = "Launch vim in terminal",
    ),
    Key([mod], "e",
        lazy.spawn("emacsclient -c -a emacs"),
        desc = "Launch Doom Emacs",
    ),
    Key([mod], "b",
        lazy.spawn(browser),
        desc = "Launch web browser",
    ),

    ### Window keybinds
    Key([mod], "h",
        lazy.layout.shrink(),
        lazy.layout.decrease_nmaster(),
        desc = "Shrink window (MonadTall); Decrease number in master pane (Tile)",
    ),
    Key([mod], "j",
        lazy.layout.down(),
        desc = "Move focus down in current stack pane",
    ),
    Key([mod], "k",
        lazy.layout.up(),
        desc = "Move focus up in current stack pane",
    ),
    Key([mod], "l",
        lazy.layout.grow(),
        lazy.layout.increase_nmaster(),
        desc = "Grow window (MonadTall); Increase number in master pane (Tile)",
    ),
    Key([mod, "shift"], "h",
        lazy.layout.swap_left(),
        desc = "Move window left",
    ),
    Key([mod, "shift"], "j",
        lazy.layout.section_down(),
        lazy.layout.shuffle_down(),
        desc = "Move windows down in current stack",
    ),
    Key([mod, "shift"], "k",
        lazy.layout.section_up(),
        lazy.layout.shuffle_up(),
        desc = "Move windows up in current stack",
    ),
    Key([mod, "shift"], "l",
        lazy.layout.swap_right(),
        desc = "Move window right",
    ),
    Key([mod], "n",
        lazy.layout.normalize(),
        desc = "Normalize window size ratios",
    ),
    Key([mod], "m",
        lazy.layout.maximize(),
        desc = "Toggle window between minimum and maximum sizes",
    ),
    Key([mod], "f",
        lazy.window.toggle_fullscreen(),
        desc = "Toggle fullscreen for focused window",
    ),
    Key([mod, "shift"], "f",
        lazy.window.toggle_floating(),
        desc = "Toggle floating for focused window",
    ),

    ### Layout keybinds
    Key([mod], "Tab",
        lazy.next_layout(),
        desc = "Toggle through layouts",
    ),
    Key([mod, "shift"], "Tab",
        lazy.layout.flip(),
        lazy.layout.rotate(),
        desc = "Switch which side master pane occupies (MonadTall); Rotate windows",
    ),
    Key([mod], "space",
        lazy.layout.next(),
        desc = "Switch focus to other pane(s) of stack",
    ),
    Key([mod, "shift"], "space",
        lazy.layout.toggle_split(),
        desc = "Toggle betweem split and unsplit sides of stack",
    ),
]

# WORKSPACES
groups = [Group(i) for i in "dwsocmvgx"]

dgroups_key_binder = simple_key_binder(mod)

# LAYOUT SETTINGS
layout_theme = {
    "border_width": 2,
    "margin": 4,
}

# LAYOUTS
layouts = [
    layout.MonadTall(
        **layout_theme,
        border_focus = colors[9],
        border_normal = colors[0],
    ),
    layout.Stack(
        **layout_theme,
        num_stacks = 2,
        border_focus = colors[11],
        border_normal = colors[0],
    ),
    layout.RatioTile(
        **layout_theme,
        border_focus = colors[10],
        border_normal = colors[0],
    ),
    layout.Max(**layout_theme),
]

# EXTENSION & WIDGET SETTINGS
widget_defaults = dict(
    background = colors[0],
    font = font_family,
    fontsize = font_size,
    foreground = colors[15],
    padding = 5,
)
extension_defaults = widget_defaults.copy()

groupbox_defaults = {
    "borderwidth": 3,
    "highlight_method": "block",
    "margin_x": 0,
    "margin_y": 3,
    "padding": 4,
    "rounded": False,
}

layout_icon_defaults = {
    "padding": 2,
    "scale": 0.5,
}
# WIDGETS
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Sep(
                    linewidth = 0,
                    padding = 6,
                ),
                widget.CurrentLayout(
                    **layout_icon_defaults,
                    fmt = "[ {:.2} ]",
                    foreground = colors[9],
                ),
                widget.Sep(
                    linewidth = 0,
                    padding = 6,
                ),
                widget.GroupBox(
                    **groupbox_defaults,
                    active = colors[11],
                    block_highlight_text_color = colors[0],
                    highlight_color = colors[11],
                    inactive = colors[8],
                    this_current_screen_border = colors[11],
                    this_screen_border = colors[3],
                ),
                widget.Prompt(),
                widget.Sep(
                    linewidth = 0,
                    padding = 40,
                ),
                widget.WindowName(
                    fmt = '{:.50}',
                    foreground = colors[11],
                    padding = 0,
                ),
                widget.Systray(
                ),
                widget.Sep(
                    linewidth = 0,
                    padding = 6,
                ),
                widget.TextBox(
                    background = colors[0],
                    fmt = '',
                    fontsize = 27,
                    foreground = colors[11],
                    padding = 0,
                ),
                widget.TextBox(
                    background = colors[11],
                    fmt = '',
                    fontsize = 14,
                    foreground = colors[0],
                ),
                widget.CPU(
                    background = colors[11],
                    foreground = colors[0],
                    format = '{load_percent}%',
                ),
                widget.TextBox(
                    background = colors[11],
                    fmt = '',
                    fontsize = 27,
                    foreground = colors[9],
                    padding = 0,
                ),
                widget.TextBox(
                    background = colors[9],
                    fmt = '',
                    fontsize = 14,
                    foreground = colors[0],
                ),
                widget.ThermalSensor(
                    background = colors[9],
                    fmt = '{}',
                    foreground = colors[0],
                    threshold = 90,
                ),
                widget.TextBox(
                    background = colors[9],
                    fmt = '',
                    fontsize = 27,
                    foreground = colors[11],
                    padding = 0,
                ),
                widget.TextBox(
                    background = colors[11],
                    fmt = '﬙',
                    fontsize = 14,
                    foreground = colors[0],
                ),
                widget.Memory(
                    background = colors[11],
                    foreground = colors[0],
                    format = '{MemPercent}%',
                ),
                widget.TextBox(
                    background = colors[11],
                    fmt = '',
                    fontsize = 27,
                    foreground = colors[9],
                    padding = 0,
                ),
                widget.TextBox(
                    background = colors[9],
                    fmt = '',
                    fontsize = 14,
                    foreground = colors[0],
                ),
                widget.Net(
                    background = colors[9],
                    foreground = colors[0],
                    format = '{down} ↓ {up} ↑',
                    interface = "wlp1s0",
                    use_bits = True,
                ),
                widget.TextBox(
                    background = colors[9],
                    fmt = '',
                    fontsize = 27,
                    foreground = colors[11],
                    padding = 0,
                ),
                widget.TextBox(
                    background = colors[11],
                    fmt = '奄',
                    fontsize = 14,
                    foreground = colors[0],
                ),
                widget.Volume(
                    background = colors[11],
                    foreground = colors[0],
                ),
                widget.TextBox(
                    background = colors[11],
                    fmt = '',
                    fontsize = 27,
                    foreground = colors[9],
                    padding = 0,
                ),
                widget.Wttr(
                    background = colors[9],
                    foreground = colors[0],
                    format = '%C %t %h',
                    location = {
                        "YYZ": "YYZ",
                    },
                ),
                widget.TextBox(
                    background = colors[9],
                    fmt = '',
                    fontsize = 27,
                    foreground = colors[11],
                    padding = 0,
                ),
                widget.Clock(
                    background = colors[11],
                    foreground = colors[0],
                    format = '%a ~ %_b %d %Y ~ %H:%M',
                ),
                widget.Sep(
                    linewidth = 0,
                    padding = 6,
                ),
            ],
            24,
        ),
    ),
]

# FUNCTIONS
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_app_rules = []  # type: List
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False

# Floating window rules
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# STARTUP
@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
