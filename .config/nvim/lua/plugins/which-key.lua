return {
  "folke/which-key.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "echasnovski/mini.nvim",
  },
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = flase })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    local hipatterns = require("mini.hipatterns")

    -- Setup
    hipatterns.setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })

    -- Keymaps
    require("which-key").add({
      { "<leader>b",  group = "Buffer commands", desc = "Buffer commands",       remap = false },
      { "<leader>bd", "<cmd>bd<CR>",             desc = "Delete current buffer", remap = false },
      { "<C-l>",      "<cmd>nohl<CR>",           desc = "No highlight",          remap = false, mode = "n" },
    })
  end,
}
