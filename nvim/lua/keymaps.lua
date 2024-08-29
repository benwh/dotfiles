-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal via double-Escape, rather than <C-\><C-n>.
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Buffer navigation
vim.keymap.set('n', '<Tab>', ':bnext!<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', ':bprevious!<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<C-e>', ':b#<CR>', { desc = 'Last buffer' })

-- Old habits...
vim.keymap.set('n', '<Bslash>h', ':bprevious!<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<Bslash>l', ':bnext!<CR>', { desc = 'Next buffer' })

-- Quick repeat of indentation
vim.keymap.set('v', '>', '>gv', { desc = 'Next buffer' })
vim.keymap.set('v', '<', '<gv', { desc = 'Next buffer' })

vim.keymap.set('n', '<Leader>l', ':set list!<CR>', { desc = 'Show whitespace' })

-- Clear search results
vim.keymap.set('n', '<C-n>', ':silent nohlsearch<CR>', { desc = 'Show whitespace' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- [[ User commands ]]

-- :W to sudo write
vim.api.nvim_create_user_command('W', ':execute ":silent w !sudo tee % > /dev/null" | :edit!', {})

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank { timeout = 500 }
  end,
})

-- vim: ts=2 sts=2 sw=2 et
