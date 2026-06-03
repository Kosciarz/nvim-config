-- ============================================================
--  after/ftplugin/cpp.lua
--  Runs automatically for every C++ buffer.
-- ============================================================

local opt = vim.opt_local

-- CP typically prefers 4-space indents (matches most OJs)
opt.tabstop    = 4
opt.shiftwidth = 4
opt.expandtab  = true

-- Auto-insert CP boilerplate when opening a new, empty .cpp file
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern  = "*.cpp",
  callback = function()
    local template = {
      "#include <bits/stdc++.h>",
      "using namespace std;",
      "",
      "int main() {",
      "    ios_base::sync_with_stdio(false);",
      "    cin.tie(NULL);",
      "",
      "    ",
      "",
      "    return 0;",
      "}",
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, template)
    -- Place cursor on the blank line inside main
    vim.api.nvim_win_set_cursor(0, { 8, 4 })
    vim.cmd("startinsert!")
  end,
})
