local opt = vim.opt

-------------------------------
-- Netrw File Explorer       --
-------------------------------

vim.g.netrw_liststyle = 3

--------------------------------
-- Line Numbers               --
--------------------------------

opt.number = true
opt.relativenumber = true
opt.cursorline = true

--------------------------------
-- Tabs and Indentation       --
--------------------------------

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

--------------------------------
-- Line Wrapping              --
--------------------------------

opt.wrap = false

--------------------------------
-- Searching                  --
--------------------------------

opt.ignorecase = true
opt.smartcase = true
opt.iskeyword:append("-")

--------------------------------
-- Appearance                 --
--------------------------------

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
-- opt.colorcolumn = "80"

--------------------------------
-- Backspace                  --
--------------------------------

opt.backspace = "indent,eol,start"

--------------------------------
-- Clipboard                  --
--------------------------------

opt.clipboard:append("unnamedplus")

--------------------------------
-- Window Management          --
--------------------------------

opt.splitright = true
opt.splitbelow = true

--------------------------------
-- Scrolling                  --
--------------------------------

opt.scrolloff = 8
opt.sidescrolloff = 8

vim.g.python_recommended_style = 0

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.c0", "*.c1"},
  command = "set filetype=c"
})
