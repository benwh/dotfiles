call plug#begin('~/.vim/plugged')

"" Ack
"Bundle 'mileszs/ack.vim'

" Ag
" TODO: This plugin is deprecated, switch back to ack.vim ?
Plug 'rking/ag.vim'
Plug 'Chun-Yang/vim-action-ag'
" Always use Ag!, which prevents the first result being opened in a buffer
" immediately after searching.
cabbrev Ag Ag!
let g:ag_prg="ag --hidden --ignore .git --vimgrep"


" Airline{{{
Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'dark'
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
let g:ale_linters = { 'go': ['golangci-lint', 'go vet'] }

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
Plug 'ap/vim-buftabline'
let g:buftabline_show = 1 " Only show if there's multiple buffers
let g:buftabline_numbers = 1 " Show buffer numbers
let g:buftabline_indicators = 1 " Show buffer state (modified)
let g:buftabline_plug_max = 0 " Disable ordinal buffer switching mappings
let g:buftabline_separators = 1 " Show separators

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
Plug 'zchee/deoplete-go', { 'do': 'make' }
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
" GitHub support
Plug 'tpope/vim-rhubarb'

" fuzzy finding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap <c-p> :FZF<CR>
nnoremap <Leader>f :Buffers<CR>
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" Golang
Plug 'fatih/vim-go'
" let g:go_auto_sameids              = 1
" TODO: it would be nice to have this, but for it to not interfere with ALE
let g:go_auto_type_info              = 0
let g:go_fmt_command                 = "goimports"
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types       = 1
let g:go_highlight_fields            = 1
let g:go_highlight_functions         = 1
let g:go_highlight_methods           = 1
let g:go_highlight_operators         = 1
let g:go_highlight_structs           = 1
let g:go_highlight_types             = 1
let g:go_addtags_transform           = "snakecase"
let g:go_def_mode                    = "godef"

" Go autocompletion
" Plug 'nsf/gocode', {'rtp': 'vim/'}

" Go test generation
Plug 'buoto/gotests-vim'

" hclfmt - Terraform etc.
Plug 'hashivim/vim-terraform'
let g:terraform_align = 1
let g:terraform_fmt_on_save = 1

" ir_black colour scheme
Plug 'wgibbs/vim-irblack'

" vim-javascript (syntax and indentation)
"Bundle 'pangloss/vim-javascript'

" JellyBeans colour scheme
Plug 'nanotech/jellybeans.vim'

" Bundle vim-json
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" jsonnet syntax
Plug 'google/vim-jsonnet'

" JST/EJS highlighting + indenting
"Bundle 'rummik/vim-jst'

" Local vimrc - project-specific settings{{{
Plug 'embear/vim-localvimrc'

" Use upper-case Y/N/A to remember decision to load or not
let g:localvimrc_persistent = 1
" Potentially dangerous: disable sandboxing
let g:localvimrc_sandbox = 0

"}}}

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
