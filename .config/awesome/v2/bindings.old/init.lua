local _K = {}

_K.client = {
    key = require("bindings.client.key"),
    mouse = require("bindings.client.mouse")
}

_K.global = {
    key = require("bindings.global.key"),
    mouse = require("bindings.global.mouse")
}

_K.mod = require("bindings.mod")

return _K
