return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      variant = "moon", -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      dim_inactive_windows = true,
      extend_background_behind_borders = true,

      enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
      },

      styles = {
        bold = true,
        italic = false,
        transparency = false,
      },

      groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
      },

      palette = {
        -- Override the builtin palette per variant
        -- moon = {
        --     base = '#18191a',
        --     overlay = '#363738',
        -- },
      },

      -- NOTE: Highlight groups are extended (merged) by default. Disable this
      -- per group via `inherit = false`
      highlight_groups = {
        -- Comment = { fg = "foam" },
        -- StatusLine = { fg = "love", bg = "love", blend = 15 },
        -- VertSplit = { fg = "muted", bg = "muted" },
        -- Visual = { fg = "base", bg = "text", inherit = false },
        -- JSX/TSX Tags (HTML-like tags: <div>, <span>, etc.)
        ["@tag.tsx"] = { fg = "love" },
        ["@tag.jsx"] = { fg = "love" },
        ["@tag.delimiter.tsx"] = { fg = "foam" }, -- < and >
        ["@tag.delimiter.jsx"] = { fg = "foam" },

        -- JSX/TSX Components (PascalCase: <Button>, <MyComponent>, etc.)
        ["@tag.builtin.tsx"] = { fg = "pine" }, -- Built-in components
        ["@tag.builtin.jsx"] = { fg = "pine" },
        ["@constructor.tsx"] = { fg = "iris" }, -- Custom components
        ["@constructor.jsx"] = { fg = "iris" },

        -- Attributes
        -- ["@tag.attribute.tsx"] = { fg = "gold" },
        -- ["@tag.attribute.jsx"] = { fg = "gold" },
      },

      before_highlight = function(group, highlight, palette)
        -- Disable all undercurls
        -- if highlight.undercurl then
        --     highlight.undercurl = false
        -- end
        --
        -- Change palette colour
        -- if highlight.fg == palette.pine then
        --     highlight.fg = palette.foam
        -- end
      end,
    })

    -- vim.cmd("colorscheme rose-pine-main")
    -- vim.cmd("colorscheme rose-pine-moon")
    -- vim.cmd("colorscheme rose-pine-dawn")
    vim.cmd("colorscheme rose-pine")
  end,
}
--
-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("catppuccin").setup({
--       background = {
--         light = "latte",
--         dark = "frappe",
--       },
--       -- color_overrides = {
--       --   macchiato = {
--       --     rosewater = "#eb7a73",
--       --     flamingo = "#eb7a73",
--       --     red = "#eb7a73",
--       --     maroon = "#eb7a73",
--       --     pink = "#e396a4",
--       --     mauve = "#e396a4",
--       --     peach = "#e89a5e",
--       --     yellow = "#e8b267",
--       --     green = "#b9c675",
--       --     teal = "#99c792",
--       --     sky = "#99c792",
--       --     sapphire = "#99c792",
--       --     blue = "#8dbba3",
--       --     lavender = "#8dbba3",
--       --     text = "#f1e4c2",
--       --     subtext1 = "#e5d5b1",
--       --     subtext0 = "#c5bda3",
--       --     overlay2 = "#b8a994",
--       --     overlay1 = "#a39284",
--       --     overlay0 = "#656565",
--       --     surface2 = "#5d5d5d",
--       --     surface1 = "#505050",
--       --     surface0 = "#393939",
--       --     base = "#2e3233",
--       --     mantle = "#242727",
--       --     crust = "#1f2223",
--       --   },
--       -- },
--       transparent_background = true,
--       show_end_of_buffer = false,
--       integration_default = false,
--       integrations = {
--         blink = true,
--         gitsigns = true,
--         hop = true,
--         illuminate = { enabled = true },
--         native_lsp = { enabled = true, inlay_hints = { background = true } },
--         neogit = true,
--         neotree = true,
--         semantic_tokens = true,
--         treesitter = true,
--         treesitter_context = true,
--         vimwiki = true,
--         which_key = true,
--       },
--       custom_highlights = function(colors)
--         return {
--
--           ["@tag.builtin"] = { fg = colors.blue },
--           ["@tag"] = { fg = colors.pink },
--           ["@type.tsx"] = { fg = colors.pink },
--           ["@type.jsx"] = { fg = colors.pink },
--           ["@tag.delimiter"] = { fg = colors.teal },
--           ["@tag.attribute"] = { fg = colors.yellow, style = {} },
--
--           -- Rainbow delimiters
--           RainbowDelimiterRed = { fg = colors.red },
--           RainbowDelimiterOrange = { fg = colors.peach },
--           RainbowDelimiterYellow = { fg = colors.yellow },
--           RainbowDelimiterGreen = { fg = colors.green },
--           RainbowDelimiterViolet = { fg = colors.mauve },
--           RainbowDelimiterCyan = { fg = colors.teal },
--           RainbowDelimiterBlue = { fg = colors.blue },
--         }
--       end,
--     })
--     vim.api.nvim_command("colorscheme catppuccin")
--   end,
-- }
