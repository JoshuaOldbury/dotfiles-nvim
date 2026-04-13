-- plugins/colorscheme.lua
return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				compile = false,
				undercurl = true,
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = true,
				dimInactive = false,
				terminalColors = true,
				theme = "dragon",
				background = { dark = "dragon", light = "lotus" },
				overrides = function(colors)
					return {
						-- NeoTree panel
						NeoTreeNormal       = { bg = "NONE" },
						NeoTreeNormalNC     = { bg = "NONE" },
						NeoTreeSignColumn   = { bg = "NONE" },
						NeoTreeEndOfBuffer  = { bg = "NONE" },
						NeoTreeWinSeparator = { bg = "NONE" },
						NeoTreeStatusLine   = { bg = "NONE" },
						NeoTreeStatusLineNC = { bg = "NONE" },
						NeoTreeVertSplit    = { bg = "NONE" },
						NeoTreeFloatBorder  = { bg = "NONE" },
						NeoTreeFloatNormal  = { bg = "NONE" },
						-- Editor chrome
						SignColumn          = { bg = "NONE" },
						LineNr              = { bg = "NONE" },
					}
				end,
			})
			vim.cmd("colorscheme kanagawa-dragon")
		end,
	},
}
