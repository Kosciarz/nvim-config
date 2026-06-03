-- ============================================================
--  config/keymaps.lua  –  all custom key mappings
-- ============================================================

vim.g.mapleader      = " "   -- <Space> as leader
vim.g.maplocalleader = " "

local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- ── File / Buffer ─────────────────────────────────────────────
map("n", "<leader>w", "<cmd>w<cr>",  "Save")
map("n", "<leader>q", "<cmd>q<cr>",  "Quit")
map("n", "<leader>x", "<cmd>x<cr>",  "Save & quit")

-- ── Window navigation ─────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", "Window left")
map("n", "<C-l>", "<C-w>l", "Window right")
map("n", "<C-j>", "<C-w>j", "Window down")
map("n", "<C-k>", "<C-w>k", "Window up")

-- ── Move lines up/down (visual mode) ─────────────────────────
map("v", "J", ":m '>+1<cr>gv=gv", "Move selection down")
map("v", "K", ":m '<-2<cr>gv=gv", "Move selection up")

-- ── Keep cursor centred when jumping ─────────────────────────
map("n", "<C-d>", "<C-d>zz", "Scroll down (centred)")
map("n", "<C-u>", "<C-u>zz", "Scroll up (centred)")
map("n", "n",     "nzzzv",   "Next match (centred)")
map("n", "N",     "Nzzzv",   "Prev match (centred)")

-- ── Paste without losing register ────────────────────────────
map("x", "<leader>p", '"_dP', "Paste without overwriting register")

-- ── Diagnostics ───────────────────────────────────────────────
map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
map("n", "<leader>e", vim.diagnostic.open_float, "Diagnostic float")

-- ── Buffer navigation ────────────────────────────────────────
map("n", "<Tab>",      "<cmd>bnext<cr>",     "Next buffer")
map("n", "<S-Tab>",    "<cmd>bprevious<cr>", "Prev buffer")
map("n", "<leader>bd", "<cmd>bdelete<cr>",   "Close buffer")

-- ── Compile & run (C++ – single file, CP workflow) ───────────
--   <leader>cc  compile current file  →  ./out
--   <leader>cr  run ./out
--   <leader>cb  compile + run in one shot
map("n", "<leader>cc",
  "<cmd>!g++ -std=c++17 -O2 -Wall -o out %<cr>",
  "C++: compile")
map("n", "<leader>cr",
  "<cmd>!./out<cr>",
  "C++: run")
map("n", "<leader>cb",
  "<cmd>!g++ -std=c++17 -O2 -Wall -o out % && ./out<cr>",
  "C++: compile & run")
