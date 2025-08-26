return {
	"piersolenski/import.nvim",
	dependencies = {
		"folke/snacks.nvim",
	},
	opts = {
		picker = "snacks",
	},
	keys = {
		{
			"<leader>i",
			function()
				require("import").pick()
			end,
			desc = "Import",
		},
	},
	cmd = { "Import" },
}
