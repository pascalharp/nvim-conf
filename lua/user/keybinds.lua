local opts = { noremap = true, silent = true }

-- Shorten function name
local map = vim.keymap.set

-- Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
map("n", "<C-c>", "<cmd>bd<cr>", opts)
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

-- Move line up and down normal mode
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)

-- Move line up and down insert mode
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Move line up and down in visual and block mode
map("x", "<A-j>", ":move '>+1<CR>gv=gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv=gv", opts)

-- Diagnostics
map('n', '[<space>', vim.diagnostic.goto_prev, opts)
map('n', ']<space>', vim.diagnostic.goto_next, opts)

-- Toggle indent mode
local ok_uti, utils = pcall(require, "user.utils")
if ok_uti then
    map("n", "<A-t>", utils.next_indent_mode)
    map("n", "<A-s>", utils.toggle_spell_check)
else
    print("Could not find utils")
end

-- Toggle explorer
local ok_nt, nvim_tree = pcall(require, "nvim-tree")
if ok_nt then
  map("n", "F", function() nvim_tree.toggle(false, true) end, opts)
else
  print("Could not find nvim_tree when setting up keybinds")
end

-- Toggle Tagbar
map("n", "T", "<cmd>TagbarToggle<cr>", opts)

-- Telescope bindings
local ok_tel, telescope = pcall(require, "telescope.builtin")
if ok_tel then
  map("n", "<leader>f", telescope.find_files, opts)
  map("n", "<leader>g", telescope.live_grep, opts)
  map("n", "<leader>b", telescope.buffers, opts)
  map("n", "<leader>h", telescope.help_tags, opts)
  map("n", "<leader>d", telescope.lsp_definitions, opts)
  map("n", "<leader>r", telescope.lsp_references, opts)
  map("n", "<leader>j", telescope.jumplist, opts)
  map("n", "<leader>vf", telescope.git_files, opts)
  map("n", "<leader>vc", telescope.git_commits, opts)
  map("n", "<leader>vb", telescope.git_branches, opts)
  map("n", "<leader>vs", telescope.git_status, opts)
  map("n", "<leader>vS", telescope.git_stash, opts)
  map("n", "<leader>e", "<cmd>Telescope emoji<cr>", opts)
else
  print("Could not find telescope when setting up keybinds")
end

-- ToggleTerm bindings
local ok_tt, toggleterm = pcall(require, "toggleterm")
if ok_tt then
  map("t", "<Esc>", "<C-\\><C-n>", opts)
  map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  map("n", "<leader>t", function() toggleterm.toggle(1, 20, ".", "float") end, opts)
  map("n", "<leader>T", function() toggleterm.toggle(1, 10, ".", "horizontal") end, opts)
else
  print("Could not find toggleterm when setting up keybinds")
end
