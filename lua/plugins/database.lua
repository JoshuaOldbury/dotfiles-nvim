-- plugins/database.lua
return {
	-- Core dadbod
	{
		"tpope/vim-dadbod",
		lazy = true,
	},

	-- UI for dadbod
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
		},
		cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		init = function()
			-- Store DB connections in a persistent location
			vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_show_database_icon = 1
			vim.g.db_ui_force_echo_notifications = 1
			vim.g.db_ui_win_position = "left"
			vim.g.db_ui_winwidth = 40

			-- Auto-enable dadbod completion for sql/mysql/etc filetypes
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					require("cmp").setup.buffer({
						sources = {
							{ name = "vim-dadbod-completion" },
							{ name = "buffer" },
						},
					})
				end,
			})
		end,
	},
}

-- ============================================================
-- USAGE NOTES:
--   <leader>Db  — toggle DB UI panel
--   <leader>Da  — add a new connection
--
-- Connection URL examples:
--   PostgreSQL : postgresql://user:pass@localhost:5432/mydb
--   MySQL      : mysql://user:pass@localhost:3306/mydb
--   SQLite     : sqlite:./path/to/db.sqlite
--
-- In the DBUI panel:
--   o / <Enter>  — expand / open
--   S            — execute query (in .sql buffer)
--   <leader>W    — save query
-- ============================================================
