return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    config = function()
      require("oil").setup({
        default_file_explorer = true, -- start up nvim with oil instead of netrw
        columns = { "icon" },
        win_options = {
          signcolumn = "number",
        },
        keymaps = {
          ["<C-h>"] = false,
          ["<C-c>"] = false, -- prevent from closing Oil as <C-c> is esc key
          ["<C-v>"] = {
            callback = function()
              local oil = require("oil")
              oil.open_preview({ vertical = true, split = "botright" })
            end,
          },
          ["q"] = "actions.close",
        },
        delete_to_trash = true,
        view_options = {
          show_hidden = true,
        },
        skip_confirm_for_simple_edits = true,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function()
          vim.opt_local.cursorline = true
        end,
      })
    end,
    lazy = false,
  },
  {
    "SirZenith/oil-vcs-status",
    dependencies = { "stevearc/oil.nvim" },
    config = function()
      require("oil-vcs-status").setup({
        vcs_executable = {
          git = "git",
        },
        status_hl_group = {
          added = "GitSignsAdd",
          modified = "GitSignsChange",
          deleted = "GitSignsDelete",
          renamed = "GitSignsChange",
          untracked = "GitSignsAdd",
          ignored = "Comment",
        },
      })
    end,
  },
}
