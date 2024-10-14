return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")

		-- Setup conform with desired formatters
		conform.setup({
			-- Auto format files on save
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 5000, -- Adjust timeout as necessary
			},
			-- Configure formatters per file type
			formatters_by_ft = {
				lua = { "stylua" }, -- Stylua for Lua files
				javascript = { "prettier" }, -- Prettier for JS files
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				python = { "black" }, -- Black for Python
				go = { "gopls" }, -- Use gopls for Go
				rust = { "rustfmt" }, -- Rustfmt for Rust
				html = { "prettier" },
				css = { "prettier" },
			},
		})

		-- Add keybinding for manual formatting (optional)
		vim.api.nvim_set_keymap("n", "<leader>cf", "<cmd>ConformFormat<CR>", { noremap = true, silent = true })
	end,
}
