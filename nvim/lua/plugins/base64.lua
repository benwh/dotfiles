return {
  'christianrondeau/vim-base64',
  init = function()
    -- Don't create the mappings, as this puts items into normal mode mappings.
    vim.g.vim_base64_disable_default_key_mappings = 1
  end,
  config = function()
    -- The function behaviours are unfortunately reversed in the upstream, hence the weird mapping.
    -- I've tried and failed to rewrite these in pure lua, but such is life.
    vim.cmd [[
      vnoremap <silent> <leader>btoa :<c-u>call base64#v_atob()<cr>
      vnoremap <silent> <leader>atob :<c-u>call base64#v_btoa()<cr>
    ]]
  end,
}
