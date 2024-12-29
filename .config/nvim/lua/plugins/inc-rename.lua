return {
  "smjonas/inc-rename.nvim",
  keys = {
    {
      "<leader>rn",
      function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end,
      desc = "Rename variable",
      remap = false,
      expr = true,
    },
  },
  config = true,
}
