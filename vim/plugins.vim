" Load plugins with Vundle - https://github.com/gmarik/vundle
"
" Remember to:
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" vim +BundleInstall +qall


set nocompatible
filetype off


" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Plugins:

" Align
Bundle 'Align'

" Smart Tabs
Bundle 'Smart-Tabs'

" syntastic
Bundle 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_disabled_filetypes=['html']


" And we're done
filetype plugin indent on
