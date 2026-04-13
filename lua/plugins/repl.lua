-- plugins/repl.lua  (Clojure / REPL-driven dev)
return {
	-- Conjure: interactive REPL evaluation for Clojure (also supports others)
	{
		"Olical/conjure",
		ft = { "clojure", "fennel", "scheme" },
		dependencies = {
			-- Structural editing — essential for Lisp
			{
				"guns/vim-sexp",
				ft = { "clojure", "fennel", "scheme" },
				init = function()
					vim.g.sexp_filetypes = "clojure,fennel,scheme"
					vim.g.sexp_enable_insert_mode_mappings = 0
				end,
			},
			{
				"tpope/vim-sexp-mappings-for-regular-people",
				ft = { "clojure", "fennel", "scheme" },
				dependencies = { "guns/vim-sexp" },
			},
			-- Parinfer for auto-balancing parens
			{
				"gpanders/nvim-parinfer",
				ft = { "clojure", "fennel", "scheme" },
			},
		},
		init = function()
			-- Log buffer at bottom, reasonable size
			vim.g["conjure#log#hud#width"] = 1.0
			vim.g["conjure#log#hud#height"] = 0.4
			vim.g["conjure#log#hud#enabled"] = false -- use split instead
			vim.g["conjure#log#botright"] = true
			vim.g["conjure#extract#context_header_lines"] = 100

			-- Clojure: connect to nREPL automatically if .nrepl-port exists
			vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = true
			vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true

			-- Keymaps are all under <localleader> (\\) by default:
			--   \\e  → eval current form
			--   \\ee → eval outermost form
			--   \\eb → eval buffer
			--   \\er → eval root form
			--   \\lv → open log vertical split
			--   \\lq → close log
			--   \\rs → connect to running nREPL
		end,
	},
}
