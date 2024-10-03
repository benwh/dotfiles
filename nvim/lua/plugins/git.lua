return {
  {
    'tpope/vim-fugitive',
    dependencies = {
      -- GitHub support
      'tpope/vim-rhubarb',
    },
    config = function()
      vim.keymap.set('n', 'gB', '<cmd>Git blame<CR>', { desc = 'git [B]lame' })
    end,
  },
}
