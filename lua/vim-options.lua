vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.background = "transparent"

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.wo.number = true
-- Enable relative line numbers
vim.opt.nu = true
vim.opt.rnu = true

-- Enable auto indenting and set it to spaces
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
--
-- -- Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
vim.opt.breakindent = true
--
-- -- Enable incremental searching
vim.opt.incsearch = true
vim.opt.hlsearch = true
--
-- -- Disable text wrap
vim.opt.wrap = false
--
-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "
--
-- -- Better splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Set completeopt to have a better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Enable the sign column to prevent the screen from jumping
vim.opt.signcolumn = "yes"

vim.api.nvim_create_user_command("Wc", function(args)
	vim.cmd("wincmd " .. args.args)
end, { nargs = 1 })
