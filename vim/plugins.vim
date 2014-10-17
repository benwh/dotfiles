" Load plugins with Vundle - https://github.com/gmarik/vundle
"
" Remember to:
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" vim +BundleInstall +qall

" Required for Vundle
filetype off

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Plugins:

"" Ack
"Bundle 'mileszs/ack.vim'

"Ag
Bundle 'epmatsw/ag.vim'

" Align
Bundle 'Align'

" auto-pairs
Bundle 'jiangmiao/auto-pairs'

" CtrlP fuzzy finder{{{
Bundle 'kien/ctrlp.vim'

" Use files+buffers+MRU mode as default
let g:ctrlp_cmd = 'CtrlPMixed'
" Display top-to-bottom
let g:ctrlp_match_window_reversed = 1
" Use the working directory that Vim was started in
let g:ctrlp_working_path_mode = ''
" More results
let g:ctrlp_max_height = 25
" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = { 'dir': '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$', 'file': '\.exe$\|\.so$\|\.dat$'  }
" Match by filename only by default. Seems to give better buffer name matching
let g:ctrlp_by_filename = 1

if executable('ag')
        " Use ag over grep
        set grepprg=ag\ --nogroup\ --nocolor

        " Use ag in CtrlP for listing files. Lightning fast and
        " respects .gitignore
        let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

        " ag is fast enough that CtrlP doesn't need to cache
        let g:ctrlp_use_caching = 0
endif

"}}}

" Command-T finder
"Bundle 'git://git.wincent.com/command-t.git'

" Fugitive - Git integration
Bundle 'tpope/vim-fugitive'

" Golang - distribution plugins plus extras
Bundle 'Blackrush/vim-gocode'

" Go autocompletion
Bundle 'nsf/gocode', {'rtp': 'vim/'}

" Git gutter
Bundle 'airblade/vim-gitgutter'

" ir_black colour scheme
Bundle 'wgibbs/vim-irblack'

" vim-javascript (syntax and indentation)
Bundle 'pangloss/vim-javascript'

" JellyBeans colour scheme
Bundle 'nanotech/jellybeans.vim'

" JST/EJS highlighting + indenting
"Bundle 'rummik/vim-jst'

" Local vimrc - project-specific settings{{{
Bundle 'embear/vim-localvimrc'

" Use upper-case Y/N/A to remember decision to load or not
let g:localvimrc_persistent = 1
" Potentially dangerous: disable sandboxing
let g:localvimrc_sandbox = 0

"}}}

" Matchit - with a couple of fixes
Bundle 'tmhedberg/matchit'

" MiniBufExplorer (new fork: https://github.com/fholgado/minibufexpl.vim)
Bundle 'fholgado/minibufexpl.vim'

" neocomplcache{{{
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet.vim'

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_enable_auto_delimiter = 1
let g:neocomplcache_max_list = 15
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_force_overwrite_completefunc = 1

let g:neocomplcache_enable_auto_select = 0

if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'

" Plugin key-mappings.
" Ctrl-k expands snippet & moves to next position
" <CR> chooses highlighted value
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><CR> neocomplcache#complete_common_string()


" <CR>: close popup
" <s-CR>: close popup and save indent.
inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()"\<CR>" : "\<CR>"
inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()

"}}}

" NERD Commenter
Bundle 'scrooloose/nerdcommenter'

" NERD Tree
Bundle 'scrooloose/nerdtree'

" nginx syntax
Bundle 'evanmiller/nginx-vim-syntax'

" Occur - powerful buffer searching
Bundle 'occur.vim'

" PHP stuff{{{
Plugin 'StanAngeloff/php.vim'
Plugin 'rayburgemeestre/phpfolding.vim'
Plugin '2072/PHP-Indenting-for-VIm'
" Include the '$' as part of identifiers.
let php_var_selector_is_identifier = 1

Bundle 'm2mdas/phpcomplete-extended'
autocmd FileType php setlocal omnifunc=phpcomplete_extended#CompletePHP
let g:phpcomplete_index_composer_command = 'composer'

" PIV - PHP integration
"Bundle 'spf13/PIV'

"}}}

" Powerline{{{
if has('python') && executable('powerline')
    python from powerline.vim import setup as powerline_setup
    python powerline_setup()
    python del powerline_setup
endif

let g:Powerline_symbols = 'fancy'

"}}}

" vimproc - for phpcomplete and potentially more
Bundle 'Shougo/vimproc'

" Smart Tabs - fork with fixes
"Bundle 'skroll/Smart-Tabs'

" Sleuth - Automatic buffer options based on file contents
Bundle 'tpope/vim-sleuth'

" Snipmate{{{
"Bundle 'garbas/vim-snipmate'
"Bundle 'honza/snipmate-snippets'

"" Required for snipmate
"Bundle 'MarcWeber/vim-addon-mw-utils'
"Bundle 'tomtom/tlib_vim'
"let g:snips_author = 'Ben Wheatley <contact@benwh.com>'

"}}}

" Synic colour scheme
Bundle 'synic.vim'

" syntastic{{{
Bundle 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_disabled_filetypes=['html']

"}}}

" Surround
Bundle 'tpope/vim-surround'

" Tagbar
Bundle 'majutsushi/tagbar'

" Tomorrow colour scheme
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}

" unite - for phpcomplete and potentially more
Bundle 'Shougo/unite.vim'

" Display whitespace
Bundle 'benwh/vim-trailing-whitespace'

" And we're done
filetype plugin indent on
