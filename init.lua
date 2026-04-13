-- ============================================================
-- init.lua — entry point
-- ============================================================
--
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.lazy") -- bootstraps lazy.nvim + loads plugins
