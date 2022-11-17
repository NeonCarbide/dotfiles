local awful = require('awful')

local beautiful = require('beautiful')

local _M    = {}

function _M.get (clientkeys, clientbuttons)
    local rules = {
        -- default rule
        { rule  = {},
          properties    = {
                border_color    = beautiful.border_normal,
                border_width    = beautiful.border_width,
                focus           = awful.client.focus.filter,
                raise           = true,
                buttons         = clientbuttons,
                keys            = clientkeys,
                screen          = awful.screen.preferred,
                placement       = awful.placement.no_overlap + awful.placement.no_offscreen
            }
        },

        -- floating clients
        { rule_any = {
                class       = {
                    'Arandr',
                    'Blueman-manager',
                    'Gpick',
                    'Kruler',
                    'MessageWin',
                    'Sxiv',
                    'Tor Browser',
                    'Wpa_gui',
                    'veromix',
                    'xtightvncviewer',
                },
                instance    = {
                    'copyq',
                    'pinentry',
                },
                name        = {
                    'Event Tester'
                },
                role        = {
                    'AlarmWindow',
                    'ConfigManager',
                    'pop-up',
                }
            },
          properties    = {
            floating    = true
          }
        },

        -- add titlebars to normal clients and dialogs
        { rule_any = {
                type = {
                    'normal',
                    'dialog',
                },
            },
          properties    = {
            titlebars_enabled   = false
          }
        },
    }

    return rules
end

return setmetatable({}, { __call = function (_, ...) _M.get(...) end })
