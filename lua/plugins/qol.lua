-- ============================================================
--  plugins/qol.lua  –  quality-of-life extras
-- ============================================================

return {
    -- Auto-close brackets / quotes
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts  = {},
    },

    -- gcc / gc  to toggle comments
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts  = {},
    },

    -- Minimal statusline (no icons needed, works without Nerd Font)
    {
        "nvim-lualine/lualine.nvim",
        event = "VimEnter",
        opts = {
            options = {
                icons_enabled        = false,
                theme                = "auto",
                section_separators   = "",
                component_separators = "|",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { { "filename", path = 1 } }, -- relative path
                lualine_x = { "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },

    -- Git signs in the gutter (]c / [c to jump between hunks)
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            signs = {
                add          = { text = "+" },
                change       = { text = "~" },
                delete       = { text = "-" },
                topdelete    = { text = "‾" },
                changedelete = { text = "~" },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs,
                        { buffer = bufnr, silent = true, desc = desc })
                end
                map("n", "]c", gs.next_hunk, "Next git hunk")
                map("n", "[c", gs.prev_hunk, "Prev git hunk")
                map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
                map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
                map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
            end,
        },
    },

    -- Show pending keybinds
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts  = { delay = 500 },
    },
}
