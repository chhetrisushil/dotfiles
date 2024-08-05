-- load extensions for telescope
local status_ok, telescope = pcall(require, 'telescope')

if not status_ok then
  return
end

-- set this variable if you want to change the repo listing path. Use `:lua workspace_loc='<path you want to look for repos>'`
workspace_loc = '~/workspace'

telescope.load_extension('fzf')
telescope.load_extension('file_browser')
telescope.load_extension('repo')
telescope.load_extension('dap')
telescope.load_extension('notify')

local status_ok, wk = pcall(require, 'which-key')

if not status_ok then
  return
end

wk.add({
  { "<C-p>", ":lua require'telescope.builtin'.find_files()<cr>", desc = "Find files" },
  { "<leader>f", group = "Telescope" },
  { "<leader>fb", ":lua require'telescope.builtin'.buffers()<cr>", desc = "Find buffers" },
  { "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in current buffer" },
  { "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "File explorer" },
  { "<leader>ff", ":lua require'telescope.builtin'.find_files({hidden = true})<cr>", desc = "Find files (include hidden)" },
  { "<leader>fg", ":lua require'telescope.builtin'.live_grep()<cr>", desc = "Find files with grep" },
  { "<leader>fh", ":lua require'telescope.builtin'.help_tags()<cr>", desc = "Help tags" },
  { "<leader>lc", "<cmd>Telescope repo cached_list<cr>", desc = "Open cached repo list" },
  { "<leader>lr", function () require'telescope'.extensions.repo.list{search_dirs={workspace_loc}} end, desc = "Open repo list" },
})
