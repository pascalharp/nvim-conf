-- Shortcut to vim functions
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup({
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- General lib required by lots
    use 'nvim-lua/plenary.nvim'

    -- Icons for nice looks
    use 'kyazdani42/nvim-web-devicons'

    -- Treesitter
    use "nvim-treesitter/nvim-treesitter"

    -- undotree
    use "mbbill/undotree"

    -- Colorscheme
    use {
      "ellisonleao/gruvbox.nvim",
      config = function()
        require("gruvbox").setup({
          overrides = {
            FloatBorder = { bg = "#282828", fg = "#D78101" },
            NormalFloat = { bg = "#282828" }
          }
        })
        vim.o.background = "dark"
        vim.cmd([[colorscheme gruvbox]])
      end
    }

    -- File explorer
    use {
      'kyazdani42/nvim-tree.lua',
      config = function()
        require('user.nvim-tree')
      end
    }

    use 'preservim/tagbar'

    -- Nice view of buffers on the top
    use {
      'akinsho/bufferline.nvim',
      tag = "v2.*",
      config = function() require('bufferline').setup() end
    }

    -- Just amazing
    use {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.0',
      config = function()
        require('telescope').setup({
          defaults = {
            i = {
              ["<C-h>"] = "which_key",
            }
          },
          extensions = {
            ['ui-select'] = require("telescope.themes").get_dropdown({}),
            emoji = {
              action = function(emoji)
                vim.api.nvim_put({ emoji.value }, 'c', false, true)
              end
            }
          }
        })
        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("emoji")
      end
    }

    use { 'nvim-telescope/telescope-ui-select.nvim' }

    use { 'xiyaowong/telescope-emoji.nvim' }


    -- Better status line
    use {
      'nvim-lualine/lualine.nvim',
      config = function() require('lualine').setup({}) end
    }

    -- lsp
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},
            {'onsails/lspkind.nvim'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        },
        config = function() require('user.lsp') end
    }

    -- rust lsp extras
    use 'simrat39/rust-tools.nvim'

    -- clangd extras
    use  'p00f/clangd_extensions.nvim'

    -- indentline
    use "lukas-reineke/indent-blankline.nvim"

    -- Tool to display key shortcuts
    use {
      "folke/which-key.nvim",
      config = function() require("user.which-key") end
    }

    -- Show git nicely
    use {
      'lewis6991/gitsigns.nvim',
      config = function() require("gitsigns").setup() end
    }

    -- Git Tools
    use "tpope/vim-fugitive"

    -- Terminal that keeps state
    use {
      "akinsho/toggleterm.nvim",
      tag = 'v2.*',
      config = function()
        require("toggleterm").setup({
          float_opts = {
            border = 'curved',
            width = function() return math.floor(vim.o.columns * 0.9) end,
            height = function() return math.floor(vim.o.lines * 0.8) end,
          }
        })
      end
    }

    use {
        'ggandor/leap.nvim',
        config = function() require('leap').add_default_mappings() end
    }

    use {
        "sindrets/diffview.nvim"
    }

    use {
      'gorbit99/codewindow.nvim',
      config = function()
        local codewindow = require('codewindow')
        codewindow.setup()
      end,
    }

    use {
      'jbyuki/venn.nvim'
    }

    -- Automatically set up configuration after cloning packer.nvim only on bootstrap
    if PACKER_BOOTSTRAP then
      require('packer').sync()
    end
  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    }
  }
})
