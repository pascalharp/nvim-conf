local ok, wk = pcall(require, "which-key")

if not ok then
  print("Could not load whick-key")
  return
end

wk.setup({
  layout = { align = "center" },
})

wk.register({
  e = { "Emojis" },
  f = { "Find File" },
  g = { "Live Grep" },
  b = { "Buffers" },
  h = { "Help Tags" },
  j = { "Jump List" },
  d = { "Go to Definition" },
  D = { "Type Definition" },
  r = { "Show References" },
  v = {
    name = "Versioning",
    c = { "Git Commits" },
    f = { "Git Files" },
    b = { "Git Branches" },
    s = { "Git Status" },
    S = { "Git Stash" },
  },
  l = {
    name = "LSP (when attached)",
    D = "Declaration",
    d = "Definition",
    i = "Implementation",
    k = "Signature Help",
    f = "Format file",
    c = {
      name = "Calls",
      i = "Incoming calls",
      o = "Outgoing calls",
    },
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
