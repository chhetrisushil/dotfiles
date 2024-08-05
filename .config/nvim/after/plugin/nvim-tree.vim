nnoremap <silent> <C-d> :NvimTreeToggle<CR>

set termguicolors " this variable must be enabled for colors to be applied properly

lua << EOF
local status_ok, nt = pcall(require, 'nvim-tree')

if not status_ok then
    return
end

nt.setup{
  disable_netrw        = false,
  respect_buf_cwd      = true,
  hijack_netrw         = true,
  auto_reload_on_write = true,
  open_on_tab          = false,
  hijack_cursor        = false,
  update_cwd           = false,
  hijack_unnamed_buffer_when_opening = false,
  hijack_directories   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = true,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    side = 'left',
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes"
  },
  renderer = {
    add_trailing = true,
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = "all",
    root_folder_modifier = ":~",
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      padding = " ",
      symlink_arrow = " >> ",
      show = {
        file = true,
        folder =true,
        folder_arrow = true,
        git = true
      },
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌"
        },
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        }
      }
    },
    special_files = { "Cargo.toml", "Makefile", "MAKEFILE", "README.md", "readme.md", "Readme.md" }
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  },
  actions = {
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", },
          buftype  = { "nofile", "terminal", "help", },
        }
      }
    }
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      git = false,
    },
  },
}

local wk_status_ok, wk = pcall(require, 'which-key')

if not wk_status_ok then
  return
end

wk.add({
  {"<leader>n", group = "nvim-tree"},
  {"<leader>nf", "<cmd>NvimTreeFindFile<CR>", desc = "Find file in nvim-tree"},
  {"<leader>nr", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh nvim-tree"},
})

EOF
