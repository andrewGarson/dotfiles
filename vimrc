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
set foldmethod=indent
set foldlevelstart=99
" Show line numbers.
set number
set numberwidth=4

" Scroll five lines ahead of cursor.
set scrolloff=5

" Set up autoindentation.
set smartindent
filetype indent on

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

set hlsearch " Highlight search terms.
set incsearch " Search as you type.
set ruler " Display command and location status.
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

syntax enable
syn sync fromstart " Force vim to sync syntax highlighting from the beginning of the file.

colorscheme desert

set gfn=Consolas:h11:cANSI " set font to consolas size 11

au! BufWritePost .vimrc source % " Automatically reload the .vimrc when changes are made to it

au BufNewFile,BufRead Gemfile set filetype=ruby

highlight Folded ctermfg=red

" Add aliases for all the commands I keep holding shift down too long for
command! W w
command! Wall wall

call pathogen#infect()

" Begin Local Session
" Make vim look for a .session.vim file in the current directory any time 
" you load without args
fu! SaveSess()                                                                                                                                                                                                                                                                                                              
  execute 'mksession! ' . getcwd() . '/.session.vim'                                                                                                                                                                                                                                                                      
endfunction                                                                                                                                                                                                                                                                                                                 

fu! RestoreSess()                                                                                                                                                                                                                                                                                                           
  if filereadable(getcwd() . '/.session.vim')                                                                                                                                                                                                                                                                                 
    execute 'so ' . getcwd() . '/.session.vim'                                                                                                                                                                                                                                                                              
    if bufexists(1)                                                                                                                                                                                                                                                                                                         
      for l in range(1, bufnr('$'))                                                                                                                                                                                                                                                                                       
        if bufwinnr(l) == -1                                                                                                                                                                                                                                                                                            
          exec 'sbuffer ' . l                                                                                                                                                                                                                                                                                         
        endif                                                                                                                                                                                                                                                                                                           
      endfor                                                                                                                                                                                                                                                                                                              
    endif                                                                                                                                                                                                                                                                                                                   
  endif                                                                                                                                                                                                                                                                                                                       
endfunction                                                                                                                                                                                                                                                                                                                 

autocmd VimLeave * call SaveSess()                                                                                                                                                                                                                                                                                          
autocmd BufNew * call SaveSess()
autocmd VimEnter * if argc() == 0 | call RestoreSess()
" End Local Session 

set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

let g:NERDTreeShowHidden=1

" setup to use vim-flavored-markdown plugin which is an extension
" of tpope's vim-markdown (both needed) to get syntax highlighting for
" github flavored markdown instead of standard
augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" setup for vim-markdown-preview plugin that lets you hit Ctrl-P
" to launch current markdown file in a browser - because we want
" github flavor we need to `pip install grip` to get the correct
" engine and then tell the plugin to use grip
"
" When setting up grip you need to generate a github personal access token
" with an empty scope and then run
" grip --pass <TOKEN>
let vim_markdown_preview_github=1


