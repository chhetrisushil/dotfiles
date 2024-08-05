local status_ok, wk = pcall(require, 'which-key')

if not status_ok then
  return
end

-- with <leader> as prefix
wk.add({
    { "<leader>A", ":tab split<CR>:Ack <C-r><C-w><CR>", desc = "Search word in new Tab", silent = false },
    { "<leader>a", ":tab split<CR>:Ack ''<Left>", desc = "Search in new Tab", silent = false },
    { "<leader>e", group = "Edit vimrc" },
    { "<leader>ev", "<cmd>e /home/chhetrisushil/.config/nvim/init.vim<CR>", desc = "Edit vimrc" },
    { "<leader>j", group = "For Javascript" },
    { "<leader>jd", "<Plug>(jsdoc)<CR>", desc = "JSDoc" },
    { "<leader>js", "<cmd>set syntax=javascript<CR>", desc = "Set syntax to Javascript" },
    { "<leader>l", group = "Misc Bindings" },
    { "<leader>ln", "<cmd>setlocal number!<CR>", desc = "Toggle Line Numbers" },
    { "<leader>ot", "<cmd>set paste!<CR>", desc = "Toggle Paste" },
    { "<leader>s", group = "Source vimrc" },
    { "<leader>sv", "<cmd>so /home/chhetrisushil/.config/nvim/init.vim<CR>", desc = "Source vimrc" },
})

-- with <space> as prefix
wk.add({
  { "<space>l", "<cmd>Limelight!!<cr>", desc = "Toggle Limelight" },
})
