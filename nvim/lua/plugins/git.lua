return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', 'gB', '<cmd>Git blame<CR>', { desc = 'git [B]lame' })
    end,
  },
}
