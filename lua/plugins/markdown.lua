-- plugins/markdown.lua
return {
	-- ── Markdown preview via glow ─────────────────────────────────
	{
		"ellisonleao/glow.nvim",
		ft = "markdown",
		cmd = "Glow",
		opts = {
			border = "rounded",
			width = 120,
			height_ratio = 0.8,
		},
		keys = {
			{ "<leader>mp", "<cmd>Glow<cr>", ft = "markdown", desc = "Markdown preview (glow)" },
		},
	},
}
