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
    ["<C-p>"] = {":lua require'telescope.builtin'.find_files()<cr>", "Find files"}
}, {nnoremap = true, silent = true})
