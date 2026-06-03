-- ============================================================
--  plugins/treesitter.lua  –  syntax highlighting & indenting
-- ============================================================

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "markdown" },
    highlight        = { enable = true },
    indent           = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
