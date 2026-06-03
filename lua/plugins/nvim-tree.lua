-- ============================================================
--  plugins/nvim-tree.lua  –  file explorer
-- ============================================================

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>tt", "<cmd>NvimTreeToggle<cr>",   desc = "Toggle file tree" },
        { "<leader>tf", "<cmd>NvimTreeFindFile<cr>", desc = "Reveal current file in tree" },
    },
    opts = {
        hijack_netrw  = true,   -- replace netrw
        view = {
            width = 35,
            side  = "left",
        },
        renderer = {
            group_empty    = true,   -- collapse single-child dirs
            highlight_git  = true,
            icons = {
                git_placement = "after",
                glyphs = {
                    git = {
                        unstaged  = "~",
                        staged    = "+",
                        untracked = "?",
                        deleted   = "-",
                        ignored   = "◌",
                    },
                },
            },
        },
        filters = {
            dotfiles = false,   -- show dotfiles (.clangd, .clang-format, etc.)
            custom   = { "^.git$", "^build$" },  -- hide .git and build dirs
        },
        git = { enable = true },
        actions = {
            open_file = {
                quit_on_open = true,   -- close tree after opening a file
            },
        },
        -- Automatically close Neovim if nvim-tree is the last window
        on_attach = function(bufnr)
            local api = require("nvim-tree.api")
            -- default mappings
            api.config.mappings.default_on_attach(bufnr)
            -- extra: cd into directory with C
            vim.keymap.set("n", "C", api.tree.change_root_to_node,
                { buffer = bufnr, silent = true, desc = "Tree: cd into dir" })
        end,
    },
    init = function()
        -- Close Neovim if nvim-tree is the last open window
        vim.api.nvim_create_autocmd("QuitPre", {
            callback = function()
                local wins = vim.api.nvim_list_wins()
                local non_tree = vim.tbl_filter(function(w)
                    local buf = vim.api.nvim_win_get_buf(w)
                    return vim.bo[buf].filetype ~= "NvimTree"
                end, wins)
                if #non_tree == 0 then
                    vim.cmd("NvimTreeClose")
                end
            end,
        })
    end,
}
