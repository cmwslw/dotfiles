set nocompatible

"set nofoldenable  " disable folding
"set foldlevelstart=99

set colorcolumn=80

set t_Co=256
syntax on
colorscheme desert
set hlsearch
set cursorline
set autoindent
set smartindent
set cindent
set ruler
set sw=4
set sts=4
set et
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

vnoremap > >gv
vnoremap < <gv
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj

" Persistent undo
set undodir=~/.vimundo
set undofile

" or else my backspace does not work:
set backspace=indent,eol,start

" LaTeX automation:
autocmd FileType tex map = :w<CR>:silent !pdflatex -shell-escape %<CR>:!open %<.pdf<CR>:!osascript -e 'tell application "iTerm"' -e 'activate' -e 'end tell'<CR> :<CR>
autocmd FileType tex setlocal sw=2 sts=2 et
autocmd FileType tex set wrap
autocmd FileType tex set nolist
autocmd FileType tex set linebreak

let g:tex_conceal = ""
