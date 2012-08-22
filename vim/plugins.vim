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

" ir_black colour scheme
Bundle 'wgibbs/vim-irblack'

" JellyBeans colour scheme
Bundle 'nanotech/jellybeans.vim'

" Matchit - with a couple of fixes
Bundle 'tmhedberg/matchit'

" MiniBufExplorer (new fork: https://github.com/fholgado/minibufexpl.vim)
Bundle 'fholgado/minibufexpl.vim'

" NERD Commenter
Bundle 'scrooloose/nerdcommenter'

" Powerline
Bundle 'Lokaltog/vim-powerline'

" Smart Tabs - fork with fixes
Bundle 'skroll/Smart-Tabs'

" Synic colour scheme
Bundle 'synic.vim'

" syntastic
Bundle 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_disabled_filetypes=['html']

" Tag list (Best fork as of 20120822)
Bundle 'klen/vim-taglist-plus'

" And we're done
filetype plugin indent on
