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
  map('n', '<leader>lf', vim.lsp.buf.format)
  map('n', '<leader>lci', vim.lsp.buf.incoming_calls)
  map('n', '<leader>lco', vim.lsp.buf.outgoing_calls)
end)

lsp.nvim_workspace()
lsp.setup()

-- Load cmp configurations
local ok_cmp, _ = pcall(require, "user.cmp")
if not ok_cmp then
    print("Could not load cmp config file")
end
