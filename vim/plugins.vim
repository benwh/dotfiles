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

" Ack
Bundle 'mileszs/ack.vim'

" Align
Bundle 'Align'

" CtrlP fuzzy finder
Bundle 'kien/ctrlp.vim'
" Use files+buffers+MRU mode as default
let g:ctrlp_cmd = 'CtrlPMixed'
" Display top-to-bottom
let g:ctrlp_match_window_reversed = 1
" Use the working directory that Vim was started in
let g:ctrlp_working_path_mode = ''
" More results
let g:ctrlp_max_height = 25

" ir_black colour scheme
Bundle 'wgibbs/vim-irblack'

" vim-javascript (syntax and indentation)
Bundle 'pangloss/vim-javascript'

" JellyBeans colour scheme
Bundle 'nanotech/jellybeans.vim'

" JST/EJS highlighting + indenting
"Bundle 'rummik/vim-jst'

" Local vimrc - project-specific settings
Bundle 'embear/vim-localvimrc'
" Use upper-case Y/N/A to remember decision to load or not
let g:localvimrc_persistent = 1

" Matchit - with a couple of fixes
Bundle 'tmhedberg/matchit'

" MiniBufExplorer (new fork: https://github.com/fholgado/minibufexpl.vim)
Bundle 'fholgado/minibufexpl.vim'

" NERD Commenter
Bundle 'scrooloose/nerdcommenter'

" Powerline
Bundle 'Lokaltog/vim-powerline'
let g:Powerline_symbols = 'fancy'

" Smart Tabs - fork with fixes
Bundle 'skroll/Smart-Tabs'

" Snipmate
Bundle 'garbas/vim-snipmate'
Bundle 'honza/snipmate-snippets'
" Required for snipmate
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
let g:snips_author = 'Ben Wheatley <contact@benwh.com>'

" Synic colour scheme
Bundle 'synic.vim'

" syntastic
Bundle 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_disabled_filetypes=['html']

" Surround
Bundle 'tpope/vim-surround'

" Tagbar
Bundle 'majutsushi/tagbar'

" Tag list (Best fork as of 20120822)
Bundle 'klen/vim-taglist-plus'

" Tomorrow colour scheme
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}

" Display whitespace
Bundle 'benwh/vim-trailing-whitespace'

" And we're done
filetype plugin indent on
