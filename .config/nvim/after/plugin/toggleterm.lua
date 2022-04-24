local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup({
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

-- set custom mappings for terminal
function _G.set_terminal_keymaps()
  local opts = {noremap = true }

  vim.api.nvim_buf_set_keymap(0, 't', '<C-J>', [[<C-\><C-n>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local node = Terminal:new({ cmd = "node", hidden = true })

function _NODE_TOGGLE()
  node:toggle()
end

local gtop = Terminal:new({ cmd = "gtop", hidden = true })

function _GTOP_TOGGLE()
  gtop:toggle()
end

local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true })

function _LAZYDOCKER_TOGGLE()
  lazydocker:toggle()
end

local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then
  return
end

wk.register({
  t = {
    name = "ToggleTerm",
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node Terminal" },
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazygit Terminal" },
    h = { "<cmd>lua _GTOP_TOGGLE()<cr>", "Gtop Terminal" },
    d = { "<cmd>lua _LAZYDOCKER_TOGGLE()<cr>", "Lazydocker Terminal" },
  }
}, {prefix = "<leader>"})
