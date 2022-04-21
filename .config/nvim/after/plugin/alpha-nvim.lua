local status_ok, alpha = pcall(require, "alpha")

if not status_ok then
  return
end

alpha.setup(require'alpha.themes.startify'.config)

local wk_status_ok, wk = pcall(require, "which-key")

if not wk_status_ok then
  return
end

wk.register({
  a = {"<cmd>Alpha<cr>", "Alpha - Greeter"}
}, {prefix = "<space>", nnoremap = true, silent = true})
