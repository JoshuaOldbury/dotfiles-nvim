-- plugins/git.lua
return {
	-- Neogit: Magit-style git UI
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim", -- rich diff/history viewer
			"nvim-telescope/telescope.nvim",
		},
		cmd = "Neogit",
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
			{ "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Git commit" },
			{ "<leader>gP", "<cmd>Neogit push<cr>", desc = "Git push" },
			{ "<leader>gl", "<cmd>Neogit pull<cr>", desc = "Git pull" },
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
			{ "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview close" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch history" },
		},
		opts = {
			integrations = {
				diffview = true,
				telescope = true,
			},
			signs = {
				hunk = { "", "" },
				item = { ">", "v" },
				section = { ">", "v" },
			},
			mappings = {
				status = {
					["q"] = "Close",
				},
			},
		},
	},

	-- Diffview: side-by-side diffs and git history
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		opts = {
			enhanced_diff_hl = true,
			view = {
				default = { layout = "diff2_horizontal" },
				file_history = { layout = "diff2_horizontal" },
			},
		},
	},
}
