return {
	"kevinhwang91/nvim-ufo",
	event = "VeryLazy",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	init = function()
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
	end,
	config = true,
}
