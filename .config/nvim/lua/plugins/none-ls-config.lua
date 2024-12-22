 return {
	"nvimtools/none-ls.nvim",
	dependencies = {
	  "nvimtools/none-ls-extras.nvim",
		"folke/which-key.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local wk = require("which-key")

		null_ls.setup({
			sources = {
			  -- lua
				null_ls.builtins.formatting.stylua,
				-- Javascript/Typescript
				null_ls.builtins.formatting.biome,
			},
		})

		wk.add({
			{ "<leader>gf", vim.lsp.buf.format, desc = "Format bufferd", remap = false },
		})
	end,
}
