return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { 
          "c", "lua", "vim", "vimdoc", "query",
          -- Web development languages
          "html", "css", "javascript", "typescript", "tsx",
          "json", "yaml", "graphql", "vue", "svelte", "astro",
          "php", "scss", "markdown", "regex", 
          -- Server-side languages commonly used in web dev
          "python", "ruby", "go", "java", "prisma"
        },
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        highlight = {
          enable = true,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },

        indent = { enable = true },

        -- Optional: Enable incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            -- init_selection = "gnn",
            -- node_incremental = "grn",
            -- scope_incremental = "grc",
            -- node_decremental = "grm",
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<Backspace>",
          },
        },

        -- Optional: Enable text objects
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = { query = "@function.outer", desc = "Select outer part of a function region" }, 
              ["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
              ["ir"] = { query = "@return.inner", desc = "Select inner part of a return region"},
              ["ar"] = { query = "@return.outer", desc = "Select outer part of a return region"},
              ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop region"},
              ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop region"},
              -- ["ac"] = "@class.outer",
              -- ["ic"] = "@class.inner",
            },
          },
        },
      })
    end,
  },
}
