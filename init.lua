local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")
-- Copy to clipboard with Ctrl+C
vim.keymap.set("n", "<C-c>", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to clipboard" }) -- In Visual mode

-- Paste from clipboard with Ctrl+V
vim.keymap.set("n", "<C-v>", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("i", "<C-v>", "<C-r>+", { desc = "Paste from clipboard in insert mode" }) -- In Insert mode


