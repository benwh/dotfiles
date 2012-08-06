syntax on
filetype plugin indent on

set nofsync " Stop fsyncs to disable freezing

" Interface settings
set shortmess=filmrxtToOI " Skip splash screen
set number              " Precede each line with its line number
set numberwidth=3       " Number of culumns for line numbers
set scrolloff=4         " Keep a margin of 4 lines at the top and bottom
set showcmd             " Show (partial) command in status line.
set ruler               " Line and column number of the cursor position
set wildmenu            " Enhanced command completion
set visualbell          " Use visual bell instead of beeping
set laststatus=2        " Show the status line all the time, not just with split windows

" File display settings
set textwidth=0         " Do not wrap words (insert)
set nowrap              " Do not wrap words (view)
set showmatch           " Show matching brackets.
set listchars=tab:▷⋅,trail:·,extends:>,precedes:<,eol:$,nbsp:·

" Terminal settings
if &term =~? '^\(xterm\|screen\|putty\|konsole\|gnome\)'
    let &t_RV="\<Esc>[>c" " Let Vim check for xterm-compatibility
    set ttyfast " Because no one should have to suffer
    set ttymouse=xterm2 " Assume xterm mouse support
    set title
    set titlelen=30         " Don't set a ridiculously huge terminal title
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
"hi User1 term=bold,reverse cterm=bold ctermfg=4 ctermbg=2 gui=bold guifg=Blue guibg=#44aa00


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

" Tabbing and Indentation - to be used with SmartTabs plugin
set noexpandtab " Use tabs for tabbing, not spaces
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4
set cindent " Also see autoindent
set cinoptions=(0,u0,U0

" Mouse settings
if has("mouse")
    set mouse=v
endif
set mousemodel=popup_setpos     " Reposition the cursor on right-click
set mousehide                           " Hide mouse pointer on insert mode."

" Encoding (Fixed and working well as of 20120803)
if has('multi_byte')
  if &enc !~? '^u\(tf\|cs\)'
      if !strlen(&tenc)
        let &termencoding = &encoding
      endif
      set encoding=utf-8
  endif
  set fileencodings=ucs-bom,utf-8,utf-16le,latin1
  setglobal fileencoding=utf-8 " Use utf-8 for new files
else
    echohl error
    echomsg 'Vim not compiled with +multi_byte! No Unicode support'
    echohl none
endif

" Syntax highlight shell scripts as per POSIX,
" not the original Bourne shell which very few use
let g:is_posix = 1

" Search settings
set incsearch  " Incremental search
set hlsearch   " Highlight search match
set ignorecase " Do case insensitive matching
set smartcase  " If input has capitals in, then do a case-sensitive search
set wrapscan   " Searches wrap around at end of file

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
" runtime macros/matchit.vim
