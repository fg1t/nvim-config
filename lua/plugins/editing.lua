return {
  -- Auto close brackets: VS Code handles this natively, skip when embedded
  not vim.g.vscode and {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  } or nil,

  -- Comment with gcc / gc<motion>
  -- Works in vscode-neovim; VS Code's own gc binding is overridden by this
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Surround: ys / cs / ds — works perfectly in vscode-neovim
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Show colors for hex values: skip in VS Code (it has its own colorizer)
  not vim.g.vscode and {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup()
    end,
  } or nil,
}
