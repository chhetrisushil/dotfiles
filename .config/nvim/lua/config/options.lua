local g = vim.g

g.mapleader = " "
g.maplocalleader = ";"
g.markdown_fence_languages = {
  "ts=typescript",
}

local opt = vim.o

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.termguicolors = true
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
opt.undofile = true

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- Rounded borders for diagnostics
vim.diagnostic.config({
  float = {
    border = "rounded",
  },
  virtual_lines = false,
})

-- enable inlayhint
vim.lsp.inlay_hint.enable(true, nil)
