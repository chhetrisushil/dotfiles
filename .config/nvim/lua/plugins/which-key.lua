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
    require("which-key").add({
      { "<leader>b", group = "Buffer commands", desc = "Buffer commands", remap = false },
      { "<leader>bd", "<cmd>bd<CR>", desc = "Delete current buffer", remap = false },
      { "<C-l>", "<cmd>nohl<CR>", desc = "No highlight", remap = false, mode = "n" },
    })
  end
}
