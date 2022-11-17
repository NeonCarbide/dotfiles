local awful = require'awful'

local beautiful = require'beautiful'

local wibox = require'wibox'

require'awful.autofocus'

local connect = client.connect_signal

connect('focus', function(c)
    if c.maximized_horizontal == true and c.maximized_vertical == true then
        c.border_color = beautiful.border_normal
        return
    end
    c.border_color = beautiful.border_focus
end)

connect('unfocus', function(c)
    c.border_color = beautiful.border_normal
end)

-- focus first tag with clients after closing all clients in a tag
connect('unmanage', function(c)
    local t = c.first_tag or awful.screen.focused().selected_tag
    for _, cl in ipairs(t:clients()) do
        if cl ~= c then
            return
        end
    end

    for _, t in ipairs(awful.screen.focused().tags) do
        if #t:clients() > 0 then
            t:view_only()
            return
        end
    end
end)

connect('mouse::enter', function(c)
   c:activate{context = 'mouse_enter', raise = false}
end)

connect('request::titlebars', function(c)
   -- buttons for the titlebar
   local buttons = {
      awful.button{
         modifiers = {},
         button    = 1,
         on_press  = function()
            c:activate{context = 'titlebar', action = 'mouse_move'}
         end
      },
      awful.button{
         modifiers = {},
         button    = 3,
         on_press  = function()
            c:activate{context = 'titlebar', action = 'mouse_resize'}
         end
      },
   }

   awful.titlebar(c).widget = {
      -- left
      {
         awful.titlebar.widget.iconwidget(c),
         buttons = buttons,
         layout  = wibox.layout.fixed.horizontal,
      },
      -- middle
      {
         -- title
         {
            align = 'center',
            widget = awful.titlebar.widget.titlewidget(c),
         },
         buttons = buttons,
         layout  = wibox.layout.flex.horizontal,
      },
      -- right
      {
         awful.titlebar.widget.floatingbutton(c),
         awful.titlebar.widget.maximizedbutton(c),
         awful.titlebar.widget.stickybutton(c),
         awful.titlebar.widget.ontopbutton(c),
         awful.titlebar.widget.closebutton(c),
         layout = wibox.layout.fixed.horizontal()
      },
      layout = wibox.layout.align.horizontal,
   }
end)
