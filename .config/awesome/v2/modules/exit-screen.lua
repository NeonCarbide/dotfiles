local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local wibox = require('wibox')

local clickable_container = require('widgets.material.clickable-container')
local dpi = beautiful.xresources.apply_dpi

local apps = require('config.apps')
local icons = require('theme.icons')

local icon_size = beautiful.exit_screen_icon_size or dpi(140)

local function buildButton (icon)
    local _W = wibox.widget
    local abutton = _W{
        _W{
            _W{
                _W{
                    image = icon,
                    widget = _W.imagebox
                },
                top = dpi(16),
                bottom = dpi(16),
                left = dpi(16),
                right = dpi(16),
                widget = wibox.container.margin
            },
            shape = gears.shape.circle,
            forced_height = icon_size,
            forced_width = icon_size,
            widget = clickable_container
        },
        left = dpi(24),
        right = dpi(24),
        widget = wibox.container.margin
    }

    return abutton
end

function suspend_cmd ()
    exit_screen_hide()
    awful.spawn_with_shell(apps.default.lock .. ' & systemctl suspend')
end
function exit_cmd ()
    _G.awesome.quit()
end
function lock_cmd ()
    exit_screen_hide()
    awful.spawn_with_shell('sleep 1 && ' .. apps.default.lock)
end
function poweroff_cmd ()
    awful.spawn_with_shell('poweroff')
    awful.keygrabber.stop(_G.exit_screen_grabber)
end
function reboot_cmd ()
    awful.spawn_with_shell('reboot')
    awful.keygrabber.stop(_G.exit_screen_grabber)
end

local poweroff = buildButton(icons.power, 'Shutdown')
local reboot = buildButton(icons.restart, 'Restart')
local suspend = buildButton(icons.sleep, 'Sleep')
local exit = buildButton(icons.logout, 'Logout')
local lock = buildButton(icons.lock, 'Lock')

poweroff:connect_signal(
    'button::release',
    function ()
        poweroff_cmd()
    end
)
reboot:connect_signal(
    'button::release',
    function ()
        reboot_cmd()
    end
)
suspend:connect_signal(
    'button::release',
    function ()
        suspend_cmd()
    end
)
exit:connect_signal(
    'button::release',
    function ()
        exit_cmd()
    end
)
lock:connect_signal(
    'button::release',
    function ()
        lock_cmd()
    end
)

local screen_geometry = awful.screen.focused().geometry

exit_screen = wibox({
    screen = 1,
    x = screen_geometry.x,
    y = screen_geometry.y,
    visible = false,
    ontop = true,
    type = 'splash',
    height = screen_geometry.height,
    width = screen_geometry.width
})

exit_screen.bg = beautiful.background.hue_800 .. 'dd'
exit_screen.fg = beautiful.exit_screen_fg or beautiful.wibar_fg or '#fefefe'

local exit_screen_grabber

function exit_screen_hide ()
    awful.keygrabber.stop(exit_screen_grabber)
    exit_screen.visible = false
end

function exit_screen_show ()
    exit_screen_grabber = awful.keygrabber.run(
        function (_, key, event)
            if event == 'release' then
                return
            end

            if key == 's' then
                suspend_cmd()
            elseif key == 'e' then
                exit_cmd()
            elseif key == 'l' then
                lock_cmd()
            elseif key == 'p' then
                poweroff_cmd()
            elseif key == 'r' then
                reboot_cmd()
            elseif key == 'Escape' or key == 'q' or key == 'x' then
                exit_screen_hide()
            end
        end
    )
    exit_screen.visible = true
end

exit_screen:buttons(
    gears.table.join(
        awful.button{
            modifiers   = {},
            button      = 2,
            on_press    = function ()
                exit_screen_hide()
            end
        },
        awful.button{
            modifiers   = {},
            button      = 3,
            on_press    = function ()
                exit_screen_hide()
            end
        }
    )
)

exit_screen:setup {
    nil,
    {
        nil,
        {
            poweroff,
            reboot,
            suspend,
            exit,
            lock,
            layout = wibox.layout.fixed.horizontal
        },
        nil,
        expand = 'none',
        layout = wibox.layout.align.horizontal
    },
    nil,
    expand = 'none',
    layout = wibox.layout.align.vertical
}
