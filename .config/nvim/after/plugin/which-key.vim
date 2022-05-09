lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    plugins = {
      spelling = {
        enabled = true,
      }
    },
    window = {
      border = "double",
      winblend = 30
    }
  }
EOF
