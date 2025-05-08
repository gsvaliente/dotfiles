return {
  "rose-pine/neovim",
  name = "rose-pine",
  opts = {
    variant = "moon",
    dark_variant = "main",
    disable_background = true,
    highlight_groups = {
      CurSearch = { fg = "base", bg = "leaf", inherit = false },
      Search = { fg = "text", bg = "leaf", blend = 20, inherit = false },
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
  },
  config = function(_, opts)
    require("rose-pine").setup(opts)
    vim.cmd("colorscheme rose-pine") -- optional
  end,
}
