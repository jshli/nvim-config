return {
  {
    "folke/edgy.nvim",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>ue"] = { function() require("edgy").toggle() end, desc = "Toggle Sidebars" },
              ["<Leader>uE"] = { function() require("edgy").select() end, desc = "Pick Sidebar" },
            },
          },
        },
      },
    },
    opts = {
      exit_when_last = false,
      bottom = {
        { ft = "qf", title = "QuickFix" },
        {
          ft = "toggleterm",
          size = { height = 0.4 },
          -- exclude floating windows
          filter = function(buf, win) return vim.api.nvim_win_get_config(win).relative == "" end,
        },
      },
      left = {
        -- {
        --   title = "Files",
        --   ft = "neo-tree",
        --   filter = function(buf) return vim.b[buf].neo_tree_source == "filesystem" end,
        --   pinned = true,
        --   open = "Neotree position=left filesystem",
        -- },
        --   {
        --     title = "Git Status",
        --     ft = "neo-tree",
        --     filter = function(buf) return vim.b[buf].neo_tree_source == "git_status" end,
        --     pinned = true,
        --     open = "Neotree position=right git_status",
        --   },
        --   {
        --     title = "Buffers",
        --     ft = "neo-tree",
        --     filter = function(buf) return vim.b[buf].neo_tree_source == "buffers" end,
        --     pinned = true,
        --     open = "Neotree position=top buffers",
        --   },
        -- "neo-tree",
      },
      right = {
        {
          ft = "aerial",
          title = "Symbol Outline",
          pinned = true,
          open = function() require("aerial").open() end,
        },
      },
      keys = {
        -- increase width
        ["<C-Right>"] = function(win) win:resize("width", 2) end,
        -- decrease width
        ["<C-Left>"] = function(win) win:resize("width", -2) end,
        -- increase height
        ["<C-Up>"] = function(win) win:resize("height", 2) end,
        -- decrease height
        ["<C-Down>"] = function(win) win:resize("height", -2) end,
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = {
      source_selector = {
        winbar = false,
        statusline = false,
      },
    },
  },
}
