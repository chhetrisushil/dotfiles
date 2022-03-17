local status_ok, wk = pcall(require, 'which-key')

if not status_ok then
  return
end

-- with <leader> as prefix
wk.register({
  l = {
    name = "Misc Bindings",
    n = {"<cmd>setlocal number!<CR>", "Toggle Line Numbers"},
  },
  o = {"<cmd>set paste!<CR>", "Toggle Paste"},
  a = {":tab split<CR>:Ack ''<Left>", "Search in new Tab", silent=false},
  A = {":tab split<CR>:Ack <C-r><C-w><CR>", "Search word in new Tab", silent=false},
  e = {
    name = "Edit vimrc",
    v = {"<cmd>e " .. vim.env.MYVIMRC .. "<CR>", "Edit vimrc"}
  },
  s = {
    name = "Source vimrc",
    v = {"<cmd>so " .. vim.env.MYVIMRC .. "<CR>", "Source vimrc"}
  },
  j = {
    name = "For Javascript",
    s = {"<cmd>set syntax=javascript<CR>", "Set syntax to Javascript"},
    d = {"<Plug>(jsdoc)<CR>", "JSDoc"},
  }
}, {prefix='<leader>', nnoremap=true, silent=true})

-- with <space> as prefix
wk.register({
  l = {"<cmd>Limelight!!<cr>", "Toggle Limelight"}
}, {prefix='<space>', nnoremap=true, silent=true})
