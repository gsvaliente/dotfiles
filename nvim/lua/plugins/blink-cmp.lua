return {
  { "L3MON4D3/LuaSnip", keys = {} },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
    },
    -- event = "InsertEnter",
    version = "*",
    config = function()
      -- vim.cmd('highlight Pmenu guibg=none')
      -- vim.cmd('highlight PmenuExtra guibg=none')
      -- vim.cmd('highlight FloatBorder guibg=none')
      -- vim.cmd('highlight NormalFloat guibg=none')

      local cmp = require("blink.cmp")

      cmp.setup({
        snippets = { preset = "luasnip" },
        signature = { enabled = true },
        appearance = {
          use_nvim_cmp_as_default = false,
          nerd_font_variant = "normal",
        },
        sources = {
          default = { "lazydev", "lsp", "path", "buffer", "snippets" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
            -- laravel = {
            --     name = "laravel",
            --     module = "laravel.blink_source",
            -- },
            cmdline = {
              min_keyword_length = 2,
            },
          },
        },
        keymap = {
          -- ["<C-f>"] = {},
          ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
          ["<C-e>"] = { "hide", "fallback" },
          ["<CR>"] = { "accept", "fallback" },

          -- ["<Tab>"] = { "snippet_forward", "fallback" },
          -- ["<S-Tab>"] = { "snippet_backward", "fallback" },

          ["<S-Tab>"] = { "select_prev", "fallback" },
          ["<Tab>"] = { "select_next", "fallback" },
          ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
          ["<C-n>"] = { "select_next", "fallback_to_mappings" },

          ["<C-b>"] = { "scroll_documentation_up", "fallback" },
          ["<C-f>"] = { "scroll_documentation_down", "fallback" },

          ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        },
        cmdline = {
          enabled = false,
          completion = { menu = { auto_show = true } },
          keymap = {
            ["<CR>"] = { "accept_and_enter", "fallback" },
          },
        },
        completion = {
          menu = {
            border = nil,
            scrolloff = 1,
            scrollbar = false,
            draw = {
              columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "kind" },
                { "source_name" },
              },
            },
          },
          documentation = {
            window = {
              border = nil,
              scrollbar = false,
              winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
            },
            auto_show = true,
            auto_show_delay_ms = 500,
          },
        },
      })

      -- Integrate autopairs with blink.cmp
      local autopairs = require("nvim-autopairs")

      -- Hook into blink.cmp's accept event
      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuAccept",
        callback = function()
          autopairs.completion_confirm()
        end,
      })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
