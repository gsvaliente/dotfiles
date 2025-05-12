return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    local function has_eslint_config()
      local config_files = {
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.json",
        "eslint.config.js",
        "eslint.config.mjs",
      }
      for _, filename in ipairs(config_files) do
        local path = vim.fn.getcwd() .. "/" .. filename
        if vim.fn.filereadable(path) == 1 then
          -- print("Found ESLint config: " .. path) -- Debug
          return true
        end
      end
      -- print("No ESLint config found") -- Debug
      return false
    end

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
    }

    -- Custom parser for eslint_d JSON output
    local function parse_eslint_json(output)
      if output == "" then
        return {}
      end
      local diagnostics = {}
      local ok, data = pcall(vim.fn.json_decode, output)
      if not ok or type(data) ~= "table" then
        return {}
      end

      for _, result in ipairs(data) do
        if result.messages then
          for _, message in ipairs(result.messages) do
            if message.message and message.line then
              table.insert(diagnostics, {
                lnum = message.line - 1, -- 0-based for Neovim
                col = (message.column or 1) - 1, -- 0-based
                message = message.message,
                severity = message.severity == 2 and vim.diagnostic.severity.ERROR
                  or vim.diagnostic.severity.WARN,
                source = "eslint_d",
                code = message.ruleId or nil,
              })
            end
          end
        end
      end
      return diagnostics
    end

    lint.linters.eslint_d = {
      cmd = "eslint_d", -- Or "./node_modules/.bin/eslint_d" for local
      stdin = true,
      args = {
        "--format",
        "json",
        "--stdin",
        "--stdin-filename",
        function()
          return vim.fn.expand("%:p")
        end,
      },
      stream = "stdout",
      ignore_exitcode = true,
      parser = parse_eslint_json, -- Use custom JSON parser
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        if has_eslint_config() then
          lint.try_lint()
        end
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      if has_eslint_config() then
        lint.try_lint()
      else
        vim.notify("No ESLint config found", vim.log.levels.WARN)
      end
    end, { desc = "Trigger linting for current file" })
  end,
}
-- return {
--   "mfussenegger/nvim-lint",
--   event = { "BufReadPre", "BufNewFile", "BufWinEnter" },
--   config = function()
--     local lint = require("lint")
--
--     local function has_eslint_config()
--       local config_files = {
--         ".eslintrc",
--         ".eslintrc.js",
--         ".eslintrc.cjs",
--         ".eslintrc.json",
--         "eslint.config.js",
--         "eslint.config.mjs",
--       }
--       for _, filename in ipairs(config_files) do
--         if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. filename) == 1 then
--           return true
--         end
--       end
--       return false
--     end
--
--     lint.linters_by_ft = {
--       javascript = { "eslint_d" },
--       typescript = { "eslint_d" },
--       javascriptreact = { "eslint_d" },
--       typescriptreact = { "eslint_d" },
--       svelte = { "eslint_d" },
--     }
--
--     lint.linters.eslint_d.args = {
--       "--no-warn-ignored",
--       "--format",
--       "json",
--       "--stdin",
--       "--stdin-filename",
--       function()
--         return vim.fn.expand("%:p")
--       end,
--     }
--
--     local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
--     vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
--       group = lint_augroup,
--       callback = function()
--         if has_eslint_config() then
--           lint.try_lint()
--         end
--       end,
--     })
--
--     vim.keymap.set("n", "<leader>l", function()
--       if has_eslint_config() then
--         lint.try_lint()
--       else
--         vim.notify("No ESLint config found", vim.log.levels.WARN)
--       end
--     end, { desc = "Trigger linting for current file" })
--   end,
-- }
-- return {
--   "mfussenegger/nvim-lint",
--   event = { "BufReadPre", "BufNewFile", "BufWinEnter" },
--   config = function()
--     local lint = require("lint")
--
--     local function has_eslint_config()
--       local config_files = {
--         ".eslintrc",
--         ".eslintrc.js",
--         ".eslintrc.cjs",
--         ".eslintrc.json",
--         "eslint.config.js",
--         "eslint.config.mjs",
--       }
--       --   for _, filename in ipairs(config_files) do
--       --     if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. filename) == 1 then
--       --       return true
--       --     end
--       --   end
--       --   return false
--       -- end
--       for _, filename in ipairs(config_files) do
--         -- Use vim.loop.fs_stat to check for file existence more reliably
--         local config_path = vim.fn.getcwd() .. "/" .. filename
--         if vim.loop.fs_stat(config_path) then
--           return true
--         end
--       end
--
--       -- Also check for parent directory configs
--       local parent_config_path = vim.fn.getcwd() .. "/../" .. config_files[1]
--       if vim.loop.fs_stat(parent_config_path) then
--         return true
--       end
--
--       return false
--     end
--
--     lint.linters_by_ft = {
--       javascript = { "eslint_d" },
--       typescript = { "eslint_d" },
--       javascriptreact = { "eslint_d" },
--       typescriptreact = { "eslint_d" },
--       svelte = { "eslint_d" },
--       jsx = { "eslint_d" },
--       tsx = { "eslint_d" },
--     }
--
--     lint.linters.eslint_d.args = function(bufnr)
--       return {
--         "--config",
--         "eslint.config.js", -- Specify the flat config file
--         "--format",
--         "json",
--         "--ext",
--         ".js,.jsx,.ts,.tsx",
--         vim.fn.expand("%:p"),
--       }
--     end
--     local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
--     vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
--       group = lint_augroup,
--       callback = function()
--         if has_eslint_config() then
--           lint.try_lint()
--         end
--       end,
--     })
--
--     vim.keymap.set("n", "<leader>l", function()
--       if has_eslint_config() then
--         lint.try_lint()
--       else
--         vim.notify("No ESLint config found", vim.log.levels.WARN)
--       end
--     end, { desc = "Trigger linting for current file" })
--   end,
-- }
-- return {
--   "mfussenegger/nvim-lint",
--   event = { "BufReadPre", "BufNewFile", "BufWinEnter" },
--   config = function()
--     require("lint").try_lint(nil, { ignore_errors = true })
--     local lint = require("lint")
--     local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
--     local eslint = lint.linters.eslint_d
--
--     -- if Eslint error configuration not found : change MasonInstall eslint@version or npm i -g eslint at a specific version
--     lint.linters_by_ft = {
--       javascript = { "eslint_d" },
--       typescript = { "eslint_d" },
--       javascriptreact = { "eslint_d" },
--       typescriptreact = { "eslint_d" },
--       svelte = { "eslint_d" },
--       -- python = { "pylint" },
--
--       -- javascript = { "eslint" },
--       -- typescript = { "eslint" },
--       -- javascriptreact = { "eslint" },
--       -- typescriptreact = { "eslint" },
--       -- svelte = { "eslint" },
--     }
--
--     eslint.args = {
--       "--no-warn-ignored",
--       "--format",
--       "json",
--       "--stdin",
--       "--stdin-filename",
--       function()
--         return vim.fn.expand("%:p")
--       end,
--     }
--
--     vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
--       group = lint_augroup,
--       callback = function()
--         lint.try_lint()
--       end,
--     })
--
--     vim.keymap.set("n", "<leader>l", function()
--       lint.try_lint()
--     end, { desc = "Trigger linting for current file" })
--   end,
-- }
