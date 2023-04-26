local ok, cmp = pcall(require, "cmp")
if not ok then
  print("Could not load cmp plugin")
  return
end

cmp.setup({
  formatting = {
    fields = {'abbr', 'kind', 'menu'},
    format = require('lspkind').cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
    })
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = false}),
  }
})
