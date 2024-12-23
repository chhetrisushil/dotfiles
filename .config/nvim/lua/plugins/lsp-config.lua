return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "denols",
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/which-key.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local wk = require("which-key")

      -- keymaps
      wk.add({
        { "<leader>D", vim.lsp.buf.type_definition, desc = "Type Definition", remap = false },
        { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action", remap = false },
        -- { "<leader>f", function() vim.lsp.buf.format({ async = true }) end, desc = "Formatting", remap = false },
        { "<leader>j", vim.diagnostic.goto_next, desc = "Goto Next Diagnostic", remap = false },
        { "<leader>k", vim.diagnostic.goto_prev, desc = "Goto Prev Diagnostic", remap = false },
        { "<leader>q", vim.diagnostic.setloclist, desc = "Loc list", remap = false },
        { "<leader>rn", vim.lsp.buf.rename, desc = "Rename variable", remap = false },
        { "<leader>w", group = "Workspace", remap = false },
        { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "Add workspace", remap = false },
        { "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "List workspace", remap = false },
        { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove workspace", remap = false },
      })

      -- lua lsp config
      lspconfig.lua_ls.setup({})

      -- Javascrip/Typescript lsp config
      lspconfig.denols.setup({})
      lspconfig.ts_ls.setup({})
    end
  },
}
