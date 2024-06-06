return {
  "epwalsh/obsidian.nvim",
  -- the obsidian vault in this default config  ~/obsidian-vault
  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
  -- event = { "bufreadpre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
  event = { "BufEnter  */Library/Mobile Documents/iCloud~md~obsidian/Documents/jshli-vault" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<leader>O"] = { desc = "Obsidian" },
            ["<leader>Od"] = {
              function()
                if vim.fn.exists ":ObsidianToday" == 2 then
                  vim.cmd "ObsidianToday"
                else
                  return "<leader>Od"
                end
              end,
              desc = "Open today's daily note",
            },
            ["<leader>Oy"] = {
              function()
                if vim.fn.exists ":ObsidianToday" == 2 then
                  vim.cmd "ObsidianToday -1"
                else
                  return "<leader>Oy"
                end
              end,
              desc = "Open yesterday's daily note",
            },
            ["<leader>Ot"] = {
              function()
                if vim.fn.exists ":ObsidianToday" == 2 then
                  vim.cmd "ObsidianToday 1"
                else
                  return "<leader>Ot"
                end
              end,
              desc = "Open tomorrow's daily note",
            },
            ["<leader>OD"] = {
              function()
                if vim.fn.exists ":ObsidianDailies" == 2 then
                  vim.cmd "ObsidianDailies -2 2"
                else
                  return "<leader>OD"
                end
              end,
              desc = "Open a picker with dail notes",
            },
            ["<leader>Ob"] = {
              function()
                if vim.fn.exists ":ObsidianBacklinks" == 2 then
                  vim.cmd "ObsidianBacklinks"
                else
                  return "<leader>Ob"
                end
              end,
              desc = "Collect backlinks",
            },
            ["<leader>OT"] = {
              function()
                if vim.fn.exists ":ObsidianTemplate" == 2 then
                  vim.cmd "ObsidianTemplate"
                else
                  return "<leader>OT"
                end
              end,
              desc = "Insert a template",
            },
            ["<leader>OO"] = {
              function()
                if vim.fn.exists ":ObsidianOpen" == 2 then
                  vim.cmd "ObsidianOpen"
                else
                  return "<leader>OO"
                end
              end,
              desc = "Open in the Obsidian app",
            },
            ["<leader>Oq"] = {
              function()
                if vim.fn.exists ":ObsidianQuickSwitch" == 2 then
                  vim.cmd "ObsidianQuickSwitch"
                else
                  return "<leader>Oq"
                end
              end,
              desc = "Switch notes",
            },
            ["<leader>Or"] = {
              function()
                if vim.fn.exists ":ObsidianRename" == 2 then
                  vim.cmd "ObsidianRename"
                else
                  return "<leader>Or"
                end
              end,
              desc = "Rename note and update all references to it",
            },
          },
        },
        options = {
          opt = {
            wrap = true,
          },
        },
      },
    },
    -- {
    --   "Pocco81/auto-save.nvim",
    --   event = { "BufEnter  */Library/Mobile Documents/iCloud~md~obsidian/Documents/jshli-vault" },
    --   ft = { "markdown" },
    --   lazy = true,
    --   opts = {
    --     callbacks = {
    --       before_saving = function()
    --         -- save global autoformat status
    --         vim.g.OLD_AUTOFORMAT = vim.g.autoformat_enabled
    --
    --         vim.g.autoformat_enabled = false
    --         vim.g.OLD_AUTOFORMAT_BUFFERS = {}
    --         -- disable all manually enabled buffers
    --         for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    --           if vim.b[bufnr].autoformat_enabled then
    --             table.insert(vim.g.OLD_BUFFER_AUTOFORMATS, bufnr)
    --             vim.b[bufnr].autoformat_enabled = false
    --           end
    --         end
    --       end,
    --       after_saving = function()
    --         -- restore global autoformat status
    --         vim.g.autoformat_enabled = vim.g.OLD_AUTOFORMAT
    --         -- reenable all manually enabled buffers
    --         for _, bufnr in ipairs(vim.g.OLD_AUTOFORMAT_BUFFERS or {}) do
    --           vim.b[bufnr].autoformat_enabled = true
    --         end
    --       end,
    --     },
    --   },
    -- },
  },
  opts = {
    dir = vim.env.HOME .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/jshli-vault", -- specify the vault location. no need to call 'vim.fn.expand' here
    use_advanced_uri = true,
    finder = "telescope.nvim",

    templates = {
      subdir = "templates",
      date_format = "%d-%m-%Y-%a",
      time_format = "%H:%M",
    },

    daily_notes = {
      folder = "daily-notes",
      template = "templates/Daily note template",
    },

    note_frontmatter_func = function(note)
      -- This is equivalent to the default frontmatter function.
      local out = { id = note.id, aliases = note.aliases, tags = note.tags }
      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return suffix
    end,

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    follow_url_func = vim.ui.open or require("astrocore").system_open,
  },
}
