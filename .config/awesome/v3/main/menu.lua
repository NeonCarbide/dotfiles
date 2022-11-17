local awful = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup').widget

local beautiful = require('beautiful')

local rc    = {}
rc.vars     = require('main.user-vars')

local M     = {}
local _M    = {}

M.awesome   = {
    { 'hotkeys', function ()
        hotkeys_popup.show_help(nil, awful.screen.focused())
    end },
    { 'manual', rc.vars.terminal .. ' -e man awesome' },
    { 'edit config', rc.vars.editor_cmd .. " " .. awesome.conffile },
    { 'open a terminal', rc.vars.terminal },
    { 'restart awesome', awesome.restart },
    { 'quit awesome', function () awesome.quit() end }
}

function _M.get ()
    local menu_items    = {
        { 'awesome', M.awesome, beautiful.awesome_subicon },
        { 'open a terminal', rc.vars.terminal }
    }

    return menu_items
end

return setmetatable({}, { __call = function (_, ...) return _M.get(...) end })
