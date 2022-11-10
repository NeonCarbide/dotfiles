local opts = {
    noremap = true,
    silent = true
}

-- shorten function name
local keymap = vim.api.nvim_set_keymap

-- map leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.localleader = " "

-- normal
-- better split navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- buffer navigation
keymap("n", "<leader>bb", ":buffers<cr>", opts)
keymap("n", "<leader>bd", ":Bdelete<cr>", opts)
keymap("n", "<leader>bn", ":bnext<cr>", opts)
keymap("n", "<leader>bv", ":bprevious<cr>", opts)

-- faster quitting
keymap("n", "<leader>q", "ZZ", opts)
keymap("n", "<leader>Q", "ZQ", opts)

-- faster saving
keymap("n", "<leader>w", ":write<cr>", opts)

-- split resizing
keymap("n", "<C-Up>", ":resize +2<cr>", opts)
keymap("n", "<C-Down>", ":resize -2<cr>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<cr>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<cr>", opts)

-- move text up and down
keymap("n", "<A-j>", "<esc>:move .+1<cr>==gi", opts)
keymap("n", "<A-k>", "<esc>:move .-2<cr>==gi", opts)

-- faster navigation
keymap("n", "H", "^", opts)
keymap("n", "J", "L", opts)
keymap("n", "K", "H", opts)
keymap("n", "L", "$", opts)

-- telescope keybinds
keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<C-t>", ":Telescope live_grep<cr>", opts)

-- nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- visual
-- move text up and down
keymap("v", "<A-j>", ":move .+1<cr>==", opts)
keymap("v", "<A-k>", ":move .-2<cr>==", opts)

-- don't yank pasted over text
keymap("v", "p", '"_dP', opts)

-- stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- visual block
-- move text up and down
keymap("x", "<A-j>", ":move '>+1<cr>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<cr>gv-gv", opts)

