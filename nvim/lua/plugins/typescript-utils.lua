return {
  {
    "dmmulroy/ts-error-translator.nvim",
    enabled = true,
    event = "BufEnter",
    config = function()
      require("ts-error-translator").setup({
        auto_attach = true,
        servers = {
          "vtsls",
          "astro",
          "svelte",
        },
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "BufEnter",
    ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "astro" },
    config = function()
      -- Independent nvim-ts-autotag setup
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true, -- Auto-close tags
          enable_rename = true, -- Auto-rename pairs
          enable_close_on_slash = false, -- Disable auto-close on trailing `</`
        },
        per_filetype = {
          ["html"] = {
            enable_close = true, -- Disable auto-closing for HTML
            enable_rename = true,
          },
          ["typescriptreact"] = {
            enable_close = true, -- Explicitly enable auto-closing (optional, defaults to `true`)
            enable_rename = true,
          },
        },
      })
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    enabled = true,
    -- event = "VeryLazy",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "astro" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        -- Expose all available TypeScript server commands
        expose_as_code_action = "all",
        -- Configure tsserver settings
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "none",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = false,
          includeInlayVariableTypeHints = false,
          includeInlayPropertyDeclarationTypeHints = false,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayEnumMemberValueHints = false,
        },
      },
      handlers = {
        -- Custom LSP handlers for better integration
      },
    },
    config = function(_, opts)
      require("typescript-tools").setup(opts)

      -- Keymaps for typescript-tools commands
      vim.keymap.set("n", "<leader>to", "<cmd>TSToolsOrganizeImports<cr>", { desc = "Organize Imports" })
      vim.keymap.set("n", "<leader>ts", "<cmd>TSToolsSortImports<cr>", { desc = "Sort Imports" })
      vim.keymap.set("n", "<leader>tu", "<cmd>TSToolsRemoveUnused<cr>", { desc = "Remove Unused" })
      vim.keymap.set("n", "<leader>td", "<cmd>TSToolsGoToSourceDefinition<cr>", { desc = "Go to Source Definition" })
      vim.keymap.set("n", "<leader>ti", "<cmd>TSToolsAddMissingImports<cr>", { desc = "Add Missing Imports" })
      vim.keymap.set("n", "<leader>tf", "<cmd>TSToolsFixAll<cr>", { desc = "Fix All" })
    end,
  },
}
