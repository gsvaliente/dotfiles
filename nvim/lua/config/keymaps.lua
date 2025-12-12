-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local opts = { noremap = true, silent = true }
local map = vim.keymap.set

vim.g.mapleader = " "

map("n", "<Leader>vd", function()
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end, { desc = "Go to definition in vertical split" })

-- clear highlight of searched word
map("n", "<Esc>", "<cmd>noh<CR><Esc>", { desc = "Clear search highlight" })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

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
map("n", "YY", "va{Vy", opts)
-- p puts text after the cursor,
-- P puts text before the cursor.

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

-- Close Current Split
map("n", "<Leader>sx", "<cmd>close<CR>", { desc = "Close Current Split" })

-- PLUGINS
-- OIL
vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory in Oil" })
