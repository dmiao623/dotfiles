-------------------------------
-- User Cmds                 --
-------------------------------

vim.api.nvim_create_user_command("DiagnosticToggle", function()
	local config = vim.diagnostic.config
	local vt = config().virtual_text
	config {
		virtual_text = not vt,
		underline = not vt,
		signs = not vt,
	}

  if config().virtual_text then
    print("diagostic disabled")
  else
    print("diagostic enabled")
  end
end, { desc = "toggle diagnostic" })

vim.g.cmp_enabled = false
vim.api.nvim_create_user_command("CmpToggle", function()
  vim.g.cmp_enabled = not vim.g.cmp_enabled
  if vim.g.cmp_enabled then
    print("nvim-cmp enabled")
  else
    print("nvim-cmp disabled")
  end
end, { desc = "toggle cmp" })


local wrapToggle = false
vim.api.nvim_create_user_command("WrapToggle", function()
  wrapToggle = not wrapToggle
  if wrapToggle then
    print("wrap enabled")
  else
    print("wrap disabled")
  end

  vim.wo.wrap = wrapToggle
  vim.wo.linebreak = wrapToggle
  vim.wo.breakindent = wrapToggle
  if wrapToggle then
    vim.wo.breakindentopt = "shift:2,min:40,sbr"
    vim.wo.showbreak = "+\\"
  else
    vim.wo.breakindentopt = ""
    vim.wo.showbreak = ""
  end

  local opts = { noremap = true, silent = true, unique = false }
  local modes = { "n", "v", "x" }
  for _, mode in ipairs(modes) do
    if wrapToggle then
      vim.keymap.set(mode, "j", "gj", opts)
      vim.keymap.set(mode, "k", "gk", opts)
      vim.keymap.set(mode, "$", "g$", opts)
      vim.keymap.set(mode, "0", "g0", opts)
    else
      vim.keymap.set(mode, "j", "j", opts)
      vim.keymap.set(mode, "k", "k", opts)
      vim.keymap.set(mode, "$", "$", opts)
      vim.keymap.set(mode, "0", "0", opts)
    end
  end
end, { desc = "toggle wrap" })

vim.api.nvim_create_user_command("CountChars", function()
  vim.cmd(":%s/./&/gn")
end, { desc = "count characters" })

vim.api.nvim_create_user_command("CountWords", function()
  vim.cmd(":%s/\\i\\+/&/gn")
end, { desc = "count words" })

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.fun",
  command = "set filetype=sml"
})
