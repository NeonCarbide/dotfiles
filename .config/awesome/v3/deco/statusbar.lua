local awful = require('awful')
local gears = require('gears')

local beautiful = require('beautiful')

local wibox = require('wibox')

local deco  = {}

deco.taglist    = require('deco.taglist')
deco.tasklist   = require('deco.tasklist')
deco.wallpaper  = require('deco.wallpaper')

local buttonmap         = awful.button
local taglist_buttons   = deco.taglist()
local tasklist_buttons  = deco.tasklist()

local rc    = {}
local menu  = require('main.menu')
rc.menu     = awful.menu({ items = menu() })
rc.launcher = awful.widget.launcher({
    image   = beautiful.awesome_icon,
    menu    = rc.menu
})

local _M    = {}

mytextclock = wibox.widget.textclock()

awful.screen.connect_for_each_screen(function (s)
    set_wallpaper(s)

    s.mylayoutbox   = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        buttonmap({}, 1, function () awful.layout.inc(1) end),
        buttonmap({}, 3, function () awful.layout.inc(-1) end),
        buttonmap({}, 4, function () awful.layout.inc(1) end),
        buttonmap({}, 5, function () awful.layout.inc(-1) end)
    ))

    s.mypromptbox   = awful.widget.prompt()

    s.mytaglist     = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    s.mytasklist    = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    s.mywibox      = awful.wibar({
        position    = 'top',
        screen      = s
    })

    s.mywibox:setup {
        layout  = wibox.layout.align.horizontal,
        {
            layout  = wibox.layout.fixed.horizontal,
            rc.launcher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist,
        {
            layout  = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        }
    }
end)
