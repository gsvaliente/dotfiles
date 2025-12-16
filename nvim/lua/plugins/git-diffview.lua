return {
  "sindrets/diffview.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
  keys = {
    { "<leader>dvo", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    { "<leader>dvc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    { "<leader>dvh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    { "<leader>dvH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch History" },
  },
  opts = {
    enhanced_diff_hl = true,
    use_icons = true,

    view = {
      default = {
        layout = "diff2_horizontal",
      },
      merge_layout = {
        layout = "diff3_mixed",
      },
    },

    file_panel = {
      listing_style = "tree",
      win_config = {
        position = "left",
        width = 35,
      },
    },
  },
}
