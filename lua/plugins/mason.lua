local plugins = {
	-- Mason: Tool to install/manage LSP servers, linters, and formatters
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- Automatically update Mason on install
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason LSPConfig: Integration between Mason and lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls", -- Go language server
					"pyright", -- Python language server
					"typescript-language-server", -- TypeScript and JSX server
					"solargraph", -- Ruby language server
					"html-lsp", -- HTML language server
					"css-lsp", -- CSS language server
					-- "lua-language-server",       -- Uncomment for Lua support
					-- "rust-analyzer",             -- Uncomment for Rust support
				},
			})

			-- Set up lspconfig for each server
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Function to attach LSP mappings
			local on_attach = function(client, bufnr)
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
				vim.keymap.set("n", "<leader>oi", function()
					vim.lsp.buf.format({ async = true })
				end, bufopts) -- organize imports

				-- Additional LSP key mappings
				vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, bufopts) -- Format document
				vim.keymap.set("n", "<leader>ds", vim.lsp.buf.document_symbol, bufopts) -- Document symbols
				vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, bufopts) -- Workspace symbols
			end

			-- Diagnostic signs configuration
			vim.fn.sign_define("DiagnosticSignError", { text = "✖", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = "⚠", texthl = "DiagnosticSignWarn" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = "ℹ", texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "➤", texthl = "DiagnosticSignHint" })

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				update_in_insert = false,
				underline = true,
				severity_sort = true,
			})

			-- Go (gopls) configuration
			lspconfig.gopls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					gopls = {
						gofumpt = true, -- Enforce stricter formatting
						staticcheck = true, -- Enable more static analysis checks
						completeUnimported = true, -- Auto-import packages as you type
						usePlaceholders = true, -- Show placeholders for function parameters
					},
				},
			})

			-- Python (pyright) configuration
			lspconfig.pyright.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			--  TypeScript/JavaScript (typescript-language-server) configuration
			lspconfig.ts_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
			})
			-- Ruby (solargraph) configuration
			lspconfig.solargraph.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			-- Auto-format on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
				pattern = "*",
				callback = function()
					vim.lsp.buf.format(nil, 1000)
				end,
			})
		end,
	},

	-- Autocompletion Plugin
	{
		"hrsh7th/nvim-cmp", -- Completion plugin
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
			"hrsh7th/cmp-buffer", -- Buffer completions
			"hrsh7th/cmp-path", -- Path completions
			"saadparwaiz1/cmp_luasnip", -- Snippet completions
			"L3MON4D3/LuaSnip", -- Snippet engine
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = {
					-- Confirm completion with Enter or Tab
					["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
					["<C-e>"] = cmp.mapping.close(), -- Close the completion menu

					-- Navigate the completion items
					["<C-n>"] = cmp.mapping.select_next_item(), -- Next item
					["<C-p>"] = cmp.mapping.select_prev_item(), -- Previous item

					-- Fallback to default behavior for Enter
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm with Enter
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item() -- Select next item
						else
							fallback() -- Fallback to default behavior
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item() -- Select previous item
						else
							fallback() -- Fallback to default behavior
						end
					end, { "i", "s" }),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},

	-- Snippet Plugin (Optional, but recommended)
	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip").setup({
				history = true,
				update_events = "TextChanged,TextChangedI",
			})
		end,
	},
}

-- Return the configured plugins
return plugins
