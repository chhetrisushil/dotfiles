local set = vim.keymap.set

-- support sudo write
set("c", "w!!", "<esc>:lua require('config.utils').sudo_write()<CR>", { silent = true })
