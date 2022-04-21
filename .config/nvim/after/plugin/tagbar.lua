local status_ok, wk = pcall(require, "which-key")

if not status_ok then
    return
end

wk.register({
  t = {":TagbarToggle<cr>", "TagbarToggle"}
}, {prefix = "<space>", noremap = true, silent = true})
