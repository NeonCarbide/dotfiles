local awful = require'awful'
local ruled = require'ruled'

local tags  = require'config.vars'.tags

ruled.client.connect_signal('request::rules', function()
    -- All clients will match this rule.
    ruled.client.append_rule{
        id          = 'global',
        rule        = {},
        properties  = {
            focus       = awful.client.focus.filter,
            raise       = true,
            screen      = awful.screen.preferred,
            placement   = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    }

    -- Floating clients.
    ruled.client.append_rule{
        id          = 'floating',
        rule_any    = {
            instance    = {
                'copyq',
                'pinentry'
            },
            class       = {
                'Arandr',
                'Blueman-manager',
                'Gpick',
                'Kruler',
                'Sxiv',
                'Tor Browser',
                'Wpa_gui',
                'veromix',
                'xtightvncviewer',
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name        = {
                'Event Tester',  -- xev.
            },
            role        = {
                'AlarmWindow',     -- Thunderbird's calendar.
                'ConfigManager',  -- Thunderbird's about:config.
                'pop-up',            -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties  = {
            floating = true
        }
    }

    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule{
        id          = 'titlebars',
        rule_any    = {
            type = {
                'normal',
                'dialog'
            }
        },
        properties  = {
            titlebars_enabled = false
        }
    }

    -- tag 2
    ruled.client.append_rule{
        rule_any    = {
            class   = {
                'firefox',
                'Vivaldi-stable',
            }
        },
        properties  = {screen = 1, tag = tags[2]}
    }

    -- tag 3
    ruled.client.append_rule{
        rule_any    = {
            class   = {
                'discord',
            }
        },
        properties  = {screen = 1, tag = tags[3]}
    }

    -- tag 4
    ruled.client.append_rule{
        rule_any    = {
            class   = {
                'Spotify',
            }
        },
        properties  = {screen = 1, tag = tags[4]}
    }

    -- tag 5
    ruled.client.append_rule{
        rule_any    = {
            class   = {
                'vlc',
            }
        },
        properties  = {screen = 1, tag = tags[5]}
    }

    -- tag 6
    ruled.client.append_rule{
        rule_any    = {
            class   = {
                'Steam',
            }
        },
        properties  = {screen = 1, tag = tags[6]}
    }
end)
