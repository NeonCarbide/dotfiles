local awful = require("awful")
local ruled = require("ruled")

local notify = ruled.notification

notify.connect_signal("request::rules", function ()
    notify.append_rule{
        rule        = {},
        properties  = {
            screen              = awful.screen.preferred,
            implicit_timeout    = 5
        }
    }
end)
