-- plugins/lsp.lua
-- Compatible with nvim-lspconfig v1.0+ (new vim.lsp.config / vim.lsp.enable API)
return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = { ui = { border = "rounded" } },
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"pyright",
				"ts_ls",
				"gopls",
				"lua_ls",
				"sqls",
				"jsonls",
				"yamlls",
				"bashls",
				"omnisharp",
				"clojure_lsp",
				"clangd",
				"cssls",
				"tailwindcss",
			},
			automatic_installation = true,
		},
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			{ "folke/lazydev.nvim", ft = "lua", opts = {} },
		},
		config = function()
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)

			-- ── LspAttach: keymaps + inlay hints ─────────────────────
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
				callback = function(ev)
					local map = function(keys, func, desc, mode)
						vim.keymap.set(mode or "n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
					end

					map("gd", vim.lsp.buf.definition, "Go to definition")
					map("gD", vim.lsp.buf.declaration, "Go to declaration")
					map("gr", "<cmd>Telescope lsp_references<cr>", "References")
					map("gi", "<cmd>Telescope lsp_implementations<cr>", "Implementations")
					map("gt", vim.lsp.buf.type_definition, "Type definition")
					map("K", vim.lsp.buf.hover, "Hover docs")
					map("<C-s>", vim.lsp.buf.signature_help, "Signature help", "i")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>.", vim.lsp.buf.code_action, "Code action")
					map("<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols")
					map("<leader>ws", "<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace symbols")

					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if client and client.supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
						map("<leader>lh", function()
							vim.lsp.inlay_hint.enable(
								not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }),
								{ bufnr = ev.buf }
							)
						end, "Toggle inlay hints")
					end
				end,
			})

			-- ── Diagnostics ───────────────────────────────────────────
			vim.diagnostic.config({
				severity_sort = true,
				underline = true,
				update_in_insert = false,
				virtual_text = { prefix = "●", spacing = 4 },
				float = { border = "rounded", source = true, header = "", prefix = "" },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = "󰠠 ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
			})

			-- ── Server configs via vim.lsp.config (lspconfig v1.0 API)─
			vim.lsp.config("*", { capabilities = capabilities })

			vim.lsp.config("pyright", {
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				},
			})

			vim.lsp.config("ts_ls", {
				settings = {
					typescript = { inlayHints = { includeInlayParameterNameHints = "all" } },
					javascript = { inlayHints = { includeInlayParameterNameHints = "all" } },
				},
			})

			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
						gofumpt = true,
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = { checkThirdParty = false },
						diagnostics = { globals = { "vim" } },
						telemetry = { enable = false },
					},
				},
			})

			vim.lsp.config("omnisharp", {
				cmd = {
					vim.fn.stdpath("data") .. "/mason/packages/omnisharp/omnisharp",
					"--languageserver",
					"--hostPID",
					tostring(vim.fn.getpid()),
				},
				settings = {
					omnisharp = {
						enableRoslynAnalyzers = true,
						enableEditorConfigSupport = true,
						organizeImportsOnFormat = true,
					},
				},
			})

			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders=true",
				},
			})

			-- Enable all servers (mason-lspconfig handles installation)
			vim.lsp.enable({
				"pyright",
				"ts_ls",
				"gopls",
				"lua_ls",
				"sqls",
				"jsonls",
				"yamlls",
				"bashls",
				"omnisharp",
				"clojure_lsp",
				"clangd",
			})
		end,
	},
}
