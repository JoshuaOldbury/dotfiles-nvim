# Neovim Config

A modular Neovim config built with Lazy.nvim.
Optimized for Python, TypeScript/JavaScript, Go, and SQL development.

## Directory Structure

```
~/.config/nvim/
├── init.lua
└── lua/
    ├── core/
    │   ├── options.lua
    │   ├── keymaps.lua
    │   ├── autocmds.lua
    │   └── lazy.lua
    └── plugins/
        ├── colorscheme.lua   ← kanagawa (dragon variant)
        ├── ui.lua            ← lualine, neo-tree, noice, bufferline, which-key, gitsigns
        ├── telescope.lua     ← fuzzy finder
        ├── treesitter.lua    ← syntax + textobjects
        ├── lsp.lua           ← mason + lspconfig (Python, JS/TS, Go, C#, Clojure, C, SQL, Lua)
        ├── completion.lua    ← nvim-cmp + luasnip
        ├── formatting.lua    ← conform (format) + nvim-lint (lint)
        ├── debug.lua         ← nvim-dap + dap-ui (Python, JS/TS, Go)
        ├── database.lua      ← vim-dadbod + dadbod-ui
        ├── git.lua           ← neogit + diffview
        ├── terminal.lua      ← toggleterm (float, split, lazygit)
        ├── repl.lua          ← conjure (Clojure REPL) + vim-sexp
        └── testing.lua       ← neotest (Python, Go, JS/TS, C#)
```

## Installation

```bash
# Back up existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Copy this config
cp -r /path/to/this/nvim ~/.config/nvim

# Launch nvim — lazy.nvim will auto-bootstrap and install all plugins
nvim
```

Mason will then automatically install all LSPs, formatters, linters,
and debug adapters on first launch. Run `:Mason` to monitor progress.

## Key Bindings (Space as leader)

### Navigation
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Switch buffers |
| `<leader>fr` | Recent files |
| `<leader>e`  | Toggle file tree |
| `<S-h/l>`    | Prev/next buffer |

### LSP
| Key | Action |
|-----|--------|
| `gd`           | Go to definition |
| `gr`           | References |
| `K`            | Hover docs |
| `<leader>rn`   | Rename |
| `<leader>ca`   | Code action |
| `<leader>lf`   | Format buffer |
| `[d` / `]d`    | Prev/next diagnostic |

### Git (Neogit)
| Key | Action |
|-----|--------|
| `<leader>gg` | Open Neogit |
| `<leader>gc` | Commit |
| `<leader>gP` | Push |
| `<leader>gl` | Pull |
| `<leader>gd` | Diffview |
| `<leader>gh` | File history |
| `<leader>gp` | Preview hunk (gitsigns) |
| `<leader>gb` | Blame line (gitsigns) |

### Terminal (toggleterm)
| Key | Action |
|-----|--------|
| `<C-\>` | Toggle terminal |
| `<leader>tf` | Float terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tv` | Vertical terminal |
| `<leader>tg` | Lazygit |
| `<Esc><Esc>` | Exit terminal mode |

### Testing (neotest)
| Key | Action |
|-----|--------|
| `<leader>tt` | Run nearest test |
| `<leader>tf` | Run file |
| `<leader>tT` | Run all tests |
| `<leader>ts` | Test summary |
| `<leader>to` | Test output |
| `<leader>td` | Debug nearest test |
| `]t` / `[t` | Next/prev failed test |

### Clojure (Conjure — `\\` localleader)
| Key | Action |
|-----|--------|
| `\\e` | Eval current form |
| `\\ee` | Eval outermost form |
| `\\eb` | Eval buffer |
| `\\lv` | Open log (vertical) |
| `\\lq` | Close log |
| `\\rs` | Connect to nREPL |


| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dO` | Step over |
| `<leader>du` | Toggle DAP UI |

### Database
| Key | Action |
|-----|--------|
| `<leader>Db` | Toggle DB UI |
| `<leader>Da` | Add connection |

## Database Connections

Connection URLs in vim-dadbod-ui (stored in `~/.local/share/nvim/db_ui`):

```
PostgreSQL  postgresql://user:pass@localhost:5432/dbname
MySQL       mysql://user:pass@localhost:3306/dbname
SQLite      sqlite:./relative/path/to/db.sqlite
```

## LSPs Installed via Mason

| Language | LSP | Formatter | Linter |
|----------|-----|-----------|--------|
| Python | pyright | black + isort | ruff |
| JS/TS | ts_ls | prettierd | eslint_d |
| Go | gopls | goimports + gofumpt | golangci-lint |
| C# | omnisharp | — | — |
| Clojure | clojure-lsp | — | — |
| C | clangd | — | — |
| SQL | sqlls | sqlfmt | — |
| Lua | lua_ls | stylua | — |

## Customization Tips

- **Change colorscheme**: Edit `plugins/colorscheme.lua` — currently using `kanagawa-dragon`. Swap the plugin repo and `colorscheme` command for any other theme
- **Add a language**: Add its LSP to `plugins/lsp.lua` `ensure_installed`, formatter to `plugins/formatting.lua`
- **Disable format-on-save**: Remove `format_on_save` block in `plugins/formatting.lua`
- **System clipboard**: Uncomment `opt.clipboard = "unnamedplus"` in `core/options.lua`
