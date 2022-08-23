local ok, wk = pcall(require, "which-key")

if not ok then
  print("Could not load whick-key")
  return
end

wk.setup({
  layout = { align = "center" },
})

wk.register({
  e = { "Toggle File Explorer" },
  f = { "Find File" },
  g = { "Live Grep" },
  b = { "Buffers" },
  h = { "Help Tags" },
  d = { "Go to Definition" },
  D = { "Type Definition"},
  r = { "Show References" },
  v = {
    name = "Versioning",
    f = { "Git Files" },
  },
  l = {
    name = "LSP (when attached)",
    D = "Declaration",
    d = "Definition",
    i = "Implementation",
    k = "Signature Help",
    w = {
      name = "Workspace features",
      a = "Add Workspace",
      r = "Remove Workspace",
      l = "List Workspace",
    },
    r = "Rename Variable",
    a = "Code Action",
  }
},
{
  prefix = "<leader>"
})
