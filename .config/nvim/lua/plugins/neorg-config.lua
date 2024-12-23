return {
	"nvim-neorg/neorg",
	lazy = false,
	version = "*", -- Pin Neorg to the latest stable release
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.summary"] = {},
        ["core.completion"] = { config = { engine = "nvim-cmp" } },
        ["core.dirman"] = {
          config = {
            workspaces = {
              work = "~/Documents/Neorg/Work",
              personal = "~/Documents/Neorg/Personal",
            },
          },
        },
      },
    })
  end
}
