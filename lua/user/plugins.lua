-- Shortcut to vim functions
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- General lib required by lots
  use 'nvim-lua/plenary.nvim'

  -- Icons for nice looks
  use 'kyazdani42/nvim-web-devicons'

  -- Treesitter
  use "nvim-treesitter/nvim-treesitter"

  -- Colorscheme
  use "ellisonleao/gruvbox.nvim"

  -- File explorer
  use {
    'kyazdani42/nvim-tree.lua',
    config = require('nvim-tree').setup()
  }

  -- Nice view of buffers on the top
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    config = require('bufferline').setup()
  }

  -- Just amazing
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    config = require('telescope').setup()
  }

  -- Better status line
  use {
    'nvim-lualine/lualine.nvim',
    config = require('lualine').setup()
  }

  -- lsp
  use {
    'neovim/nvim-lspconfig',
    config = require('user.lsp')
  }

  -- indentline
  use "lukas-reineke/indent-blankline.nvim"

  -- Automatically set up configuration after cloning packer.nvim only on bootstrap
  if packer_bootstrap then
    require('packer').sync()
  end
end)
