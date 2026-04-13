-- ===========================================================-- ============================================================
-- core/options.lua
-- ============================================================
local opt = vim.opt

-- Appearance
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = true
opt.colorcolumn = ""
opt.showmode = false -- lualine handles this
opt.textwidth = 100 -- wrap at 100 chars (0 = no wrap)
opt.wrap = true -- enable visual wrapping
opt.linebreak = true

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.shiftround = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Files
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.updatetime = 200
opt.timeoutlen = 600

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Completion
opt.completeopt = "menuone,noselect"
opt.pumheight = 10

-- Clipboard (uncomment to use system clipboard)
-- opt.clipboard = "unnamedplus"
