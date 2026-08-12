-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("markdown_writing", { clear = true }),
	pattern = { "markdown", "markdown.mdx" },
	callback = function()
		-- Wrap prose visually without inserting hard line breaks into the document.
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.breakindent = true

		-- Make long documents comfortable to read and navigate.
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_gb,en_us"
		vim.opt_local.textwidth = 80
		vim.opt_local.foldcolumn = "1"
		vim.opt_local.foldlevel = 99
	end,
})
