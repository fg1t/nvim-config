return {
  -- Mason: LSP/linter installer
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Ensures servers are installed; bridges Mason with native vim.lsp
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- svls is installed globally via cargo, not managed by Mason
          "pyright", -- Python (cocotb, scripts)
          "lua_ls",  -- Lua (nvim config)
        },
        automatic_installation = true,
      })
    end,
  },

  -- nvim-lspconfig provides server definitions consumed by vim.lsp.config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- SystemVerilog LSP
      -- Requires a .svls.toml in your project root:
      --   [verilog]
      --   include_paths = ["rtl/", "ip/"]
      --   defines = ["SIMULATION"]
      vim.lsp.config("svls", {
        capabilities = capabilities,
        filetypes = { "systemverilog", "verilog" },
      })

      -- Python (cocotb testbenches, build scripts)
      vim.lsp.config("pyright", {
        capabilities = capabilities,
      })

      -- Lua (neovim config editing)
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      vim.lsp.enable({ "svls", "pyright", "lua_ls" })

      vim.diagnostic.config({
        virtual_text     = true,
        signs            = true,
        underline        = true,
        update_in_insert = false,
      })
    end,
  },
}
