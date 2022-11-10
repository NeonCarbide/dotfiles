local awful = require("awful")
local ruled = require("ruled")

local client = ruled.client

client.connect_signal("request::rules", function ()
    client.append_rule{
        id          = "global",
        rule        = {},
        properties  = {
            focus       = awful.client.focus.filter,
            raise       = true,
            screen      = awful.screen.preferred,
            placement   = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    }

    client.append_rule{
        id          = "floating",
        rule_any    = {
            instance    = {"copyq", "pinentry"},
            class       = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "Sxiv",
                "Tor Browser",
                "Wpa_gui",
                "veromix",
                "xtightvncviewer"
            },
            name    = {"Event Tester"},
            role    = {
                "AlarmWindow",
                "ConfigManager",
                "pop-up"
            }
        },
        properties  = {floating = true}
    }

    client.append_rule{
        id          = "titlebars",
        rule_any    = {
            type = {"normal", "dialog"}
        },
        properties  = {titlebars_enabled = true}
    }

    client.append_rule{
        rule_any = {
            class = {
                "firefox",
                "qutebrowser",
                "Vivaldi-stable"
            }
        },
        properties = {tag = "W"}
    }

    client.append_rule{
        rule_any = {
            class = {"Spotify"}
        },
        properties = {tag = "M"}
    }

    client.append_rule{
        rule_any = {
            class = {"discord"}
        },
        properties = {tag = "C"}
    }

    client.append_rule{
        rule_any = {
            class = {
                "mpv",
                "vlc"
            }
        },
        properties = {tag = "V"}
    }

    client.append_rule{
        rule_any = {
            class = {"Steam"}
        },
        properties = {tag = "G"}
    }
end)
