return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = {
    { "echasnovski/mini.icons", opts = {} },
  },
  keys = {
    { "<leader>o",   "",                     desc = "+Oil" },
    { "<leader>oe", "<cmd>Oil --float<cr>", desc = "Open parent folder" },
  },
}
