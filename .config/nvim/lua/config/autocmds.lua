-- Enable spell check for markdown and txt files only
local spellcheck_group = vim.api.nvim_create_augroup("SpellCheck", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	pattern = { "*.md", "*.txt" },
	command = "setlocal spell spelllang=en",
	group = spellcheck_group,
})
