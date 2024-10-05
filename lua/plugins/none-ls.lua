return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Golang formatting (gofmt, goimports, golines)
        null_ls.builtins.formatting.gofmt,            -- Basic Go formatter
        null_ls.builtins.formatting.goimports,        -- Go formatter with imports organization
        null_ls.builtins.formatting.golines,          -- Go formatter for line length

        -- Python formatting (black, yapf, isort)
        null_ls.builtins.formatting.black,            -- Python formatter (PEP8 compliant)
        null_ls.builtins.formatting.yapf,             -- Alternative Python formatter
        null_ls.builtins.formatting.isort,            -- Sort Python imports

        -- TypeScript, JavaScript, TSX, JSX formatting (prettier)
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "tsx", "jsx" }
        }),

        -- Other formatters you already have (stylua, ruby, etc.)
        null_ls.builtins.formatting.stylua,           -- Lua formatter
        null_ls.builtins.diagnostics.erb_lint,        -- Ruby on Rails linter
        null_ls.builtins.diagnostics.rubocop,         -- Ruby linter
        null_ls.builtins.formatting.rubocop,          -- Ruby formatter
      },
    })

    -- Keymap to format the current buffer
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
