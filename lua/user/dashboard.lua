local ok, db = pcall(require, "dashboard")
if not ok then
  print("Could not load dashboard")
  return
end

local home = os.getenv('HOME')

db.preview_command = 'cat | lolcat -F 0.3'
db.preview_file_path = home .. '/.config/nvim/static/neocat.txt'
db.preview_file_height = 19
db.preview_file_width = 40

db.custom_center = {
  { icon = '📂', desc = 'Find file', action = 'Telescope find_files' },
  { icon = '🔎', desc = 'Live Grep', action = 'Telescope live_grep' },
}
