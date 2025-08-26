return {
	"isticusi/docpair.nvim",
	main = "docpair",
	lazy = false, -- eager so :Documented has filename completion immediately
	opts = { info_filetype = "markdown" },
	config = true, -- calls require("docpair").setup(opts)
}
