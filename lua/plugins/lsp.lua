-- ============================================================
--  plugins/lsp.lua  –  LSP via mason + clangd + cmake (nvim 0.11 API)
-- ============================================================

return {
    -- Mason: installs LSP servers, DAP adapters, linters, formatters
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        opts  = { ui = { border = "rounded" } },
    },

    -- mason-lspconfig bridges Mason ↔ vim.lsp.config
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed       = { "clangd", "cmake", "jsonls" },
            automatic_installation = true,
        },
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            -- ── 1. Keymaps + format on save (attached when any LSP connects) ──
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs,
                            { buffer = ev.buf, silent = true, desc = desc })
                    end

                    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
                    map("n", "gr", vim.lsp.buf.references, "References")
                    map("n", "K", vim.lsp.buf.hover, "Hover docs")
                    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
                    map("n", "<leader>f", function()
                        vim.lsp.buf.format({ async = true })
                    end, "Format buffer")

                    -- Format on save (sync so file is written after formatting)
                    -- Format on save
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer   = ev.buf,
                        callback = function()
                            local ft = vim.bo[ev.buf].filetype
                            if ft == "cpp" or ft == "c" then
                                vim.lsp.buf.format({ async = false, name = "clangd" })
                            end
                        end,
                    })
                end,
            })

            -- ── 2. Rounded borders for hover / signature help ────────
            vim.lsp.config("*", {
                capabilities = vim.lsp.protocol.make_client_capabilities(),
            })

            local _open_floating_preview = vim.lsp.util.open_floating_preview
            vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
                opts        = opts or {}
                opts.border = opts.border or "rounded"
                return _open_floating_preview(contents, syntax, opts, ...)
            end

            -- ── 3. clangd ────────────────────────────────────────────
            vim.lsp.config("clangd", {
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--completion-style=detailed",
                    "--header-insertion=iwyu",
                },
            })
            vim.lsp.enable("clangd")

            -- ── 4. cmake-language-server ──────────────────────────────
            vim.lsp.config("cmake", {
                cmd          = { "cmake-language-server" },
                filetypes    = { "cmake" },
                root_markers = { "CMakeLists.txt", "cmake" },
            })
            vim.lsp.enable("cmake")

            -- ── 5. jsonls – JSON schema validation ───────────────────
            vim.lsp.config("jsonls", {
                cmd          = { "vscode-json-language-server", "--stdio" },
                filetypes    = { "json", "jsonc" },
                root_markers = { ".git", "CMakeLists.txt" },
                settings     = {
                    json = {
                        schemas = {
                            {
                                fileMatch = { "CMakePresets.json", "CMakeUserPresets.json" },
                                url       =
                                "https://raw.githubusercontent.com/Kitware/CMake/master/Help/manual/presets/schema.json",
                            },
                            {
                                fileMatch = { "package.json" },
                                url       = "https://json.schemastore.org/package.json",
                            },
                        },
                        validate = { enable = true },
                    },
                },
            })
            vim.lsp.enable("jsonls")
        end,
    },
}
