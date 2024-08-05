local status_ok, wk = pcall(require, "which-key")

if not status_ok then
    return
end

wk.add({
  { "<space>t", ":TagbarToggle<cr>", desc = "TagbarToggle", remap = false },
})
