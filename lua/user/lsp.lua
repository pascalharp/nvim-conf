-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>lk', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>lwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>lf', vim.lsp.buf.formatting)
  vim.keymap.set('n', '<leader>lci', vim.lsp.buf.incoming_calls)
  vim.keymap.set('n', '<leader>lco', vim.lsp.buf.outgoing_calls)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

local border = {
      {"╭", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╮", "FloatBorder"},
      {"│", "FloatBorder"},
      {"╯", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╰", "FloatBorder"},
      {"│", "FloatBorder"},
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local lspconf = require('lspconfig')

local capabilities = {}
local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not ok then
  vim.notify("Unable to get capabilities from cmp_nvim_lsp")
else
  capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

lspconf['pyright'].setup{
  on_attach = on_attach,
  capabilities = capabilities
}

local ok_rust_tools, rust_tools = pcall(require, "rust-tools")
if ok_rust_tools then
  rust_tools.setup({
    server = {
      on_attach = on_attach,
      capabilities = capabilities,
    },
  })
else
  print("Could not load rust tools. Falling back to plain rust_analyzer")
  lspconf['rust_analyzer'].setup{
    on_attach = on_attach,
    capabilities = capabilities
  }
end

local ok_clangd_extras, clangd_extras = pcall(require, "clangd_extensions")
if ok_clangd_extras then
  clangd_extras.setup({
    server = {
      on_attach = on_attach,
      capabilities = capabilities,
    },
  })
else
  print("Could not load clangd extras. Falling back to plain clangd")
  lspconf['clangd'].setup{
    on_attach = on_attach,
    capabilities = capabilities
  }
end

lspconf['sumneko_lua'].setup{
  on_attach = on_attach,
  capabilities, capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
