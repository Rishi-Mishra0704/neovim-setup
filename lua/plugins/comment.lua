return {
  "numToStr/Comment.nvim",
  config = function()
    require('Comment').setup({
      toggler = {
        line = 'gcc',  -- Toggle line comments
        block = 'gbc', -- Toggle block comments
      },
      opleader = {
        line = 'gc',   -- Line comments in visual mode
        block = 'gb',  -- Block comments in visual mode
      },
      mappings = {
        basic = true,  -- Includes `gcc` and `gc` mappings
        extra = true,  -- Includes `gco`, `gcO`, `gcA` mappings
      },
    })
  end,
}
