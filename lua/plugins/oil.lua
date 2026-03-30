if vim.g.vscode then return {} end

return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        default_file_explorer = false, -- keep neo-tree as default
        view_options = { show_hidden = true },
      })
      vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent dir (oil)" })
    end,
  },
}
