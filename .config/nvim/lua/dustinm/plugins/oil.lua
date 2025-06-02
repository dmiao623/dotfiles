return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "echasnovski/mini.icons",
  },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return name == ".DS_Store" -- Hide .DS_Store files
        end,
      },
    })
  end,
}
