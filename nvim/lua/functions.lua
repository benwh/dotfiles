-- Utility functions

-- Replace curly/smart quotes with regular quotes
vim.api.nvim_create_user_command('ReplaceSmartQuotes', function()
  vim.cmd [[%s/[’‘]/'/ge]]
  vim.cmd [[%s/[“”]/"/ge]]
end, { desc = 'Replace smart/curly quotes with regular quotes' })

-- vim: ts=2 sts=2 sw=2 et
