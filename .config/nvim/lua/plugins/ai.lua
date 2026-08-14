return {
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "franco-ruggeri/codecompanion-spinner.nvim",
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
        display = {
          chat = {
            window = {
              position = "right",
              width = 0.3,
            },
          },
        },
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_result_in_chat = true,
            },
          },
          spinner = { enabled = true },
        },
      })
    end,
  },
  {
    {
      "coder/claudecode.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("claudecode").setup({})

        -- Toggle the agent panel
        vim.keymap.set("n", "<leader>cc", ":ClaudeCode<CR>", { desc = "Toggle Claude Code" })

        -- Send selected visual code block as context to the CLI
        vim.keymap.set("v", "<leader>cs", ":' CreteContext<CR>", { desc = "Send selection to Claude" })
      end,
    },
  },
}
