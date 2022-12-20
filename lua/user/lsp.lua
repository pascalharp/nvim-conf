-- lsp-zero setup
local lsp = require('lsp-zero')
lsp.preset('recommended')

-- I want my own
lsp.set_preferences({
  set_lsp_keymaps = false
})

-- Custom on attach function for keybinds
lsp.on_attach(function(client, bufnr)
  local bufopts = {buffer = bufnr, remap = false}
  -- local bufopts = { noremap=true, silent=true, buffer=bufnr }

  -- Shorten function name
  local map = vim.keymap.set

  -- Telescope bindings
  local ok_tel, telescope = pcall(require, "telescope.builtin")
  if ok_tel then
      map("n", "<leader>d", telescope.lsp_definitions, bufopts)
      map("n", "<leader>r", telescope.lsp_references, bufopts)
  end

  map('n', '<leader>lD', vim.lsp.buf.declaration, bufopts)
  map('n', '<leader>ld', vim.lsp.buf.definition, bufopts)
  map('n', 'K', vim.lsp.buf.hover, bufopts)
  map('n', '<leader>li', vim.lsp.buf.implementation, bufopts)
  map('n', '<leader>lk', vim.lsp.buf.signature_help, bufopts)
  map('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, bufopts)
  map('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, bufopts)
  map('n', '<leader>lwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  map('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  map('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
  map('n', '<leader>la', vim.lsp.buf.code_action, bufopts)
  map('n', '<leader>lf', vim.lsp.buf.formatting)
  map('n', '<leader>lci', vim.lsp.buf.incoming_calls)
  map('n', '<leader>lco', vim.lsp.buf.outgoing_calls)
end)

lsp.nvim_workspace()
lsp.setup()

--local border = {
--      {"╭", "FloatBorder"},
--      {"─", "FloatBorder"},
--      {"╮", "FloatBorder"},
--      {"│", "FloatBorder"},
--      {"╯", "FloatBorder"},
--      {"─", "FloatBorder"},
--      {"╰", "FloatBorder"},
--      {"│", "FloatBorder"},
--}
--
--local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
--function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--  opts = opts or {}
--  opts.border = opts.border or border
--  return orig_util_open_floating_preview(contents, syntax, opts, ...)
--end
--
--local lspconf = require('lspconfig')
--
--local capabilities = {}
--local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
--if not ok then
--  vim.notify("Unable to get capabilities from cmp_nvim_lsp")
--else
--  capabilities = cmp_nvim_lsp.default_capabilities()
--end
--
--lspconf['pyright'].setup{
--  on_attach = on_attach,
--  capabilities = capabilities
--}
--
--local ok_rust_tools, rust_tools = pcall(require, "rust-tools")
--if ok_rust_tools then
--  rust_tools.setup({
--    server = {
--      on_attach = on_attach,
--      capabilities = capabilities,
--    },
--  })
--else
--  print("Could not load rust tools. Falling back to plain rust_analyzer")
--  lspconf['rust_analyzer'].setup{
--    on_attach = on_attach,
--    capabilities = capabilities
--  }
--end
--
--local ok_clangd_extras, clangd_extras = pcall(require, "clangd_extensions")
--if ok_clangd_extras then
--  clangd_extras.setup({
--    server = {
--      on_attach = on_attach,
--      capabilities = capabilities,
--    },
--  })
--else
--  print("Could not load clangd extras. Falling back to plain clangd")
--  lspconf['clangd'].setup{
--    on_attach = on_attach,
--    capabilities = capabilities
--  }
--end
--
--lspconf['sumneko_lua'].setup{
--  on_attach = on_attach,
--  capabilities, capabilities,
--  settings = {
--    Lua = {
--      runtime = {
--        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--        version = 'LuaJIT',
--      },
--      diagnostics = {
--        -- Get the language server to recognize the `vim` global
--        globals = {'vim'},
--      },
--      workspace = {
--        -- Make the server aware of Neovim runtime files
--        library = vim.api.nvim_get_runtime_file("", true),
--      },
--      -- Do not send telemetry data containing a randomized but unique identifier
--      telemetry = {
--        enable = false,
--      },
--    },
--  },
--}
--
--lspconf['texlab'].setup {
--    on_attach = on_attach,
--    capabilities = capabilities,
--}
--
--lspconf['ltex'].setup {
--    on_attach = on_attach,
--    capabilities = capabilities,
--    filetype = { "bib", "gitcommit", "markdown", "plaintex", "tex", "latex" },
--    settings = {
--        ltex = {
--            enabled = { "latex", "markdown", "tex" },
--        }
--    }
--}
