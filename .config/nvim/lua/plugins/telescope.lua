return {
  { "nvim-telescope/telescope-ui-select.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/which-key.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "cljoly/telescope-repo.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = 'make' },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        }
      })

      local builtin = require("telescope.builtin")
      local wk = require("which-key")

      wk.add({
        { "<C-p>", builtin.find_files, desc = "Find files" },
        { "<leader>f", group = "Telescope" },
        { "<leader>fb", builtin.buffers, desc = "Find buffers" },
        { "<leader>fc", builtin.current_buffer_fuzzy_find, desc = "Find in current buffer" },
        { "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "File explorer" },
        { "<leader>ff", function() builtin.find_files({ hidden = true }) end, desc = "Find files (include hidden)" },
        { "<leader>fg", builtin.live_grep, desc = "Find files with grep" },
        { "<leader>fh", builtin.help_tags, desc = "Help tags" },
        { "<leader>fs", builtin.lsp_document_symbols, desc = "Symbols in current buffer" },
        { "<leader>lc", "<cmd>Telescope repo cached_list<cr>", desc = "Open cached repo list" },
        { "<leader>lr", function () telescope.extensions.repo.list{search_dirs={Workspace_loc}} end, desc = "Open repo list" },
        { "<leader><leader>", builtin.oldfiles, desc = "Old files" },
      })

      -- set this variable if you want to change the repo listing path. Use `:lua Workspace_loc='<path you want to look for repos>'`
      Workspace_loc = '~/workspace'

      telescope.load_extension("ui-select")
      telescope.load_extension('fzf')
      telescope.load_extension('file_browser')
      telescope.load_extension('repo')
      telescope.load_extension('notify')
    end
  },
}
