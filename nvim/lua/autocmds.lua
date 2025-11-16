-- Autocmds from migrated vim config

-- Highlight redundant whitespace (trailing spaces, spaces before tabs)
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('RedundantSpaces', { clear = true }),
  desc = 'Highlight trailing whitespace and spaces before tabs',
  callback = function()
    if vim.bo.filetype ~= '' and vim.bo.buftype == '' then
      vim.fn.matchadd('RedundantSpaces', [[\s\+$\| \+\ze\t]])
    end
  end,
})

-- Define the RedundantSpaces highlight group
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('RedundantSpacesHighlight', { clear = true }),
  desc = 'Define RedundantSpaces highlight group',
  callback = function()
    vim.api.nvim_set_hl(0, 'RedundantSpaces', { bg = 'red', fg = 'red', ctermfg = 'red', ctermbg = 'red' })
  end,
})

-- Set the highlight immediately
vim.api.nvim_set_hl(0, 'RedundantSpaces', { bg = 'red', fg = 'red', ctermfg = 'red', ctermbg = 'red' })

-- vim: ts=2 sts=2 sw=2 et
