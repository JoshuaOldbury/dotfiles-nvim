-- ============================================================
-- core/autocmds.lua
-- ============================================================
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
	group = augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
	group = augroup("TrimWhitespace", { clear = true }),
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- Resize splits on window resize
autocmd("VimResized", {
	group = augroup("ResizeSplits", { clear = true }),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Return to last cursor position when opening a file
autocmd("BufReadPost", {
	group = augroup("LastCursorPos", { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Close certain filetypes with just 'q'
autocmd("FileType", {
	group = augroup("CloseWithQ", { clear = true }),
	pattern = { "help", "lspinfo", "man", "notify", "qf", "startuptime", "checkhealth" },
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true })
	end,
})

-- 2-space indent for JS/TS/Lua/JSON/YAML
autocmd("FileType", {
	group = augroup("TwoSpaceIndent", { clear = true }),
	pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "lua", "json", "yaml" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "sql", "mysql", "plsql" },
	callback = function()
		vim.keymap.set("n", "<leader>rq", "<Plug>(DBUI_ExecuteQuery)", { buffer = true, desc = "Run query" })
		vim.keymap.set("v", "<leader>rq", "<Plug>(DBUI_ExecuteQuery)", { buffer = true, desc = "Run selection" })
	end,
})
