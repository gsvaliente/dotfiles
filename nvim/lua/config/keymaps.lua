local opts = { noremap = true, silent = true }
local map = vim.keymap.set

vim.g.mapleader = " "

-- Remove default LSP keymaps from Neovim 0.11
vim.keymap.del("n", "grn")
vim.keymap.del("n", "gra")
vim.keymap.del("v", "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "gO")
vim.keymap.del("i", "<C-s>")

-- Show float error
map("n", "<Leader>cd", function()
  vim.diagnostic.open_float()
end, { desc = "Open diagnostic as float" })

map("n", "<Leader>vd", function()
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end, { desc = "Go to definition in vertical split" })

-- clear highlight of searched word
map("n", "<Esc>", "<cmd>noh<CR><Esc>", { desc = "Clear search highlight" })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Move selected line / block of text in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Fast saving
map("n", "<Leader>ww", ":write!<CR>", opts)
map("n", "<Leader>q", ":q!<CR>", opts)

-- Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- paste over currently selected text without yanking it
map("v", "p", '"_dp')
map("v", "P", '"_dP')

-- copy everything between { and } including the brackets
-- p puts text after the cursor,
-- P puts text before the cursor.
map("n", "YY", "va{Vy", opts)

-- Move line on the screen rather than by line in the file
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- Split windows
map("n", "<leader>S", "<cmd>split<CR>", opts)
map("n", "<leader>V", "<cmd>vsplit<CR>", opts)

-- Exit on jj and jk
map("i", "jj", "<ESC>", opts)
map("i", "jk", "<ESC>", opts)

-- Open space with no insert mode
map("n", "<leader><CR>", "o<Esc>", opts)

-- Map enter to ciw in normal mode
map("n", "<CR>", "ciw", opts)
-- map("n", "<BS>", "ci", opts)

-- Select all
map("n", "<C-a>", "ggVG", opts)

-- PLUGINS
-- OIL
vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory in Oil" })

-- TMUX NAVIGATION
-- map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", opts)
-- map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", opts)
-- map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", opts)
-- map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", opts)
-- map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", opts)

-- Close Current Split
map("n", "<Leader>sx", "<cmd>close<CR>", { desc = "Close Current Split" })

-- Replace the word cursor is on globally
-- map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
--     { desc = "Replace word cursor is on globally" })
-- Toggle LSP diagnostics visibility
local isLspDiagnosticsVisible = true
vim.keymap.set("n", "<leader>lx", function()
  isLspDiagnosticsVisible = not isLspDiagnosticsVisible
  vim.diagnostic.config({
    virtual_text = isLspDiagnosticsVisible,
    underline = isLspDiagnosticsVisible,
  })
end, { desc = "Toggle LSP diagnostics" })
