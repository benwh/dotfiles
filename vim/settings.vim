" vim:foldmethod=marker
scriptencoding utf-8

syntax on
filetype plugin indent on

" Encoding {{{
if has('multi_byte')
	if &encoding !~? '^u\(tf\|cs\)'
		if !strlen(&tenc)
			let &termencoding = &encoding
		endif
		set encoding=utf-8
	endif

	if strlen($TMUX)
		let &termencoding='utf-8'
	endif

	set fileencodings=ucs-bom,utf-8,utf-16le,latin1
	setglobal fileencoding=utf-8 " Use utf-8 for new files
else
	echohl error
	echomsg 'Vim not compiled with +multi_byte! No Unicode support'
	echohl none
endif
"}}}

" Interface settings{{{

" General
set shortmess=filmrxtToOI " Skip splash screen
set number                " Precede each line with its line number
set numberwidth=3         " Number of culumns for line numbers
set scrolloff=8           " Keep a margin of 4 lines at the top and bottom
set showcmd               " Show (partial) command in status line.
set ruler                 " Line and column number of the cursor position
set wildmode=longest,list,full " List all completions, match until longest common string
set wildmenu              " Enhanced command completion
set novisualbell          " Use visual bell instead of beeping
set laststatus=2          " Show the status line all the time, not just with split windows
set nostartofline		  " Don't jump to start of line when switching buffers

" Search settings
set incsearch  " Incremental search
set hlsearch   " Highlight search match
set ignorecase " Do case insensitive matching
set smartcase  " If input has capitals in, then do a case-sensitive search
set wrapscan   " Searches wrap around at end of file
set maxmempattern=2000000 " Attempt to prevent running out of memory when jumping to def in big Go files
" Use 'very magic' without having to type \v every damn time.
nnoremap / /\v
cnoremap %s/ %s/\v

" File display settings
set textwidth=90        " Bump the normal wrap length up a bit
set nowrap              " Do not wrap words in normal mode
set showmatch           " Show matching brackets.
set listchars=tab:▷⋅,trail:·,extends:>,precedes:<,eol:$,nbsp:·

" Terminal settings
if &term != "linux"
	set ttyfast           " Make things faster - has no effect in neovim.
	set title
	set titlelen=30       " Don't set a ridiculously huge terminal title
endif

" Mouse settings
if has("mouse")
	set mouse=nv
endif
set mousemodel=popup_setpos     " Reposition the cursor on right-click
set mousehide                           " Hide mouse pointer on insert mode."


" Handle TERM quirks in vim
if $TERM =~ '^screen-256color'
	set t_Co=256
	nmap <Esc>OH <Home>
	imap <Esc>OH <Home>
	nmap <Esc>OF <End>
	imap <Esc>OF <End>
endif

" Colour and style settings{{{
set background=dark
" Unset per-mode cursor styling
set guicursor=

if &term == "linux"
	set t_Co=16
	colorscheme slate
else
	set t_Co=256
	if has('nvim')
		set termguicolors
	endif
	colorscheme jellybeans
endif

" Make completion menus readable
highlight Pmenu ctermfg=0 ctermbg=3
highlight PmenuSel ctermfg=0 ctermbg=7

" Highlight spelling errors
hi SpellErrors guibg=red guifg=black ctermbg=red ctermfg=black

" Flag problematic whitespace (trailing and spaces before tabs)
" Note you get the same by doing let c_space_errors=1 but
" this rule really applies to everything.
highlight RedundantSpaces term=standout ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/ " \ze sets end of match so only spaces highlighted

"}}}

"}}}

" File, session, misc settings {{{

" Never tab-complete these file extensions
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif
" Give lower priority to these file extensions (from Arch)
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

set shell=/bin/bash                  " Use bash for shell commands
set autowrite                        " Automatically save before commands like :next and :make
set hidden                           " Enable multiple modified buffers
set autoread                         " Automatically read file that has been changed on disk and doesn't have changes in vim
set backspace=indent,eol,start
set completeopt=menu,preview,longest " Show a menu if more than one match. Show completion source. Don't complete whole word until chosen.
let bash_is_sh=1                     " Syntax shell files as bash scripts
set nomodeline                       " Do not execute modelines, as these can be insecure
set sessionoptions=blank,buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos
set nofixendofline                   " Don't add newlines at the end of files when I don't ask for them

" Viminfo
" TODO: replace with Shada stuff for nvim
set history=1000  " Keep 1000 lines of command line history
set viminfo=
set viminfo+='100 " Remember 100 previously edited files' marks
set viminfo+=!    " Remember some global variables
set viminfo+=h    " Don't restore the hlsearch highlighting

" Upon opening a file, jump to the last position
if has('nvim')
  au BufReadPost *
     \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
     \ |   exe "normal! g`\""
     \ | endif
endif

" Directory settings
set backupdir=~/.backup,.       " list of directories for the backup file
set directory=~/.backup,~/tmp,. " list of directory names for the swap file
set nobackup                    " do not write backup files
set noswapfile                  " do not write .swp files

" Undo settings
if has('persistent_undo')
	if strlen(finddir($HOME . "/.vim/tmp/undo")) == 0
		silent call mkdir($HOME . "/.vim/tmp/undo", "p", 0700)
	endif
	set undodir=~/.vim/tmp/undo
	set undofile
endif

" Special handling for files >10MiB
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile
	autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function! LargeFile()
	" no syntax highlighting etc
	set eventignore+=FileType
	" save memory when other file is viewed
	setlocal bufhidden=unload
	" is read-only (write with :w new_filename)
	setlocal buftype=nowrite
	" no undo possible
	setlocal undolevels=-1
	" display message
	autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction

" Editing, indentation settings{{{

" Folding
set foldcolumn=0      " columns for folding
set foldmethod=syntax
set foldlevel=6
" set nofoldenable    " Let's try folding for a while

" Tabbing and Indentation - to be used with SmartTabs plugin
set expandtab " Spaces seem to have won :(
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=2
set tabstop=2
set cindent  " Also see autoindent
set cino+=(0 " Line up multi-line parameter lists
set cino+=u0 " And the same for one level deeper
set cino+=U0 " Align statements properly if they proceed a line containing a lone bracket
set cino+=l1 " Align case statements properly

"}}}

" Autocmds{{{
function! DeleteIfWhitespaceOnly()
	if getline('.') =~? '^\s\+$'
		normal! 0
		normal! "_d$
	endif
endfunction

augroup DeleteLineWithSpaces
	autocmd InsertLeave * call DeleteIfWhitespaceOnly()
augroup END
"}}}

" Filetype-specific settings {{{

" (ba)sh:{{{
" Syntax highlight shell scripts as per POSIX,
" not the original Bourne shell which very few use
let g:is_posix = 1
"}}}

" Diff:{{{
" Only use diff colours in diff mode
if &diff
	syntax off
endif
"}}}

" Git:{{{
augroup filetype_gitcommit
	autocmd!
	autocmd FileType gitcommit setlocal foldlevel=2 spell
	autocmd FileType gitcommit set nocindent
augroup END

" Use gitconfig syntax for my file named 'gitconfig'
autocmd BufNewFile,BufRead gitconfig setfiletype gitconfig
"}}}

" Golang:{{{
augroup filetype_go
	autocmd!
	autocmd FileType go setlocal softtabstop=2 shiftwidth=2 tabstop=2 noexpandtab
	" Preview is annoying and useless?
	autocmd FileType go set completeopt-=preview
	autocmd FileType go nmap <F3> :GoTest -short<cr><cr>
	autocmd FileType go nmap <F4> :GoCoverageToggle<cr><cr>
augroup END
"}}}

" HTML:{{{
augroup filetype_html
	autocmd!
	" http://morearty.com/blog/2013/01/22/fixing-vims-indenting-of-html-files.html
	autocmd FileType html setlocal indentkeys-=*<Return>
augroup END
"}}}

" JSON:{{{
augroup filetype_json
	autocmd!
	autocmd FileType json set foldlevel=1
augroup END
"}}}

" Markdown:{{{
augroup filetype_markdown
	autocmd!
	autocmd FileType markdown setlocal spell textwidth=80 nocindent
augroup END
"}}}

" PHP:{{{
" PHP highlighting extras
let php_sql_query = 1
let php_htmlInStrings = 1
let php_baselib = 1

" Don't show variables in tag list
  let tlist_php_settings='php;f:function'
"}}}

" Ruby:{{{
" let g:ale_fixers = {'ruby': ['prettier']}
"}}}

" Quickfix:{{{
augroup qf
    autocmd!
    " Prevent quickfix from appearing in buffer list
    autocmd FileType qf set nobuflisted
augroup END
"}}}

" Vim:{{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
"}}}

" YAML:{{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
	" let b:ale_fixers = {'yaml': ['prettier']}
augroup END
"}}}

"}}}

"}}}

" Key bindings {{{

" Buffer switching/manipulation
let mapleader = '\'
map <Leader>h :bprev<Return>
map <Leader>l :bnext<Return>
map <Leader>d :bd<Return>
" map <Leader>f :ls<CR>:buffer<Space>

let mapleader = ","

" Remap jk to escape
inoremap jk <Esc>

" ,l to toggle visible whitespace
nmap <silent> <Leader>l :set list!<CR>

" Indent as many times as you like in visual mode without returning to normal
vnoremap < <gv
vnoremap > >gv

" Don't use Ex mode, use Q for formatting
map Q gq

"make Y consistent with C and D
nnoremap Y y$

" Map F1 to ALEFix
map <F1> :ALEFix<CR>
" Map ,f to ALEFix too, in case you're working on a system which has decided
" to omit usable function keys
map <Leader>f :ALEFix<CR>

" Ctrl-N to clear search results
nmap <silent> <C-N> :silent noh<CR>

" Ctrl-E to switch between 2 last buffers
nmap <C-E> :b#<CR>

" ,e to fast finding files. just type beginning of a name and hit TAB
nmap <Leader>e :e **/

" Use sudo to write to protected files, but reload to get rid of the warning
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" Destroy EOL whitespace with <leader>w
" http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html
nmap <Leader>w :%s/\v\s\+$//<CR>:let @/=''<CR>

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" ,n to get the next location (compilation errors, grep etc)
" nmap <Leader>n :cn<CR>

" Re-sync syntax highlighting from start of file if its broken (usually PHP)
" noremap <F10> <Esc>:syntax sync fromstart<CR>

nmap <C-L> :CtrlPBuffer<CR>

" Alternatively - map {keys} :set invpaste<CR>
set pastetoggle=<F10>

" Make completion feel right
inoremap <silent><expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr><CR>  pumvisible() ? "\<C-Y>" : "\<CR>"
" inoremap <silent><expr><ESC>  pumvisible() ? "\<C-E><ESC>" : "\<ESC>"

" Base64 encode/decode selection (works on a *range*, not just a whole line
" selection)
vnoremap <silent> <Leader>atob c<c-r>=system('base64', @")<CR><ESC>
vnoremap <silent> <Leader>btoa c<c-r>=system('base64 --decode', @")<CR><ESC>

" Navigate quickfix list with ease
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
" nnoremap <silent> c :copen<CR>

" Close everything other than the code
nnoremap <C-w><C-d> :cclose <CR> :NERDTreeClose <CR>

" Window movement{{{

" Do the splits
map <C-W>- <C-W>s<C-W><Down>
map <C-W>\| <C-W>v<C-W><Right>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Go wide
nnoremap <C-W>w <C-W><Bar>
" Go tall
nnoremap <C-W>t <C-W>_

"}}}

" Macro for base64 decode a JSON map value
" f:f"xf"x<ESC>F:llvt,,btoa<ESC>j

"}}}

" Functions {{{
function ReplaceCurlyQuotes()
  %s/[’]/'/ge
  %s/[“”]/"/ge
endfunction
"}}}
