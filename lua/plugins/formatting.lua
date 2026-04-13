-- plugins/formatting.lua
return {

	-- Auto-install formatters and linters via Mason
	-- (mason-lspconfig only handles LSPs; this handles everything else)
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				-- Python
				"black",
				"isort",
				"ruff",
				-- JS / TS
				"prettierd",
				"eslint_d",
				-- Go
				"goimports",
				"gofumpt",
				"golangci-lint",
				-- Lua
				"stylua",
				-- Shell
				"shfmt",
				-- SQL
				"sqlfmt",
			},
			auto_update = false,
			run_on_start = true,
		},
	},

	-- Formatter
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				desc = "Format buffer",
			},
			{
				"<leader>gf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				python = { "isort", "black" },
				javascript = { "prettierd", stop_after_first = true },
				typescript = { "prettierd", stop_after_first = true },
				javascriptreact = { "prettierd", stop_after_first = true },
				typescriptreact = { "prettierd", stop_after_first = true },
				go = { "goimports", "gofumpt" },
				lua = { "stylua" },
				sql = { "sqlfmt" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				sh = { "shfmt" },
			},
			format_on_save = function(bufnr)
				local ignore = { sql = true }
				if ignore[vim.bo[bufnr].filetype] then
					return nil
				end
				return { timeout_ms = 500, lsp_fallback = true }
			end,
		},
	},

	-- Linter
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				python = { "ruff" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				go = { "golangcilint" }, -- nvim-lint's internal name
			}

			-- Point nvim-lint's golangcilint at the correct binary name
			lint.linters.golangcilint = vim.tbl_deep_extend("force", lint.linters.golangcilint or {}, {
				cmd = "golangci-lint",
			})

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				callback = function()
					local names = lint.linters_by_ft[vim.bo.filetype] or {}
					for _, name in ipairs(names) do
						local linter = lint.linters[name]
						local cmd = (type(linter) == "table" and type(linter.cmd) == "string") and linter.cmd or name
						if vim.fn.executable(cmd) == 1 then
							lint.try_lint(name)
						end
					end
				end,
			})
		end,
	},
}
