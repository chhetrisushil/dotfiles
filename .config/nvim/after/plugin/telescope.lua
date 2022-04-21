-- load extensions for telescope
local telescope = require 'telescope'

-- set this variable if you want to change the repo listing path. Use `:lua workspace_loc='<path you want to look for repos>'`
workspace_loc = '~/workspace'

telescope.load_extension('fzf')
telescope.load_extension('file_browser')
telescope.load_extension('repo')

local status_ok, wk = pcall(require, 'which-key')

if not status_ok then
  return
end

wk.register({
    ["<leader>f"] = {
        name = "Telescope",
        f = {":lua require'telescope.builtin'.find_files({hidden = true})<cr>", "Find files (include hidden)"},
        g = {":lua require'telescope.builtin'.live_grep()<cr>", "Find files with grep"},
        b = {":lua require'telescope.builtin'.buffers()<cr>", "Find buffers"},
        h = {":lua require'telescope.builtin'.help_tags()<cr>", "Help tags"},
    },
    ["<C-p>"] = {":lua require'telescope.builtin'.find_files()<cr>", "Find files"},
    ["<leader>lr"] = {function () require'telescope'.extensions.repo.list{search_dirs={workspace_loc}} end, "Open repo list"}
}, {nnoremap = true, silent = true})