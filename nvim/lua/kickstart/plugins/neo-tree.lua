-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '-', '<cmd>Neotree toggle<CR>', desc = 'Neo-tree: toggle' },
    { '_', '<cmd>Neotree reveal reveal_force_cwd<CR>', desc = 'Neo-tree: reveal current file' },
    { '<Leader>-', '<cmd>Neotree float buffers<CR>', desc = 'Neo-tree: show buffers' },
  },
  opts = {
    buffers = {
      show_unloaded = true,
    },
  },
}
