" Don't imitate vi.
set nocompatible

" Make tab-completion work more like bash.
set wildmenu
set wildmode=list:full

" Ignore certain file extensions when tab-completing.
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.exe

" Set filetype stuff to on.
filetype on
filetype plugin on
filetype indent on

" Example filetype-specific setting:
" if has('autocmd')
"     autocmd filetype python set expandtab
" endif

" Allow folding.
set foldenable
set foldmethod=syntax
set foldlevelstart=99
" Show line numbers.
set number
set numberwidth=4

" Scroll five lines ahead of cursor.
set scrolloff=5

" Set up autoindentation.
set smartindent
filetype indent on

" Set tabs to width 4.
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

"Highlight bad spacing.
highlight BadSpacing term=standout ctermbg=cyan
augroup Spacing
    autocmd!
    " Highlight tabulators and trailing spaces
    autocmd BufNewFile,BufReadPre * match BadSpacing /\(\t\|  *$\)/
    " Only highlight trailing space in tab-filled formats
    autocmd FileType help,make match BadSpacing /  *$/
augroup END

" Highlight search terms.
set hlsearch

" Search as you type.
set incsearch

" Display command and location status.
set ruler
set showcmd

" Multiple windows are equally sized and open in reading order.
set equalalways
set splitbelow splitright

" Line wrapping off
set nowrap

" Enlarge history and undo/redo buffers.
set history=1000
set undolevels=1000

" Reset colors to a clean state.
if !has('gui_running')
    set t_Co=8 t_md=
endif

" Enable syntax highlighting.
syntax enable

" Force vim to sync syntax highlighting from the beginning of the file.
syn sync fromstart

" Set the color scheme to desert.
colorscheme desert

" set font to consolas size 11
set gfn=Consolas:h11:cANSI

" Automatically reload the .vimrc when changes are made to it
au! BufWritePost .vimrc source %

" Treat Gemfile as ruby
au BufNewFile,BufRead Gemfile set filetype=ruby

" Make code highlights red
highlight Folded ctermfg=red

" Add aliases for all the commands I keep holding shift down too long for
command W w
command Wall wall

" Load pathogen
call pathogen#infect()
