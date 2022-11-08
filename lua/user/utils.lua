-- Table to return
local M = {}

-- For custom pickers
local t_pickers = require "telescope.pickers"
local t_finders = require "telescope.finders"
local t_conf = require("telescope.config").values
local t_actions = require "telescope.actions"
local t_action_state = require "telescope.actions.state"

-- Toggle indent modes
local current_indent_mode = "Four Spaces"
local indent_modes = {
    ["Two Spaces"] = {
        tabstop = 2,
        shiftwidth = 2,
        softtabstop = 2,
        expandtab = true,
    },
    ["Four Spaces"] = {
        tabstop = 4,
        shiftwidth = 4,
        softtabstop = 4,
        expandtab = true,
    },
    ["Eight Spaces"] = {
        tabstop = 8,
        shiftwidth = 8,
        softtabstop = 8,
        expandtab = true,
    },
    ["True Tab Four"] = {
        tabstop = 4,
        shiftwidth = 4,
        softtabstop = 4,
        expandtab = false,
    },
    ["True Tab Eight"] = {
        tabstop = 8,
        shiftwidth = 8,
        softtabstop = 8,
        expandtab = false,
    },
}

local indent_mode_next = {
    ["Two Spaces"] = "Four Spaces",
    ["Four Spaces"] = "Eight Spaces",
    ["Eight Spaces"] = "True Tab Four",
    ["True Tab Four"] = "True Tab Eight",
    ["True Tab Eight"] = "Two Spaces",
}

local function indent_mode_set_confs_curr()
  local confs = indent_modes[current_indent_mode]
  for k,v in pairs(confs) do
    vim.opt[k] = v
  end
  print("Indent Mode set to: " .. current_indent_mode)
end

function M.set_indent_mode(mode)
  if not indent_modes[mode] then
    print("Invalid indent mode " .. mode)
  else
    current_indent_mode = mode
    indent_mode_set_confs_curr()
  end
end

function M.next_indent_mode()
  current_indent_mode = indent_mode_next[current_indent_mode]
  indent_mode_set_confs_curr()
end

function M.pick_indent_mode(opts)
  local input = {}
  for k, _ in pairs(indent_modes) do
    input[#input+1] = k
  end

  opts = opts or {}
  t_pickers.new(opts, {
    prompt_title = "Indent Mode Picker",
    finder = t_finders.new_table {
      results = input,
    },
    sorter = t_conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      t_actions.select_default:replace(function()
        t_actions.close(prompt_bufnr)
        local selection = t_action_state.get_selected_entry()
        M.set_indent_mode(selection[1])
      end)
      return true
    end,
  }):find()
end

-- Toggle spell check
function M.toggle_spell_check()
  vim.opt.spell = not(vim.opt.spell:get())
end

return M
