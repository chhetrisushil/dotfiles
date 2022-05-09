lua << EOF
  require("which-key").setup {
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
