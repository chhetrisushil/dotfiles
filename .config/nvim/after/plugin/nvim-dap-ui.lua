local status_ok, dapui = pcall(requrie, 'dapui')

if not status_ok then
  return
end

dapui.setup()
