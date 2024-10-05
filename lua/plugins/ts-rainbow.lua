return {
  "p00f/nvim-ts-rainbow",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-treesitter.configs").setup {
      rainbow = {
        enable = true,
        extended_mode = true,  -- Highlight non-bracket delimiters (like html tags)
        max_file_lines = 1000, -- Disable for files with more than 1000 lines
      },
    }
  end,
}
