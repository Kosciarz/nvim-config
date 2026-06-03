-- ============================================================
--  config/options.lua  –  core editor settings
-- ============================================================

local opt = vim.opt

-- Appearance
opt.number         = true          -- absolute line numbers
opt.relativenumber = true          -- + relative (gives you both)
opt.cursorline     = true          -- highlight current line
opt.signcolumn     = "yes"         -- always show sign column (no layout shifts)
opt.scrolloff      = 8             -- keep 8 lines above/below cursor
opt.termguicolors  = true          -- 24-bit colour

-- Indentation (override per filetype in after/ftplugin if needed)
opt.tabstop        = 4
opt.shiftwidth     = 4
opt.expandtab      = true          -- spaces, not tabs
opt.smartindent    = true

-- Search
opt.ignorecase     = true
opt.smartcase      = true          -- case-sensitive when query has uppercase
opt.hlsearch       = false         -- don't keep matches highlighted after search

-- Splits
opt.splitbelow     = true
opt.splitright     = true

-- Files
opt.swapfile       = false
opt.undofile       = true          -- persistent undo across sessions
opt.updatetime     = 250           -- faster CursorHold / diagnostics

-- Clipboard  (requires xclip/xsel on Linux or pbcopy on macOS)
opt.clipboard      = "unnamedplus"

-- Misc
opt.wrap           = false
opt.mouse          = "a"
opt.completeopt    = { "menuone", "noinsert", "noselect" }
