-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Extend PATH so Mason/LSPs can find cargo, homebrew binaries
local home = vim.fn.expand("~")
vim.env.PATH = home .. "/.cargo/bin:/opt/homebrew/bin:" .. vim.env.PATH

-- Leader key (must be before lazy setup)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")
require("keymaps")
require("lazy").setup("plugins", {
  change_detection = { notify = false },
})
