vim.g.mapleader = " "

local function uniqueKeymap(modes, lhs, rhs, opts)
	if not opts then opts = {} end
	if opts.unique == nil then opts.unique = true end
	vim.keymap.set(modes, lhs, rhs, opts)
end

-- +--------------------------------+
-- | Replace Default Bindings       |
-- +--------------------------------+

-- replace default bindings

uniqueKeymap("n", "x", '"_x')
uniqueKeymap("n", "c", '"_c')
uniqueKeymap("x", "V", "j")
uniqueKeymap("n", "<Esc>", ":nohl<CR>:echo<CR>")

uniqueKeymap("n", "dd", function ()
	if vim.fn.getline(".") == "" then return '"_dd' end
	return "dd"
end, {expr = true})

-- yank

local cursorPreYank

uniqueKeymap({ "n", "x" }, "y", function()
	cursorPreYank = vim.api.nvim_win_get_cursor(0)
	return "y"
end, { expr = true })

uniqueKeymap("n", "Y", function()
	cursorPreYank = vim.api.nvim_win_get_cursor(0)
	return "y$"
end, { expr = true, unique = false })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		if vim.v.event.operator == "y" and cursorPreYank then
			vim.api.nvim_win_set_cursor(0, cursorPreYank)
		end
	end,
})

-- +--------------------------------+
-- | New Bindings                   |
-- +--------------------------------+

-- splits
uniqueKeymap("n", "<leader>sv", "<cmd>vsplit<CR>",
  { desc = "Create vertical split" })
uniqueKeymap("n", "<leader>sh", "<cmd>split<CR>",
  { desc = "Create horziontal split" })
uniqueKeymap("n", "<leader>se", "<C-w>=",
  { desc = "Equalize splits" })
uniqueKeymap("n", "<leader>sx", "<cmd>close<CR>",
  { desc = "Close current split" })

uniqueKeymap("n", "<leader>e", "<cmd>Oil<CR>",
  { desc = "(oil) Opens file explorer" })

uniqueKeymap("n", "<leader>td", "<cmd>DiagnosticToggle<CR>",
  { desc = "(lsp) Toggle diagnostic information" })
uniqueKeymap("n", "<leader>tc", "<cmd>CmpToggle<CR>",
  { desc = "(cmp) Toggle autocomplete" })
uniqueKeymap("n", "<leader>tw", "<cmd>WrapToggle<CR>",
  { desc = "Toggle wrap"})
