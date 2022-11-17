local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

require "neon.lsp.mason"
require("neon.lsp.handlers").setup()
require "neon.lsp.null-ls"
