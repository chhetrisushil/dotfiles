return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- "nvim-treesitter/nvim-treesitter-context",
  },
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      highlight = {
        enable = true,
        disable = {},
      },
      indent = {
        enable = true,
        disable = {},
      },
      sync_install = false,
      ensure_installed = {
        "tsx",
        "toml",
        "fish",
        "php",
        "json",
        "yaml",
        "swift",
        "html",
        "scss",
        "vimdoc",
        "lua",
        "javascript",
        "typescript",
        "query",
        "markdown",
        "markdown_inline",
      },
      auto_install = true,
      autotag = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<localleader>vs",
          node_incremental = "<localleader>vs",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["acc"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["a="] = "@assignment.outer",
            ["i="] = "@assignment.inner",
            ["alh"] = "@assignment.lhs",
            ["arh"] = "@assignment.rhs",
            ["aro"] = "@pattern.outer",
            ["ari"] = "@pattern.inner",
            ["aco"] = "@conditional.outer",
            ["aci"] = "@conditional.inner",
            ["alo"] = "@loop.outer",
            ["ali"] = "@loop.inner",
          },
        },
      },
    })

    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
  end,
}
