-- plugins/terminal.lua
return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{ "<C-\\>", desc = "Toggle terminal" },
			{ "<leader>tf", desc = "Float terminal" },
			{ "<leader>th", desc = "Horizontal terminal" },
			{ "<leader>tv", desc = "Vertical terminal" },
			{ "<leader>tg", desc = "Lazygit" },
		},
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<C-\>]],
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 3,
			},
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)

			local Terminal = require("toggleterm.terminal").Terminal

			-- Lazygit terminal
			local lazygit = Terminal:new({
				cmd = "lazygit",
				dir = "git_dir",
				direction = "float",
				float_opts = { border = "curved" },
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(
						term.bufnr,
						"n",
						"q",
						"<cmd>close<CR>",
						{ noremap = true, silent = true }
					)
				end,
			})

			vim.keymap.set("n", "<leader>tg", function()
				lazygit:toggle()
			end, { desc = "Lazygit" })
			vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float terminal" })
			vim.keymap.set(
				"n",
				"<leader>th",
				"<cmd>ToggleTerm direction=horizontal<cr>",
				{ desc = "Horizontal terminal" }
			)
			vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Vertical terminal" })

			-- Easy escape from terminal mode
			vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
			vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
			vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
			vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
			vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")
		end,
	},
}
