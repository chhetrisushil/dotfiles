return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			mode = "tabs",
			color_icons = true,
			show_buffer_close_icons = false,
			show_close_icon = false,
			diagnostics = "nvim_lsp",
			always_show_bufferline = true,
		},
	},
}
