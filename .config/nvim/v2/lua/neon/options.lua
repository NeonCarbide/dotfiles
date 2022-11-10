local options = {
    backup = false,
    swapfile = false,
    writebackup = false,

    clipboard = "unnamedplus",
    undofile = true,

    fileencoding = "utf-8",

    number = true,
    relativenumber = true,
    numberwidth = 6,
    showtabline = 2,
    signcolumn = "yes",

    cursorline = true,

    autoindent = true,
    expandtab = true,
    shiftwidth = 4,
    softtabstop = 4,

    backspace = "indent,eol,start",

    scrolloff = 8,
    sidescrolloff = 8,

    splitbelow = true,
    splitright = true,

    list = true,

    --colorcolumn = "80",
    termguicolors = true,
    wrap = false,

    hlsearch = false,
    incsearch = true,
    ignorecase = true,
    smartcase = true,
    showmatch = true,

    cmdheight = 2,
    pumheight = 10,
    showcmd = true,
    showmode = false,

    completeopt = { "menuone", "noselect" },
    updatetime = 500,
}

vim.cmd [[set iskeyword+=-]]
vim.cmd "set listchars=tab:>\\ ,trail:~,extends:#,nbsp:."

for key, val in pairs(options) do
    vim.opt[key] = val
end

