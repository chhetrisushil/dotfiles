local status_ok, tc = pcall(require, "treesitter-context")

if not status_ok then
  return
end

tc.setup()
