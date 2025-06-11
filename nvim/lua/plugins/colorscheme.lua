return {
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   opts = {
  --     variant = "moon",
  --     dark_variant = "moon",
  --     styles = {
  --       bold = true,
  --       italic = false,
  --       transparency = true,
  --     },
  --     -- disable_background = false,
  --     highlight_groups = {
  --       CurSearch = { fg = "base", bg = "leaf", inherit = false },
  --       Search = { fg = "text", bg = "leaf", blend = 20, inherit = false },
  --       Comment = { italic = true },
  --     },
  --     groups = {
  --       border = "muted",
  --       link = "iris",
  --       panel = "surface",
  --
  --       error = "love",
  --       hint = "iris",
  --       info = "foam",
  --       note = "pine",
  --       todo = "rose",
  --       warn = "gold",
  --
  --       git_add = "foam",
  --       git_change = "rose",
  --       git_delete = "love",
  --       git_dirty = "rose",
  --       git_ignore = "muted",
  --       git_merge = "iris",
  --       git_rename = "pine",
  --       git_stage = "iris",
  --       git_text = "rose",
  --       git_untracked = "subtle",
  --
  --       h1 = "iris",
  --       h2 = "foam",
  --       h3 = "rose",
  --       h4 = "gold",
  --       h5 = "pine",
  --       h6 = "foam",
  --     },
  --   },
  --   -- COMMENT TO ACTIVATE
  --   -- config = function(_, opts)
  --   --   require("rose-pine").setup(opts)
  --   --   vim.cmd("colorscheme rose-pine") -- optional
  --   -- end,
  -- },
  -- {
  --   "folke/tokyonight.nvim",
  --   name = "folkeTokyonight",
  --   -- priority = 1000,
  --   config = function()
  --     local transparent = true
  --     local bg = "#011628"
  --     local bg_dark = "#011423"
  --     local bg_highlight = "#143652"
  --     local bg_search = "#0A64AC"
  --     local bg_visual = "#275378"
  --     local fg = "#CBE0F0"
  --     local fg_dark = "#B4D0E9"
  --     local fg_gutter = "#627E97"
  --     local border = "#547998"
  --
  --     require("tokyonight").setup({
  --       style = "night",
  --       transparent = transparent,
  --
  --       styles = {
  --         comments = { italic = false },
  --         keywords = { italic = true },
  --         sidebars = transparent and "transparent" or "dark",
  --         floats = transparent and "transparent" or "dark",
  --       },
  --       on_colors = function(colors)
  --         colors.bg = transparent and colors.none or bg
  --         colors.bg_dark = transparent and colors.none or bg_dark
  --         colors.bg_float = transparent and colors.none or bg_dark
  --         colors.bg_highlight = bg_highlight
  --         colors.bg_popup = bg_dark
  --         colors.bg_search = bg_search
  --         colors.bg_sidebar = transparent and colors.none or bg_dark
  --         colors.bg_statusline = transparent and colors.none or bg_dark
  --         colors.bg_visual = bg_visual
  --         colors.border = border
  --         colors.fg = fg
  --         colors.fg_dark = fg_dark
  --         colors.fg_float = fg
  --         colors.fg_gutter = fg_gutter
  --         colors.fg_sidebar = fg_dark
  --       end,
  --     })
  --     -- comment to acticate or deactivate
  --     -- vim.cmd("colorscheme tokyonight")
  --
  --     -- NOTE: Auto switch to tokyonight for markdown files only
  --     -- vim.api.nvim_create_autocmd("FileType", {
  --     --     pattern = { "markdown" },
  --     --     callback = function()
  --     --         -- Ensure the theme switch only happens once for a buffer
  --     --         local buffer = vim.api.nvim_get_current_buf()
  --     --         if not vim.b[buffer].tokyonight_applied then
  --     --             if vim.fn.expand("%:t") ~= "" and vim.api.nvim_buf_get_option(0, "buftype") ~= "nofile" then
  --     --                 vim.cmd("colorscheme tokyonight")
  --     --             end
  --     --             vim.b[buffer].tokyonight_applied = true
  --     --         end
  --     --     end,
  --     -- })
  --   end,
  -- },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.05, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" }, -- Change the style of comments
          conditionals = {},
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = function(colors)
          return {
            NormalFloat = { bg = colors.base, fg = colors.text },
          }
        end,
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          snacks = true,
          harpoon = true,
          fzf = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })

      -- setup must be called before loading
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
