lua << EOF
  local status_ok, wk = pcall(require, "which-key")

  if not status_ok then
      return
  end

  wk.setup {
    plugins = {
      spelling = {
        enabled = true,
      }
    },
    win = {
      border = "double",
      wo = {
        winblend = 30
      }
    }
  }

  wk.add({
    {"<space>bd", "<cmd>bdelete<CR>", desc = "Delete current buffer", remap = false}
  })
EOF
