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
" set foldmethod=indent if you see performance issues - you won't be able to fold but vim will work
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

" NOTE: If you need to store the output of an internal command in a variable
" you can do the following
"   redir => variable_name
"   silent! some_command
"   redir END

fu! GetSessionFilePath()
  let l:sessions_dir = getcwd() . '/.vimsessions'
  if !isdirectory(l:sessions_dir)
    call mkdir(l:sessions_dir)
  endif

  if(isdirectory(getcwd() . '/.git')) 
    " add a . on the end so that we can append session.vim to the name later
    " and end up with branch.session.vim for git folders and just plain old
    " session.vim for non git by setting l:current_branch to ''
    let l:current_branch = systemlist("git rev-parse --abbrev-ref HEAD")[0] . '.'
  else
    let l:current_branch = ''
  endif

  return l:sessions_dir . '/' . l:current_branch . 'session.vim'

endfunction

" Begin Local Session
" Make vim look for a session file in the current directory any time 
" you load without args
fu! SaveSess()                                                                                                                                                                                                                                                                                                              
  " Don't save the session if we opened the git commit message file -- we
  " probably don't want to lose our workspace while doing a commit
  if argv()[0] !~ '\.git\/COMMIT_EDITMSG$'
    let l:session_file_path = GetSessionFilePath()
    execute 'mksession! ' . l:session_file_path
  endif
endfunction                                                                                                                                                                                                                                                                                                                 

fu! RestoreSess()                                                                                                                                                                                                                                                                                                           

  let l:session_file_path = GetSessionFilePath()

  if filereadable(l:session_file_path)                                                                                                                                                                                                                                                                                 
    execute 'so ' . l:session_file_path                                                                                                                                                                                                                                                                              
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

" Begin plugin configuration

call pathogen#infect()

let g:NERDTreeShowHidden=1

" setup to use vim-flavored-markdown plugin which is an extension
" of tpope's vim-markdown (both needed) to get syntax highlighting for
" github flavored markdown instead of standard
augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.mp4 let &bin=1
  au BufReadPost *.mp4 if &bin | %!xxd -g 1
  au BufReadPost *.mp4 set ft=xxd | endif
  au BufWritePre *.mp4 if &bin | %!xxd -r
  au BufWritePre *.mp4 endif
  au BufWritePost *.mp4 if &bin | %!xxd -g 1
  au BufWritePost *.mp4 set nomod | endif
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

" let the vim-javascript plugin do syntax highlighting on js/ng doc
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" disable concealing characters in JSON
let g:vim_json_syntax_conceal = 0
