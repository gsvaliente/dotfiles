return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      prettier = {
        prepend_args = {
          "--print-width",
          "80",
          "--tab-width",
          "2",
          "--use-tabs",
          "false",
          "--semi",
          "false",
          "--single-quote",
          "false",
          "--jsx-single-quote",
          "false",
          "--trailing-comma",
          "es5",
          "--bracket-spacing",
          "true",
          "--bracket-same-line",
          "false",
          "--arrow-parens",
          "always",
          "--end-of-line",
          "lf",
        },
      },
    },
  },
}
