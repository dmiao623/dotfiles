return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.tex_flavor="latex"
    vim.g.vimtex_view_method="skim"
    vim.g.vimtex_quickfix_mode=0

    vim.o.conceallevel = 1
    vim.g.tex_conceal="abdmg"
  end
}
