local ok, _ = pcall(require, "gruvbox")
if ok then
  vim.o.background = "dark"
  vim.cmd([[colorscheme gruvbox]])
else
  print("Could not load gruvbox. Not installed")
end
