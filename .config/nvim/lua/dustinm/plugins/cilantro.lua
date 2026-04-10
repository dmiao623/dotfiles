return {
  dir = "~/Projects/personal/cilantro.nvim",
  -- "dmiao623/cilantro.nvim",
  config = function()
    require("cilantro").setup({
      task_dir = "~/tasks",
    })
  end,
}
