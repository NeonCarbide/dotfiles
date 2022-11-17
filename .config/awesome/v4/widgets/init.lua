local awful         = require'awful'
local gears         = require'gears'
local hotkeys_popup = require'awful.hotkeys_popup'

local beautiful     = require'beautiful'

local wibox         = require'wibox'

local apps      = require'config.apps'

local current_theme = 'themes.' .. require'config.vars'.theme .. '.theme'
local theme     = require(current_theme)

local layoutbox = require'widgets.layoutbox'
local taglist   = require'widgets.taglist'
local tasklist  = require'widgets.tasklist'

local _M = {}

_M.awesomemenu = {
   {'hotkeys', function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
   {'manual', apps.manual_cmd},
   {'edit config', apps.editor_cmd .. ' ' .. awesome.conffile},
   {'restart', awesome.restart},
   {'quit', awesome.quit},
}

_M.mainmenu = awful.menu{
   items = {
      {'awesome', _M.awesomemenu, beautiful.awesome_icon},
      {'open terminal', apps.terminal}
   }
}

_M.launcher = awful.widget.launcher{
   image = beautiful.awesome_icon,
   menu = _M.mainmenu
}

_M.systray  = wibox.widget{
    {
        wibox.widget.systray(),
        left    = theme.menu_height / 4,
        right   = theme.menu_height / 4,
        bottom  = theme.menu_height / 8,
        top     = theme.menu_height / 8,
        widget  = wibox.container.margin,
    },
    bg          = beautiful.bg_normal,
    shape       = gears.shape.rectangle,
    shape_clip  = true,
    widget      = wibox.container.background,
}

_M.textclock      = wibox.widget{
    format  = ' [ %d-%m-%y ] ~ ( %H:%M ) ',
    widget  = wibox.widget.textclock()
}

_M.keyboardlayout = awful.widget.keyboardlayout()

function _M.create_promptbox()
    return awful.widget.prompt()
end

function _M.create_layoutbox(s)
   return awful.widget.layoutbox{
      screen = s,
      buttons = layoutbox.buttons,
   }
end

function _M.create_taglist(s)
   return awful.widget.taglist{
      screen = s,
      filter = awful.widget.taglist.filter.all,
      buttons = taglist.buttons,
      style = taglist.style,
      layout = taglist.layout,
      widget_template = taglist.widget_template,
   }
end

function _M.create_tasklist(s)
   return awful.widget.tasklist{
      screen = s,
      filter = awful.widget.tasklist.filter.currenttags,
      buttons = tasklist.buttons,
      style = tasklist.style,
      layout = tasklist.layout,
      widget_template = tasklist.widget_template,
   }
end

function _M.create_wibox(s)
   return awful.wibar{
      screen = s,
      position = 'top',
      widget = {
         layout = wibox.layout.align.horizontal,
         expand = 'none',
         -- left widgets
         {
            layout = wibox.layout.fixed.horizontal,
            --_M.launcher,
            s.layoutbox,
            s.taglist,
            s.promptbox,
         },
         -- middle widgets
         s.tasklist,
         -- right widgets
         {
            layout = wibox.layout.fixed.horizontal,
            --wibox.widget.systray(),
            _M.systray,
            --_M.keyboardlayout,
            _M.textclock,
         }
      }
   }
end

return _M
