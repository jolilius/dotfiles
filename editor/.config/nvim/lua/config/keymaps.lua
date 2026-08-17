-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("i", "jj", "<Esc>")

local map = vim.keymap.set

map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown: browser preview" })
map("n", "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", { desc = "Markdown: rendered view" })
map("n", "<leader>mz", function()
	Snacks.zen()
end, { desc = "Markdown: Zen mode" })
map("n", "<leader>ms", function()
	vim.opt_local.spell = not vim.opt_local.spell:get()
	vim.notify("Spell checking " .. (vim.opt_local.spell:get() and "enabled" or "disabled"))
end, { desc = "Markdown: toggle spelling" })
map("n", "<leader>mw", function()
	vim.opt_local.wrap = not vim.opt_local.wrap:get()
	vim.notify("Line wrapping " .. (vim.opt_local.wrap:get() and "enabled" or "disabled"))
end, { desc = "Markdown: toggle wrapping" })
map("n", "<leader>mq", "gqap", { desc = "Markdown: format paragraph" })
map("n", "<leader>mm", function()
	local document = vim.api.nvim_buf_get_name(0)
	if document == "" then
		vim.notify("Save the document before opening it in Marked", vim.log.levels.WARN)
		return
	end
	vim.system({ "open", "-a", "Marked 2", document }, { detach = true }, function(result)
		if result.code ~= 0 then
			vim.schedule(function()
				vim.notify("Could not open Marked 2; is it installed?", vim.log.levels.ERROR)
			end)
		end
	end)
end, { desc = "Markdown: open in Marked 2" })

-- Scandinavian keyboards make the conventional [ and ] navigation prefixes
-- awkward. Keep the original commands and provide a consistent jump namespace.
map("n", "<leader>jd", "]d", { remap = true, desc = "Jump: next diagnostic" })
map("n", "<leader>jD", "[d", { remap = true, desc = "Jump: previous diagnostic" })
map("n", "<leader>js", "]s", { remap = true, desc = "Jump: next spelling mistake" })
map("n", "<leader>jS", "[s", { remap = true, desc = "Jump: previous spelling mistake" })
map("n", "<leader>jf", "zj", { desc = "Jump: next fold" })
map("n", "<leader>jF", "zk", { desc = "Jump: previous fold" })
map("n", "<leader>jq", "]q", { remap = true, desc = "Jump: next quickfix item" })
map("n", "<leader>jQ", "[q", { remap = true, desc = "Jump: previous quickfix item" })
map("n", "<leader>jl", "]l", { remap = true, desc = "Jump: next location-list item" })
map("n", "<leader>jL", "[l", { remap = true, desc = "Jump: previous location-list item" })
