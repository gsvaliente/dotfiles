-- return {
--   "folke/tokyonight.nvim",
--   lazy = true,
--   opts = {
--     style = "storm",
--     transparent = false,
--     styles = {
--       -- keywords = { bold = true },
--     },
--     dim_inactive = true,
--   },
-- }
-- return {
--   "adibhanna/yukinord.nvim",
--   priority = 1000,
--   config = function()
--     require("yukinord").setup({
--       transparent = false,
--       transparent_sidebar = false,
--     })
--     vim.cmd([[colorscheme yukinord]])
--   end,
-- }
--
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      background = {
        light = "latte",
        dark = "frappe",
      },
      -- color_overrides = {
      --   macchiato = {
      --     rosewater = "#eb7a73",
      --     flamingo = "#eb7a73",
      --     red = "#eb7a73",
      --     maroon = "#eb7a73",
      --     pink = "#e396a4",
      --     mauve = "#e396a4",
      --     peach = "#e89a5e",
      --     yellow = "#e8b267",
      --     green = "#b9c675",
      --     teal = "#99c792",
      --     sky = "#99c792",
      --     sapphire = "#99c792",
      --     blue = "#8dbba3",
      --     lavender = "#8dbba3",
      --     text = "#f1e4c2",
      --     subtext1 = "#e5d5b1",
      --     subtext0 = "#c5bda3",
      --     overlay2 = "#b8a994",
      --     overlay1 = "#a39284",
      --     overlay0 = "#656565",
      --     surface2 = "#5d5d5d",
      --     surface1 = "#505050",
      --     surface0 = "#393939",
      --     base = "#2e3233",
      --     mantle = "#242727",
      --     crust = "#1f2223",
      --   },
      -- },
      transparent_background = true,
      show_end_of_buffer = false,
      integration_default = false,
      integrations = {
        blink = true,
        gitsigns = true,
        hop = true,
        illuminate = { enabled = true },
        native_lsp = { enabled = true, inlay_hints = { background = true } },
        neogit = true,
        neotree = true,
        semantic_tokens = true,
        treesitter = true,
        treesitter_context = true,
        vimwiki = true,
        which_key = true,
      },
      custom_highlights = function(colors)
        return {

          ["@tag.builtin"] = { fg = colors.blue },
          ["@tag"] = { fg = colors.pink },
          ["@type.tsx"] = { fg = colors.pink },
          ["@type.jsx"] = { fg = colors.pink },
          ["@tag.delimiter"] = { fg = colors.teal },
          ["@tag.attribute"] = { fg = colors.yellow },

          -- Rainbow delimiters
          RainbowDelimiterRed = { fg = colors.red },
          RainbowDelimiterOrange = { fg = colors.peach },
          RainbowDelimiterYellow = { fg = colors.yellow },
          RainbowDelimiterGreen = { fg = colors.green },
          RainbowDelimiterViolet = { fg = colors.mauve },
          RainbowDelimiterCyan = { fg = colors.teal },
          RainbowDelimiterBlue = { fg = colors.blue },
        }
      end,
    })
    vim.api.nvim_command("colorscheme catppuccin")
  end,
}
