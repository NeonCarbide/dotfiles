local gears = require('gears')
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")

local mat_colors = require('theme.mat-colors')

local dpi = xresources.apply_dpi
local gfs = gears.filesystem
local theme_dir = gfs.get_configuration_dir() .. '/theme'

local theme = {}

theme.font = "JetBrainsMono Nerd Font 9"
--theme.font          = "Hack Nerd Font 9"
theme.icons = theme_dir .. '/icons/'

theme.accent = mat_colors.pink
theme.background = mat_colors.grey
theme.primary = mat_colors.deep_orange

local awesome_overrides = function (theme)
    theme.dir = os.getenv('HOME') .. '/.config/awesome/theme'
    theme.icons = theme.dir .. '/icons/'
    theme.wallpaper = '#e0e0e0'
    theme.font = 'JetBrainsMono Nerd Font 9'
    theme.title_font = 'JetBrainsMono Nerd Font 11'

    theme.fg_normal     = "#aaaaaa"
    theme.fg_focus      = "#ffffff"
    theme.fg_urgent     = "#ffffff"
    theme.fg_minimize   = "#ffffff"

    theme.bg_normal     = "#222222"
    theme.bg_focus      = "#535d6c"
    theme.bg_urgent     = "#ff0000"
    theme.bg_minimize   = "#444444"
    theme.bg_systray    = theme.bg_normal

    --theme.useless_gap   = dpi(4)
    theme.border_width  = dpi(2)
    theme.border_normal = "#000000"
    theme.border_focus  = "#535d6c"
    theme.border_marked = "#91231c"

    theme.menu_height   = dpi(16)
    theme.menu_width    = dpi(160)

    theme.tooltip_bg    = ''
    theme.tooltip_border_width = 0
    theme.tooltip_shape = function (cr, w, h)
        gears.shape.rounded_rect(cr, w, h, dpi(6))
    end

    -- Generate taglist squares:
    local taglist_square_size = dpi(4)
    theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
        taglist_square_size, theme.fg_normal
    )
    theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
        taglist_square_size, theme.fg_normal
    )

    theme.titlebar_close_button_normal = theme_dir.."default/titlebar/close_normal.png"
    theme.titlebar_close_button_focus  = theme_dir.."default/titlebar/close_focus.png"

    theme.titlebar_minimize_button_normal = theme_dir.."default/titlebar/minimize_normal.png"
    theme.titlebar_minimize_button_focus  = theme_dir.."default/titlebar/minimize_focus.png"

    theme.titlebar_ontop_button_normal_inactive = theme_dir.."default/titlebar/ontop_normal_inactive.png"
    theme.titlebar_ontop_button_focus_inactive  = theme_dir.."default/titlebar/ontop_focus_inactive.png"
    theme.titlebar_ontop_button_normal_active = theme_dir.."default/titlebar/ontop_normal_active.png"
    theme.titlebar_ontop_button_focus_active  = theme_dir.."default/titlebar/ontop_focus_active.png"

    theme.titlebar_sticky_button_normal_inactive = theme_dir.."default/titlebar/sticky_normal_inactive.png"
    theme.titlebar_sticky_button_focus_inactive  = theme_dir.."default/titlebar/sticky_focus_inactive.png"
    theme.titlebar_sticky_button_normal_active = theme_dir.."default/titlebar/sticky_normal_active.png"
    theme.titlebar_sticky_button_focus_active  = theme_dir.."default/titlebar/sticky_focus_active.png"

    theme.titlebar_floating_button_normal_inactive = theme_dir.."default/titlebar/floating_normal_inactive.png"
    theme.titlebar_floating_button_focus_inactive  = theme_dir.."default/titlebar/floating_focus_inactive.png"
    theme.titlebar_floating_button_normal_active = theme_dir.."default/titlebar/floating_normal_active.png"
    theme.titlebar_floating_button_focus_active  = theme_dir.."default/titlebar/floating_focus_active.png"

    theme.titlebar_maximized_button_normal_inactive = theme_dir.."default/titlebar/maximized_normal_inactive.png"
    theme.titlebar_maximized_button_focus_inactive  = theme_dir.."default/titlebar/maximized_focus_inactive.png"
    theme.titlebar_maximized_button_normal_active = theme_dir.."default/titlebar/maximized_normal_active.png"
    theme.titlebar_maximized_button_focus_active  = theme_dir.."default/titlebar/maximized_focus_active.png"

    -- You can use your own layout icons like this:
    theme.layout_fairh = theme_dir.."default/layouts/fairhw.png"
    theme.layout_fairv = theme_dir.."default/layouts/fairvw.png"
    theme.layout_floating  = theme_dir.."default/layouts/floatingw.png"
    theme.layout_magnifier = theme_dir.."default/layouts/magnifierw.png"
    theme.layout_max = theme_dir.."default/layouts/maxw.png"
    theme.layout_fullscreen = theme_dir.."default/layouts/fullscreenw.png"
    theme.layout_tilebottom = theme_dir.."default/layouts/tilebottomw.png"
    theme.layout_tileleft   = theme_dir.."default/layouts/tileleftw.png"
    theme.layout_tile = theme_dir.."default/layouts/tilew.png"
    theme.layout_tiletop = theme_dir.."default/layouts/tiletopw.png"
    theme.layout_spiral  = theme_dir.."default/layouts/spiralw.png"
    theme.layout_dwindle = theme_dir.."default/layouts/dwindlew.png"
    theme.layout_cornernw = theme_dir.."default/layouts/cornernww.png"
    theme.layout_cornerne = theme_dir.."default/layouts/cornernew.png"
    theme.layout_cornersw = theme_dir.."default/layouts/cornersww.png"
    theme.layout_cornerse = theme_dir.."default/layouts/cornersew.png"

    -- Generate Awesome icon:
    theme.awesome_icon = theme_assets.awesome_icon(
        theme.menu_height, theme.bg_focus, theme.fg_focus
    )
end

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return {
    theme = theme,
    awesome_overrides = awesome_overrides
}

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
