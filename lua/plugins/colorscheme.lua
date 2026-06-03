-- ============================================================
--  plugins/colorscheme.lua
-- ============================================================

return {
	"EdenEast/nightfox.nvim",
	name = "nightfox",
	priority = 1000,
	opts = {},
	config = function(_, opts)
		require("nightfox").setup(opts)
		vim.cmd.colorscheme("carbonfox")
	end,
}

-- return {
--     "Mofiqul/vscode.nvim",
--     name = "vscode",
--     priority = 1000,
--     config = function(_, opts)
--         require("vscode").setup(opts)
--         vim.cmd.colorscheme("vscode")
--     end,
-- }

-- return {
--     "catppuccin/nvim",
--     name  = "catppuccin",
--     priority = 1000, -- load before everything else
--     op = {
--         -- flavour = "mocha",
--         integrations = {
--             treesitter = true,
--             c = true,
--         },
--     },
--     config = function(_, opts)
--         require("catppuccin").setup(opts)
--         vim.cmd.colorscheme("catppuccin")
--     end,
-- }
