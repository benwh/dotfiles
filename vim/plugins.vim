" TODO: replace with Packer? https://github.com/wbthomason/packer.nvim
call plug#begin('~/.vim/plugged')

" Lua functions, used for many things. todo-comments is one of them.
Plug 'nvim-lua/plenary.nvim'



" Testing


Plug 'github/copilot.vim', { 'branch': 'release' }

" Already included below
" Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main' }
Plug 'hrsh7th/cmp-buffer', { 'branch': 'main' }
Plug 'hrsh7th/cmp-path', { 'branch': 'main' }
Plug 'hrsh7th/cmp-cmdline', { 'branch': 'main' }
Plug 'hrsh7th/nvim-cmp', { 'branch': 'main' }

Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets', { 'branch': 'main' }


Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
" Plug 'honza/vim-snippets'

Plug 'dstein64/vim-startuptime'

Plug 'nvim-tree/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

Plug 'folke/todo-comments.nvim', { 'branch': 'main' }

Plug 'direnv/direnv.vim'


Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }

" Plug 'ray-x/lsp_signature.nvim'

" Grafana agent configuration file
Plug 'grafana/vim-alloy', { 'branch': 'main'}



" Gives a nice TODOToggle command, but doesn't actually highlight like I want
" Plug 'Dimercel/todo-vim'

" Ack/Ag/rg {{{
" Plug 'rking/ag.vim'
Plug 'mileszs/ack.vim'
Plug 'Chun-Yang/vim-action-ag'

" Use ripgrep for searching ⚡️
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
let g:ackprg = 'rg --vimgrep --smart-case'

" Don't auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 0

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!
cnoreabbrev ag Ack!
cnoreabbrev Ag Ack!

" Maps <leader>/ so we're ready to type the search keyword
nnoremap <Leader>/ :Ack!<Space>
" }}}

" Airline{{{
" Plug 'bling/vim-airline'
" let g:airline_powerline_fonts = 1
" let g:airline_theme = 'dark'

Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'nvim-tree/nvim-web-devicons'


"}}}

" ALE
Plug 'dense-analysis/ale'
let g:airline#extensions#ale#enabled = 1
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_completion_delay = 500
let g:ale_echo_delay = 50
let g:ale_list_window_size = 6
let g:ale_lint_delay = 500
let g:ale_sign_column_always = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" let g:ale_sign_error = '⤫'
" let g:ale_sign_warning = '⚠'

" Additional linters:
" TODO: disabled go vet, as it was eating CPU
" let g:ale_linters = { 'go': ['golangci-lint', 'go vet'], 'yaml': 'prettier'}
let g:ale_linters = { 'go': ['golangci-lint'], 'yaml': 'prettier'}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['rubocop'],
\}

" Language-specific options
"
" Golang
" ------
" Disable typecheck due to: https://github.com/golang/lint/issues/43
let g:ale_go_golangci_lint_options = '--enable-all --disable typecheck'
" TODO: Enable whole package, otherwise it doesn't work?!
let g:ale_go_golangci_lint_package = 1

" Align
" TODO: https://github.com/junegunn/vim-easy-align
Plug 'vim-scripts/Align'

" Ansible
"Bundle 'chase/vim-ansible-yaml'

" auto-pairs
" TODO: find a less aggressive plugin?
" Plug 'jiangmiao/auto-pairs'

" Buftabline - replacement for minibufexpl
" Plug 'ap/vim-buftabline'
" let g:buftabline_show = 1 " Only show if there's multiple buffers
" let g:buftabline_numbers = 1 " Show buffer numbers
" let g:buftabline_indicators = 1 " Show buffer state (modified)
" let g:buftabline_plug_max = 0 " Disable ordinal buffer switching mappings
" let g:buftabline_separators = 1 " Show separators

" " CtrlP fuzzy finder{{{
" Plug 'ctrlpvim/ctrlp.vim'
" if has('python')
" 	Plug 'JazzCore/ctrlp-cmatcher'
" 	if filereadable(expand('~/.vim/bundle/ctrlp-cmatcher/autoload/fuzzycomt.so'))
" 		let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
" 	endif
" endif
" 
" " Use files+buffers+MRU mode as default
" let g:ctrlp_cmd = 'CtrlPMixed'
" " Display top-to-bottom
" let g:ctrlp_match_window_reversed = 1
" " Use the working directory that Vim was started in
" let g:ctrlp_working_path_mode = ''
" " More results
" let g:ctrlp_max_height = 25
" " Sane Ignore For ctrlp
" let g:ctrlp_custom_ignore = { 'dir': '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$', 'file': '\.exe$\|\.so$\|\.dat$'  }
" " Match by filename only by default. Seems to give better buffer name matching
" let g:ctrlp_by_filename = 0
" " Use regex search by default
" let g:ctrlp_regexp = 0
" " Show dotfiles/dotdirs - useful for .circleci/ etc. NOTE: ignored if
" " ctrlp_user_command is set
" let g:ctrlp_show_hidden = 1
" 
" if executable('ag')
"     " Use ag over grep
"     set grepprg=ag\ --nogroup\ --nocolor
" 
"     " Use ag in CtrlP for listing files. Lightning fast and
"     " respects .gitignore
"     let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" 
"     " ag is fast enough that CtrlP doesn't need to cache
"     let g:ctrlp_use_caching = 0
" endif

"}}}

" Command-T finder
"Bundle 'git://git.wincent.com/command-t.git'

" Indentation detection
"Bundle 'ciaranm/detectindent'

" Deoplete - completion
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
else
    if has('python3')
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
    endif
endif
let g:deoplete#enable_at_startup = 1
" TODO: replace with LSP / gopls ?
" Plug 'zchee/deoplete-go', { 'do': 'make' }
let g:deoplete#sources#go#pointer = 1
" TODO: test
" Irrelevant because longest is set
" set completeopt+=noinsert
" set completeopt+=noselect
" set completeopt-=preview " disable preview window at the bottom of the screen

" Disable deoplete when in multi cursor mode
function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete = 1
endfunction
function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete = 0
endfunction

" Editorconfig
Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

Plug 'itkq/fluentd-vim'

" Fugitive - Git integration
Plug 'tpope/vim-fugitive'
command Gblame Git blame

" GitHub support
Plug 'tpope/vim-rhubarb'

" fuzzy finding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap <c-p> :FZF<CR>
nnoremap <Leader>f :Buffers<CR>
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 0.5, 'yoffset': 1.0, 'border': 'top' } }

" Golang
Plug 'fatih/vim-go'
" let g:go_auto_sameids                                                     = 1
" TODO: it would be nice to have this, but for it to not interfere with ALE
let g:go_auto_type_info                                                     = 0
let g:go_fmt_command                                                        = "goimports"
let g:go_highlight_build_constraints                                        = 1
let g:go_highlight_extra_types                                              = 1
let g:go_highlight_fields                                                   = 1
let g:go_highlight_functions                                                = 1
let g:go_highlight_methods                                                  = 1
let g:go_highlight_operators                                                = 1
let g:go_highlight_structs                                                  = 1
let g:go_highlight_types                                                    = 1
let g:go_addtags_transform                                                  = "snakecase"
" let g:go_def_mode                                                         = "godef"
let g:go_def_mode                                                           = "gopls"
let g:go_info_mode                                                          = "gopls"

autocmd FileType go nmap <leader>h  <Plug>(go-referrers)

" ginkgo syntax highlighting
Plug 'ivy/vim-ginkgo'

" Go autocompletion
" Plug 'nsf/gocode', {'rtp': 'vim/'}

" Go test generation
Plug 'buoto/gotests-vim'

" hclfmt - Terraform etc.
Plug 'hashivim/vim-terraform'
let g:terraform_align = 1
let g:terraform_fmt_on_save = 1

" vim-javascript (syntax and indentation)
"Bundle 'pangloss/vim-javascript'

" JellyBeans colour scheme
Plug 'nanotech/jellybeans.vim'

" Bundle vim-json
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" jsonnet syntax
" google's repo is the OG, but abandonware
" Plug 'google/vim-jsonnet'
Plug 'partcyborg/vim-jsonnet'

" https://github.com/bfrg/vim-jq
Plug 'bfrg/vim-jq'

" JST/EJS highlighting + indenting
"Bundle 'rummik/vim-jst'

" Local vimrc - project-specific settings{{{
Plug 'embear/vim-localvimrc'

" Use upper-case Y/N/A to remember decision to load or not
let g:localvimrc_persistent = 1
" Potentially dangerous: disable sandboxing
let g:localvimrc_sandbox = 0

"}}}
"

" LSP configs: https://github.com/neovim/nvim-lspconfig
Plug 'neovim/nvim-lspconfig'

" Matchit - with a couple of fixes
Plug 'tmhedberg/matchit'

" Mark
Plug 'inkarkat/vim-mark'
" Mark depends on functions defined in a separate library
Plug 'inkarkat/vim-ingo-library'

" MiniBufExplorer (new fork: https://github.com/fholgado/minibufexpl.vim)
" Plug 'weynhamz/vim-plugin-minibufexpl'

" Multi cursor
" Plug 'terryma/vim-multiple-cursors'

" Mustache
Plug 'mustache/vim-mustache-handlebars'

" TODO: reenable
"Bundle 'Shougo/neosnippet.vim'
"Bundle 'Shougo/neosnippet-snippets'

"  neocomplcache{{{
"Bundle 'Shougo/neocomplcache'
"
"let g:neocomplcache_enable_at_startup = 1
"let g:neocomplcache_enable_camel_case_completion = 1
"let g:neocomplcache_enable_smart_case = 1
"let g:neocomplcache_enable_underbar_completion = 1
"let g:neocomplcache_min_syntax_length = 2
"let g:neocomplcache_enable_auto_delimiter = 1
"let g:neocomplcache_max_list = 15
"let g:neocomplcache_auto_completion_start_length = 2
"let g:neocomplcache_force_overwrite_completefunc = 1
"
"let g:neocomplcache_enable_auto_select = 0
"
"if !exists('g:neocomplcache_omni_patterns')
"    let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'
"
"" Plugin key-mappings.
"" Ctrl-k expands snippet & moves to next position
"" <CR> chooses highlighted value
"imap <C-k> <Plug>(neocomplcache_snippets_expand)
"smap <C-k> <Plug>(neocomplcache_snippets_expand)
"inoremap <expr><C-g> neocomplcache#undo_completion()
"inoremap <expr><C-l> neocomplcache#complete_common_string()
"inoremap <expr><CR> neocomplcache#complete_common_string()
"
"
"" <CR>: close popup
"" <s-CR>: close popup and save indent.
"inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()"\<CR>" : "\<CR>"
"inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"
"" <TAB>: completion.
"inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <expr><s-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y> neocomplcache#close_popup()
"
""}}}

" Neomake - replaced with ALE
" Bundle 'neomake/neomake'
" call neomake#configure#automake('rw', 500)
" let g:neomake_open_list = 2
" let g:neomake_list_height = 6
" " Don't run makers in parallel
" let g:neomake_serialize = 1

" NERD Commenter
Plug 'scrooloose/nerdcommenter'
" add spaces after comments
let NERDSpaceDelims = 1

" NERD Tree
Plug 'scrooloose/nerdtree'
let g:NERDTreeShowHidden = 1
" Disable these mappings so that they don't conflict with C-J/K window nav
let g:NERDTreeMapJumpNextSibling = ''
let g:NERDTreeMapJumpPrevSibling = ''
" Better mappings for opening the tree
nmap <silent> - :NERDTreeToggle<CR>
nmap <silent> _ :NERDTreeFind<CR>


" nginx syntax
"Bundle 'evanmiller/nginx-vim-syntax'

" Occur - powerful buffer searching
" Plug 'vim-scripts/occur.vim'

" PHP stuff{{{
" Bundle 'StanAngeloff/php.vim'
" Bundle 'rayburgemeestre/phpfolding.vim'
" Bundle '2072/PHP-Indenting-for-VIm'
" " Include the '$' as part of identifiers.
" let php_var_selector_is_identifier = 1
" 
" if executable('php')
"     Bundle 'm2mdas/phpcomplete-extended'
"     autocmd FileType php setlocal omnifunc=phpcomplete_extended#CompletePHP
"     let g:phpcomplete_index_composer_command = 'composer'
" endif

" PIV - PHP integration
"Bundle 'spf13/PIV'

"}}}

" Matching colours for paretheses
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

Plug 'kuremu/vim-rename'

Plug 'vim-ruby/vim-ruby'
let g:ruby_indent_block_style = 'do'
" Plug 'thoughtbot/vim-rspec'
" let g:rspec_command = "!bundle exec rspec --require {spec}"
" map <Leader>t :call RunCurrentSpecFile()<CR>

" SearchIndex - show number of matches
Plug 'google/vim-searchindex'
" Do case-insensitive searches with *
let searchindex_star_case = 0

" Signify - VCS diff in gutter
Plug 'mhinz/vim-signify'

" Smart Tabs - fork with fixes
"Bundle 'skroll/Smart-Tabs'

" Switch between single and multi-line blocks with gS and gJ
" https://github.com/AndrewRadev/splitjoin.vim
Plug 'AndrewRadev/splitjoin.vim'

" Sleuth - Automatic buffer options based on file contents
Plug 'tpope/vim-sleuth'

" TODO: Drop
" Snipmate{{{
"Bundle 'garbas/vim-snipmate'
"Bundle 'honza/snipmate-snippets'

"" Required for snipmate
"Bundle 'MarcWeber/vim-addon-mw-utils'
"Bundle 'tomtom/tlib_vim'
"let g:snips_author = 'Ben Wheatley <contact@benwh.com>'

"}}}

"" Splice - 3-way merge resolution
"Bundle 'sjl/splice.vim'

" Synic colour scheme
"Bundle 'synic.vim'

" syntastic{{{
"Bundle 'scrooloose/syntastic'
"let g:syntastic_enable_signs=1
"let g:syntastic_auto_loc_list=1
"let g:syntastic_disabled_filetypes=['html']

"}}}

" Surround
Plug 'tpope/vim-surround'

" Tagbar
Plug 'majutsushi/tagbar'

" " Treesitter
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" " Show context of location: https://github.com/nvim-treesitter/nvim-treesitter-context
" Plug 'nvim-treesitter/nvim-treesitter-context'

" packadd nvim-treesitter

" https://github.com/vim-test/vim-test
Plug 'vim-test/vim-test'
let test#strategy = "neovim"

" Tomorrow colour scheme
Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}

""" unite - for phpcomplete and potentially more
""Bundle 'Shougo/unite.vim'
""
""" vimproc - for phpcomplete and potentially more
""Bundle 'Shougo/vimproc'

" vimux - tmux integration
"Bundle 'benmills/vimux'

" Tmux integration
Plug 'christoomey/vim-tmux-navigator'
" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" Display whitespace
" Plug 'benwh/vim-trailing-whitespace'

" Initialise plugin system
call plug#end()

" Treesitter config must come after Plug initialisation

lua << EOF

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

require'lspconfig'.tsserver.setup {}
-- require'lspconfig'.golangci_lint_ls.setup{}
require'lspconfig'.gopls.setup{
  filetypes = { "go", "gomod", "gowork", "gotmpl", "ginkgo.go" } -- Add ginkgo
}

require'lspconfig'.terraformls.setup{}
require'lspconfig'.tflint.setup{}

-- require'nvim-treesitter.configs'.setup {
--   -- A list of parser names, or "all"
--   ensure_installed = { "c", "vim", "ruby", "go", "lua", "rust", "jsonnet", "hcl" },
-- 
--   -- Install parsers synchronously (only applied to `ensure_installed`)
--   sync_install = false,
-- 
--   -- Automatically install missing parsers when entering buffer
--   -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
--   auto_install = true,
-- 
--   -- List of parsers to ignore installing (for "all")
--   ignore_install = { "javascript" },
-- 
--   highlight = {
--     -- `false` will disable the whole extension
--     enable = true,
-- 
--     -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
--     -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
--     -- the name of the parser)
--     -- list of language that will be disabled
--     disable = { },
--     -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
--     disable = function(lang, buf)
--         local max_filesize = 100 * 1024 -- 100 KB
--         local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--         if ok and stats and stats.size > max_filesize then
--             return true
--         end
--     end,
-- 
--     -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--     -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--     -- Using this option may slow down your editor, and you may see some duplicate highlights.
--     -- Instead of true it can also be a list of languages
--     additional_vim_regex_highlighting = false,
--   },
-- }

EOF

" lua << EOF
"   require "lsp_signature".setup(cfg)
" EOF

lua << EOF
  require("bufferline").setup{
    options = {
      numbers = "buffer_id"
    }
  }
EOF

lua << END
require('lualine').setup()
END

lua << EOF
  require("todo-comments").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  -- keywords recognized as todo comments
  keywords = {
    FIX = {
      icon = " ", -- icon used for the sign, and in search results
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
  },
    highlight = {
        comments_only = true,
    },
    search = {
        -- The default requires a colon. This may return false positives, but I often omit colons so...
        pattern = [[\b(KEYWORDS)]],
    },
}
EOF

lua <<EOF
  vim.api.nvim_set_hl(0, '@string', {fg='#59E343'})
  vim.api.nvim_set_hl(0, '@field', {fg='#f93393'})
  vim.api.nvim_set_hl(0, '@number', {fg='#e933e3'})

  -- Make gitcommit diff work with non-treesitter compatible themes.
  vim.cmd [[highlight def link @text.diff.add DiffAdded]]
  vim.cmd [[highlight def link @text.diff.delete DiffRemoved]]
EOF

" Testing

" snippets
lua <<EOF
  -- require("luasnip.loaders.from_snipmate").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load()

  vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
  vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
  vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

  vim.keymap.set({"i", "s"}, "<C-E>", function()
          if ls.choice_active() then
                  ls.change_choice(1)
          end
  end, {silent = true})
EOF

" nvim-cmp
lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['gopls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['terraformls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['tflint'].setup {
    capabilities = capabilities
  }
EOF
