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

function set_indent_mode(mode)
    if not indent_modes[mode] then
        print("Invalid indent mode " .. mode)
    else
        current_indent_mode = mode
        indent_mode_set_confs_curr()
    end
end

function next_indent_mode()
    current_indent_mode = indent_mode_next[current_indent_mode]
    indent_mode_set_confs_curr()
end

