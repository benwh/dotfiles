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

" Align
Bundle 'Align'

" MiniBufExplorer (new fork: https://github.com/fholgado/minibufexpl.vim)
Bundle 'fholgado/minibufexpl.vim'

" Smart Tabs - fork with fixes
Bundle 'skroll/Smart-Tabs'

" syntastic
Bundle 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_disabled_filetypes=['html']


" And we're done
filetype plugin indent on
