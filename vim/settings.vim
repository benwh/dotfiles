syntax on
filetype plugin indent on

set nofsync " Stop fsyncs to disable freezing
set noeol   " Prevent vim from adding EOL characters
set binary

" presentation settings
set shortmess+=I        " Skip splash screen
set number              " Precede each line with its line number
set numberwidth=3       " Number of culumns for line numbers
set textwidth=0         " Do not wrap words (insert)
set scrolloff=4         " Keep a margin of 4 lines at the top and bottom
set nowrap              " Do not wrap words (view)
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set ruler               " Line and column number of the cursor position
set wildmenu            " Enhanced command completion
set visualbell          " Use visual bell instead of beeping
set laststatus=2        " Always show the status line
set listchars=tab:▷⋅,trail:·,extends:>,precedes:<,eol:$,nbsp:·
" set list

" Terminal settings
if &term =~? '^\(xterm\|screen\|putty\|konsole\|gnome\)'
  let &t_RV="\<Esc>[>c" " Let Vim check for xterm-compatibility
  set ttyfast " Because no one should have to suffer
  set ttymouse=xterm2 " Assume xterm mouse support
  set title
endif

" Colour settings
set background=dark
if &term == "linux"
    set t_Co=16
    colorscheme slate
else
    set t_Co=256
"    colorscheme synic
endif

" Only use diff colours in diff mode
if &diff
    syntax off
endif

" Make completion menus readable
highlight Pmenu ctermfg=0 ctermbg=3
highlight PmenuSel ctermfg=0 ctermbg=7
" Highlight spelling errors
hi SpellErrors guibg=red guifg=black ctermbg=red ctermfg=black
" Flag problematic whitespace (trailing and spaces before tabs)
" Note you get the same by doing let c_space_errors=1 but
" this rule really applys to everything.
highlight RedundantSpaces term=standout ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/ "\ze sets end of match so only spaces highlighted

" Status line
if exists("g:loaded_syntastic_plugin")
	set statusline=%02n:%<%1*%f%*\ %h%m%r%#warningmsg#%{SyntasticStatuslineFlag()}%*%=line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)
else
	set statusline=%02n:%<%1*%f%*\ %h%m%r%#warningmsg#%*%=line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)
endif
"set statusline=%02n:%<%1*%f%*\ %*%=%-14.(%l,%c%V%)\ %P
" Highlight status line file name
hi User1 term=bold,reverse cterm=bold ctermfg=4 ctermbg=2 gui=bold guifg=Blue guibg=#44aa00


set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif
set shell=/bin/bash              " Use bash for shell commands
set autowriteall                 " Automatically save before commands like :next and :make
set hidden                       " Enable multiple modified buffers
set autoread                     " Automatically read file that has been changed on disk and doesn't have changes in vim
set backspace=indent,eol,start
set guioptions-=T                " Disable toolbar                                                                       "
set completeopt=menuone,preview
let bash_is_sh=1                 " Syntax shell files as bash scripts
set cinoptions=:0,(s,u0,U1,g0,t0 " Some indentation options ':h cinoptions' for details
set modelines=5                  " Number of lines to check for vim: directives at the start/end of file
set sessionoptions=blank,buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos

" Viminfo
set history=1000  " Keep 1000 lines of command line history
set viminfo=
set viminfo+='100 " Remember 100 previously edited files' marks
set viminfo+=!    " Remember some global variables
set viminfo+=h    " Don't restore the hlsearch highlighting

" Tabbing
set tabstop=4    " Number of spaces in a tab
set shiftwidth=4 " Number of spaces for indent
set expandtab    " Expand tabs into spaces

" Mouse settings
if has("mouse")
    set mouse=v
endif
set mousemodel=popup_setpos     " Reposition the cursor on right-click
set mousehide                           " Hide mouse pointer on insert mode."

" Encoding
if has('multi_byte') && &enc !~? '^u\(tf\|cs\)'
  if !strlen(&tenc) && exists(':let') == 2
    let &tenc = &enc
  endif
  set encoding=utf-8
endif

" Syntax highlight shell scripts as per POSIX,
" not the original Bourne shell which very few use
let g:is_posix = 1

" Search settings
set incsearch  " Incremental search
set hlsearch   " Highlight search match
set ignorecase " Do case insensitive matching
set smartcase  " Do not ignore if search pattern has CAPS
set wrapscan   " Searches wrap around at end of file

" Omni completion settings
set ofu=syntaxcomplete#Complete
let g:rubycomplete_buffer_loading = 0
let g:rubycomplete_classes_in_global = 1

" Directory settings
set backupdir=~/.backup,.       " list of directories for the backup file
set directory=~/.backup,~/tmp,. " list of directory names for the swap file
set nobackup                    " do not write backup files
set noswapfile                  " do not write .swp files

" Folding
set foldcolumn=0      " columns for folding
set foldmethod=indent
set foldlevel=9
set nofoldenable      " dont fold by default "

" Extended '%' mapping for if/then/else/end etc
runtime macros/matchit.vim
