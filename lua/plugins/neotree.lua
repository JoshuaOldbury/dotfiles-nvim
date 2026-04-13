return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },

  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,

      filesystem = {
        follow_current_file = {
          enabled = true,
        },

        use_libuv_file_watcher = true,

        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },

        -- monorepo friendly root detection
        cwd = function()
          local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
          if vim.v.shell_error == 0 and git_root ~= "" then
            return git_root
          end
          return vim.fn.getcwd()
        end,
      },

      git_status = {
        enabled = true,
      },

      window = {
        position = "left",
        width = 32,
        mappings = {
          ["<CR>"] = "open",
          ["h"] = "open_split",
          ["v"] = "open_vsplit",
          ["c"] = "close_node",
        },
      },

      default_component_configs = {
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰜌",
        },
      },
    })

    -- toggle explorer
    vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true })
  end,
}
