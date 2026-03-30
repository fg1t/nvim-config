return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "verilog",   -- covers SystemVerilog syntax
          "lua",
          "bash",
          "python",    -- useful for cocotb / scripts
          "tcl",       -- EDA tool scripts
          "markdown",
        },
        -- highlight and indent are enabled by default in the new API
      })
    end,
  },
}
