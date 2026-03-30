return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Native fuzzy sorter (much faster for large RTL repos)
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          -- Exclude generated/sim files from search
          file_ignore_patterns = {
            "%.svd$", "simv", "csrc/", "DVEfiles/",
            "%.vcd$", "%.fsdb$", "%.vpd$",
            "node_modules/", "%.git/",
          },
          layout_strategy = "horizontal",
          layout_config    = { preview_width = 0.55 },
        },
      })
      telescope.load_extension("fzf")
    end,
  },
}
