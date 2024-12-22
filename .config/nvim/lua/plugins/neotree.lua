return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    "folke/which-key.nvim",
  },
  config = function()
    local neotree = require("neo-tree")
    local wk = require("which-key")

    neotree.setup({
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
      },
      buffers = { follow_current_file = { enable = true } },
    })

    wk.add({
      { "<C-d>", "<cmd>Neotree toggle<CR>", desc = "Neotree" },
    })
  end,
}
