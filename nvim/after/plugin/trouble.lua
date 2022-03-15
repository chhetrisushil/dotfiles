local status_ok, trouble = pcall(require, "trouble")

if not status_ok then
  return
end

trouble.setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

local wk_status_ok, wk = pcall(require, "which-key")

if not wk_status_ok then
  return
end

wk.register({
  x = {
    name = "Trouble",
    x = {"<cmd>TroubleToggle<cr>", "TroubleToggle"},
    d = {
      name = "Diagnostics",
      w = {"<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace"},
      d = {"<cmd>TroubleToggle document_diagnostics<cr>", "Document"},
    },
    q = {"<cmd>TroubleToggle quickfix<cr>", "Quick Fix"},
    l = {"<cmd>TroubleToggle locllist<cr>", "Loc List"},
    r = {"<cmd>TroubleToggle lsp_references<cr>", "References"},
  }
}, {prefix = "<space>", noremap = true, silent = true})
