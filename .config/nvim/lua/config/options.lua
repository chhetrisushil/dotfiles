local opt = vim.o

opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.number = true
opt.relativenumber = true
opt.swapfile = false
opt.syntax = "on"
opt.smartindent = true
opt.autoindent = true
opt.copyindent = true
opt.ignorecase = true
opt.smartcase = true
opt.smarttab = true
opt.cursorline = true
opt.confirm = true

local g = vim.g

g.mapleader = " "
g.markdown_fence_languages = {
  "ts=typescript"
}
