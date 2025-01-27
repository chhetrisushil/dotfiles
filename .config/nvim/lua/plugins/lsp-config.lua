return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "biome",
          "lua_ls",
          "ts_ls",
          "denols",
          "bashls",
          "gopls",
          "html",
          "emmet_language_server",
          "nginx_language_server",
          "elmls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      biome = {
        filetypes = {
          "javascript",
          "javascriptreact",
          "json",
          "jsonc",
          "typescript",
          "typescript.tsx",
          "typescriptreact",
          "astro",
          "svelte",
          "vue",
          "css",
        },
      },
    },
    keys = {
      { "gd",         vim.lsp.buf.type_definition,      desc = "Type Definition",      remap = false },
      { "<leader>ca", vim.lsp.buf.code_action,          desc = "Code action",          remap = false },
      -- { "<leader>f", function() vim.lsp.buf.format({ async = true }) end, desc = "Formatting", remap = false },
      { "<leader>j",  vim.diagnostic.goto_next,         desc = "Goto Next Diagnostic", remap = false },
      { "<leader>k",  vim.diagnostic.goto_prev,         desc = "Goto Prev Diagnostic", remap = false },
      { "<leader>q",  vim.diagnostic.setloclist,        desc = "Loc list",             remap = false },
      -- { "<leader>rn", vim.lsp.buf.rename,               desc = "Rename variable",      remap = false },
      { "<leader>w",  group = "Workspace",              remap = false },
      { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "Add workspace",        remap = false },
      {
        "<leader>wl",
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        desc = "List workspace",
        remap = false,
      },
      { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove workspace", remap = false },
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- lua lsp config
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            hint = {
              enable = true,
              arrayIndex = "Enable",
              setType = true,
              paramType = true,
              returnType = true,
            },
          },
        },
      })

      -- Javascrip/Typescript lsp config
      lspconfig.denols.setup({})
      lspconfig.ts_ls.setup({
        settings = {
          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all",
              inlcudeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all",
              inlcudeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
        },
      })

      -- Go lsp config
      lspconfig.gopls.setup({
        settings = {
          gopls = {
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      })

      -- Bash lsp config
      lspconfig.bashls.setup({})

      -- HTML lsp config
      lspconfig.html.setup({})

      -- Emmet lsp config
      lspconfig.emmet_language_server.setup({
        filetypes = {
          "css",
          "eruby",
          "html",
          "javascript",
          "javascriptreact",
          "less",
          "sass",
          "scss",
          "pug",
          "typescriptreact",
        },
      })

      -- Nginx lsp config
      lspconfig.nginx_language_server.setup({})

      -- Elm lsp config
      lspconfig.elmls.setup({})
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    lazy = false,
    keys = {
      {
        "<localleader>vt",
        function()
          require("lsp_lines").toggle()
        end,
        desc = "Toggle virtual lines",
      },
    },
    config = true,
  },
}
