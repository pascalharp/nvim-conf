local opts = { noremap = true, silent = true }

-- Shorten function name
local map = vim.keymap.set

-- Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General (Normal Mode)

-- Better window navigation
map("n", "<C-c>", ":q<cr>", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
map("n", "<A-l>", ":bnext<CR>", opts)
map("n", "<A-h>", ":bprevious<CR>", opts)

-- General (Visual Mode)

-- Move text up and down
map("v", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
map("v", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- General (Visual Block Mode)

-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)
map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Diagnostics
map('n', '<leader>e', vim.diagnostic.open_float, opts)
map('n', '[', vim.diagnostic.goto_prev, opts)
map('n', ']', vim.diagnostic.goto_next, opts)
map('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Toggle explorer
local ok, nvim_tree = pcall(require, "nvim-tree")
if ok then
  map("n", "F", function() nvim_tree.toggle(false, true) end, opts)
  map("n", "<leader>e", function() nvim_tree.toggle(false, true) end, opts)
else
  print("Could not find nvim_tree when setting up keybinds")
end

-- Telescope bindings
local ok, telescope = pcall(require, "telescope.builtin")
if ok then
  map("n", "<leader>f", telescope.find_files, opts)
  map("n", "<leader>g", telescope.live_grep, opts)
  map("n", "<leader>b", telescope.buffers, opts)
  map("n", "<leader>h", telescope.help_tags, opts)
  map("n", "<leader>d", telescope.lsp_definitions, opts)
  map("n", "<leader>r", telescope.lsp_references, opts)
  map("n", "<leader>gf", telescope.git_files, opts)
else
  print("Could not find telescope when setting up keybinds")
end
