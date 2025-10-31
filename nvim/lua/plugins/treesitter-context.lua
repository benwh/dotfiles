return {
  -- Show current position in file
  'nvim-treesitter/nvim-treesitter-context',
  config = function()
    require('treesitter-context').setup {
      max_lines = 3,
    }
  end,
}
