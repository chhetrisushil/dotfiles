-- dap virtual text setup
local status_ok, dapvirtualtext = pcall(require, "nvim-dap-virtual-text")

if not status_ok then
  return
end

dapvirtualtext.setup()

-- dap ui setup
local status_ok, dapui = pcall(require, "dapui")

if not status_ok then
  return
end

dapui.setup()

local dap = require("dap")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- dap key bindings
local status_ok, wk = pcall(require, "which-key")

if not status_ok then
  return
end

wk.register({
  d = {
    name = "Debugging (DAP)",
    b = {":lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint"},
    B = {":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Conditional Breakpoint"},
    o = {
      name = "Over/Out",
      v = {":lua require'dap'.step_over()<cr>", "Step Over"},
      u = {":lua require'dap'.step_out()<cr>", "Step Out"},
    },
    i = {":lua require'dap'.step_into()<cr>", "Step Into"},
    c = {":lua require'dap'.continue()<cr>", "Continue"},
  }
}, {prefix = "<space>", nnoremap = true, silent = true})
