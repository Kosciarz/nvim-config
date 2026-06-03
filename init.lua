-- ============================================================
--  init.lua  –  entry point
--  Load order: options → keymaps → bootstrap lazy → plugins
-- ============================================================

require("config.options")
require("config.keymaps")
require("config.lazy")   -- bootstraps lazy.nvim and loads plugins/
