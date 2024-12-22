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

wk.add({
  { "<space>x", group = "Trouble", remap = false },
  { "<space>xd", group = "Diagnostics", remap = false },
  { "<space>xdd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document", remap = false },
  { "<space>xdw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace", remap = false },
  { "<space>xl", "<cmd>TroubleToggle locllist<cr>", desc = "Loc List", remap = false },
  { "<space>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quick Fix", remap = false },
  { "<space>xr", "<cmd>TroubleToggle lsp_references<cr>", desc = "References", remap = false },
  { "<space>xx", "<cmd>TroubleToggle<cr>", desc = "TroubleToggle", remap = false },
})
