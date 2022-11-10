local _K = {}

_K.client = {
    key = require("keymaps.client.key"),
    mouse = require("keymaps.client.mouse")
}

_K.global = {
    key = require("keymaps.global.key"),
    mouse = require("keymaps.global.mouse")
}

_K.mod = require("keymaps.mod")

return _K
