return {
  "windwp/nvim-ts-autotag",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-ts-autotag").setup({
      filetypes = { "html", "xml", "jsx", "tsx", "vue", "svelte" },  -- Specify filetypes for which autotag should be active
    })
  end,
}
