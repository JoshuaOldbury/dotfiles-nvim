# Neovim Config

A modular Neovim config built with Lazy.nvim.
Optimized for Python, TypeScript/JavaScript, Go, C#, C, Clojure, and SQL development.

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
        ├── ui.lua            ← lualine, neo-tree, bufferline, gitsigns, which-key
        ├── telescope.lua     ← fuzzy finder
        ├── treesitter.lua    ← syntax + textobjects
        ├── lsp.lua           ← mason + lspconfig (Python, JS/TS, Go, C#, Clojure, C, SQL, Lua)
        ├── completion.lua    ← nvim-cmp + luasnip
        ├── formatting.lua    ← conform (format) + nvim-lint (lint)
        ├── debug.lua         ← nvim-dap (placeholder)
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

# Clone this config
git clone https://github.com/JoshuaOldbury/dotfiles-nvim ~/.config/nvim

# Launch nvim — lazy.nvim will auto-bootstrap and install all plugins
nvim
```

Mason will automatically install all LSPs, formatters, linters, and debug adapters on first launch.
Run `:Mason` to monitor progress.

---

## Key Bindings

Leader key: `<Space>`  
Local leader (Clojure/REPL): `\`

### General

| Key | Action |
|-----|--------|
| `<leader>w` | Save |
| `<leader>q` | Quit |
| `<leader>Q` | Quit all (force) |
| `<Esc>` | Clear search highlight |

### Movement

| Key | Action |
|-----|--------|
| `j` / `k` | Move through wrapped lines |
| `<C-d>` / `<C-u>` | Half-page scroll (cursor centred) |
| `n` / `N` | Next/prev search result (centred) |

### Windows

| Key | Action |
|-----|--------|
| `<C-h>` | Move to left window |
| `<C-j>` | Move to lower window |
| `<C-k>` | Move to upper window |
| `<C-l>` | Move to right window |
| `<C-Up>` | Increase height |
| `<C-Down>` | Decrease height |
| `<C-Left>` | Decrease width |
| `<C-Right>` | Increase width |

### Buffers

| Key | Action |
|-----|--------|
| `<S-h>` | Prev buffer |
| `<S-l>` | Next buffer |
| `<leader>bd` | Delete buffer |

### Visual Mode

| Key | Action |
|-----|--------|
| `<` / `>` | Indent/unindent (stay in visual) |
| `J` | Move selected lines down |
| `K` | Move selected lines up |
| `p` | Paste without overwriting register |

### Telescope (Fuzzy Finder)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Switch buffers |
| `<leader>fh` | Help tags |
| `<leader>fr` | Recent files |
| `<leader>fd` | Diagnostics |

**Inside a Telescope picker:**

| Key | Action |
|-----|--------|
| `<C-p>` / `<C-n>` | Move selection up/down |
| `<C-q>` | Send selected to quickfix |
| `<Esc>` | Close picker |

### File Tree (Neo-tree)

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file tree |
| `<leader>o` | Focus file tree |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | References (Telescope) |
| `gi` | Implementations (Telescope) |
| `gt` | Type definition |
| `K` | Hover docs |
| `<C-s>` _(insert)_ | Signature help |
| `<leader>rn` | Rename symbol |
| `<leader>.` | Code action |
| `<leader>ds` | Document symbols (Telescope) |
| `<leader>ws` | Workspace symbols (Telescope) |
| `<leader>lh` | Toggle inlay hints |
| `<leader>lf` | Format buffer |
| `<leader>gf` | Format buffer (alias) |
| `<leader>li` | LSP info |
| `<leader>lr` | Restart LSP |

### Diagnostics

| Key | Action |
|-----|--------|
| `[d` / `]d` | Prev/next diagnostic |
| `<leader>d` | Show diagnostic float |

### Git — Neogit

| Key | Action |
|-----|--------|
| `<leader>gg` | Open Neogit |
| `<leader>gc` | Commit |
| `<leader>gP` | Push |
| `<leader>gl` | Pull |
| `<leader>gd` | Open Diffview |
| `<leader>gD` | Close Diffview |
| `<leader>gh` | Current file history |
| `<leader>gH` | Branch history |

### Git — Gitsigns (hunk-level)

| Key | Action |
|-----|--------|
| `]h` / `[h` | Next/prev hunk |
| `<leader>gp` | Preview hunk |
| `<leader>gb` | Blame line |
| `<leader>gr` | Reset hunk |
| `<leader>gR` | Reset buffer |

### Terminal (toggleterm)

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle terminal |
| `<leader>tf` | Float terminal ⚠️ |
| `<leader>th` | Horizontal terminal |
| `<leader>tv` | Vertical terminal |
| `<leader>tg` | Lazygit |
| `<Esc><Esc>` _(terminal)_ | Exit terminal mode |
| `<C-h/j/k/l>` _(terminal)_ | Navigate windows from terminal |

> ⚠️ `<leader>tf` conflicts with **Run file tests** (neotest). Whichever loads last wins — consider rebinding one.

### Testing (neotest)

| Key | Action |
|-----|--------|
| `<leader>tt` | Run nearest test |
| `<leader>tf` | Run file tests ⚠️ |
| `<leader>tT` | Run all tests |
| `<leader>ts` | Toggle test summary |
| `<leader>to` | Toggle test output |
| `<leader>td` | Debug nearest test |
| `]t` / `[t` | Next/prev failed test |

> ⚠️ `<leader>tf` conflicts with **Float terminal** (toggleterm). See note above.

### Database (vim-dadbod)

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle DB UI |
| `<leader>da` | Add connection |

### Clojure / REPL (Conjure — `\` localleader)

| Key | Action |
|-----|--------|
| `\\e` | Eval current form |
| `\\ee` | Eval outermost form |
| `\\eb` | Eval buffer |
| `\\er` | Eval root form |
| `\\lv` | Open log (vertical split) |
| `\\lq` | Close log |
| `\\rs` | Connect to running nREPL |

---

## LSPs, Formatters & Linters

| Language | LSP | Formatter | Linter |
|----------|-----|-----------|--------|
| Python | pyright | black + isort | ruff |
| JS/TS | ts_ls | prettierd | eslint_d |
| Go | gopls | goimports + gofumpt | golangci-lint |
| C# | omnisharp | — | — |
| Clojure | clojure-lsp | — | — |
| C | clangd | — | — |
| SQL | sqls | sqlfmt | — |
| Lua | lua_ls | stylua | — |
| JSON/YAML/MD | jsonls / yamlls | prettierd | — |
| Shell | bashls | shfmt | — |

Format-on-save is enabled for all filetypes except SQL.

---

## Customization Tips

- **Change colorscheme:** Edit `plugins/colorscheme.lua` — currently using `kanagawa-dragon`. Swap the plugin repo and `colorscheme` command for any other theme
- **Add a language:** Add its LSP to `plugins/lsp.lua` `ensure_installed`, formatter to `plugins/formatting.lua`
- **Disable format-on-save:** Remove the `format_on_save` block in `plugins/formatting.lua`
- **Fix `<leader>tf` conflict:** Rebind either `toggleterm`'s float terminal or neotest's run-file key in their respective plugin files

## Database Connections

Connection URLs are stored in `~/.local/share/nvim/db_ui`. Example formats:

```
PostgreSQL  postgresql://user:pass@localhost:5432/dbname
MySQL       mysql://user:pass@localhost:3306/dbname
SQLite      sqlite:./relative/path/to/db.sqlite
```
