return {
  "olimorris/codecompanion.nvim",
  event = "VeryLazy",
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "github/copilot.vim",
    {
      "ravitemer/mcphub.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      build = "npm install -g mcp-hub@latest",
      config = function()
        require("mcphub").setup()
      end,
    },
  },
  config = function()
    require("codecompanion").setup({
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
      },
    })
  end,
}
