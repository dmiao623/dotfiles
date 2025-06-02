return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = { enable = false },
      ensure_installed = {
        "bash",
        "bibtex",
        "cpp",
        "json",
        "julia",
        "latex",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "python",
        "vim",
        "vimdoc",
        "yaml",
      },
      modules = {},
      sync_install = false,
      auto_install = false,
      ignore_install = {},
      parser_install_dir = nil,
    })
  end,
}
