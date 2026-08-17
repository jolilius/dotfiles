local function without_markdownlint(items)
	return vim.tbl_filter(function(item)
		return item ~= "markdownlint-cli2" and item ~= "prettier"
	end, items or {})
end

return {
	{
		"tadmccorkle/markdown.nvim",
		ft = { "markdown", "markdown.mdx" },
		opts = {
			-- mini.surround owns emphasis; the mappings below focus on lists.
			mappings = false,
			on_attach = function(bufnr)
				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end
				local function continue_list()
					local line = vim.api.nvim_get_current_line()
					local indent, marker, task = line:match("^(%s*)([-+*]%s+)(.*)$")
					local checkbox
					if task then
						local checkbox_match, item_text = task:match("^(%[[ xX]%]%s+)(.*)$")
						if checkbox_match then
							checkbox, task = checkbox_match, item_text
						end
					end
					if not marker then
						indent, marker, task = line:match("^(%s*)(%d+[.)]%s+)(.*)$")
						if task then
							local checkbox_match, item_text = task:match("^(%[[ xX]%]%s+)(.*)$")
							if checkbox_match then
								checkbox, task = checkbox_match, item_text
							end
						end
					end
					if not marker then
						return "<cr>"
					end
					if task == "" then
						return "<c-u><cr>"
					end
					marker = marker:gsub("^(%d+)", function(number)
						return tostring(tonumber(number) + 1)
					end)
					-- <CR> preserves the existing indentation. Do not use <C-u> after
					-- it: that can delete the line break when splitting an item.
					return "<cr>" .. marker .. (checkbox and "[ ] " or "")
				end

				vim.keymap.set("i", "<cr>", continue_list, {
					buffer = bufnr,
					expr = true,
					replace_keycodes = true,
					desc = "Markdown: continue list",
				})
				map({ "n", "i" }, "<leader>ma", "<cmd>MDListItemAbove<cr>", "Markdown: list item above")
				map({ "n", "i" }, "<leader>mn", "<cmd>MDListItemBelow<cr>", "Markdown: list item below")
				map("n", "<leader>mx", "<cmd>MDTaskToggle<cr>", "Markdown: toggle task")
				map("x", "<leader>mx", ":MDTaskToggle<cr>", "Markdown: toggle tasks")
				map("n", "<leader>m#", "<cmd>MDResetListNumbering<cr>", "Markdown: renumber list")
				map("x", "<leader>m#", ":MDResetListNumbering<cr>", "Markdown: renumber selected lists")
				map("n", "<leader>mh", "<<", "Markdown: dedent list item")
				map("n", "<leader>ml", ">>", "Markdown: indent list item")
				map("x", "<leader>mh", "<gv", "Markdown: dedent selected items")
				map("x", "<leader>ml", ">gv", "Markdown: indent selected items")
				map("n", "<leader>mk", "<cmd>move-2<cr>==", "Markdown: move list item up")
				map("n", "<leader>mj", "<cmd>move+1<cr>==", "Markdown: move list item down")
				map("x", "<leader>mk", ":move '<-2<cr>gv=gv", "Markdown: move selected items up")
				map("x", "<leader>mj", ":move '>+1<cr>gv=gv", "Markdown: move selected items down")
			end,
		},
	},
	{
		"saghen/blink.cmp",
		opts = {
			enabled = function()
				return not vim.tbl_contains({ "markdown", "markdown.mdx" }, vim.bo.filetype)
			end,
		},
	},
	{
		"nvim-mini/mini.surround",
		opts = {
			custom_surroundings = {
				b = {
					input = { "%*%*.-%*%*", "^..().-()..$" },
					output = { left = "**", right = "**" },
				},
				i = {
					input = { "%*.-%*", "^.().-().$" },
					output = { left = "*", right = "*" },
				},
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		opts = function(_, opts)
			opts.linters_by_ft = opts.linters_by_ft or {}
			opts.linters_by_ft.markdown = nil
			opts.linters_by_ft["markdown.mdx"] = nil
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			opts.formatters_by_ft.markdown = without_markdownlint(opts.formatters_by_ft.markdown)
			opts.formatters_by_ft["markdown.mdx"] = without_markdownlint(opts.formatters_by_ft["markdown.mdx"])
		end,
	},
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = without_markdownlint(opts.ensure_installed)
		end,
	},
}
