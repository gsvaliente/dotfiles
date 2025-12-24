return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    {
      "folke/snacks.nvim",
      opts = {
        input = {},
        picker = {},
        terminal = {},
      },
    },
  },
  -- Add lazy-loading trigger
  -- keys = {
  --   { "<leader>oc", mode = { "n", "x" } },
  --   { "<C-x>", mode = { "n", "x" } },
  --   { "go", mode = { "n", "x" } },
  --   { "goo", mode = "n" },
  --   { "<C-.>", mode = { "n", "t" } },
  -- },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      prompts = {
        code_reviewer = { prompt = "Review @buffer @code-reviewer", submit = true },
      },
    }

    vim.opt.autoread = true

    -- Keymaps with safety check
    local opencode_ok, opencode = pcall(require, "opencode")
    if not opencode_ok then
      vim.notify("opencode.nvim failed to load", vim.log.levels.ERROR)
      return
    end

    vim.keymap.set({ "n", "x" }, "<leader>of", function()
      return opencode.operator("@this ")
    end, { expr = true, desc = "Add object to opencode" })

    vim.keymap.set("n", "<leader>oi", function()
      return opencode.operator("@this ") .. "_"
    end, { expr = true, desc = "Add line to opencode" })

    vim.keymap.set({ "n", "x" }, "<leader>oa", function()
      opencode.ask(nil, { submit = true })
    end, { desc = "Ask opencode" })

    vim.keymap.set({ "n", "x" }, "<leader>ox", function()
      opencode.select()
    end, { desc = "Execute opencode action…" })

    vim.keymap.set({ "n", "t" }, "<leader>oo", function()
      opencode.toggle()
    end, { desc = "Toggle opencode" })

    vim.keymap.set("n", "<S-C-u>", function()
      opencode.command("session.half.page.up")
    end, { desc = "opencode half page up" })

    vim.keymap.set("n", "<S-C-d>", function()
      opencode.command("session.half.page.down")
    end, { desc = "opencode half page down" })

    vim.keymap.set("n", "<leader>os", function()
      opencode.single("Explain @this")
    end, { desc = "Single" })
  end,
}
