set nocompatible

" ------------
" START VUNDLE
" ------------

filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
call vundle#end()

filetype plugin indent on

" ----------
" END VUNDLE
" ----------

"set nofoldenable  " disable folding
"set foldlevelstart=99

" Enable colorcolumn, but only vim 7.3 seems to have it
if version >= 703
    set colorcolumn=80
endif

set t_Co=256
syntax on
colorscheme desert
set hlsearch
set incsearch
set ignorecase
set smartcase
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

" Color scheme tweaks
" Set orange highlight for hlsearch terms
hi Search ctermbg=3
hi DiffAdd ctermfg=233
hi DiffChange ctermfg=233 ctermbg=3
hi DiffDelete ctermfg=233
hi DiffText ctermfg=233
" Change the ugly gray gutter to a darker color
hi SignColumn ctermbg=black

filetype on
filetype plugin on
filetype indent on

" Special indentation for JSON
au! BufRead,BufNewFile *.json set filetype=json
autocmd FileType json setlocal sw=2 sts=2 ts=2 noet

" Highlight whitespace
set list!
set listchars=tab:>-

" Keep lines selected after shifting them
vnoremap > >gv
vnoremap < <gv
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj

" Persistent undo
if version >= 703
    set undodir=~/.vimundo
    set undofile
endif

" Create .swp files somewhere else
set directory=~/.vimswp

" Store swap files outside of project directories
set directory=~/.vimswap

" or else my backspace does not work:
set backspace=indent,eol,start

" LaTeX automation:
autocmd FileType tex map = :w<CR>:silent !pdflatex -shell-escape %<CR>:!open %<.pdf<CR>:!osascript -e 'tell application "iTerm"' -e 'activate' -e 'end tell'<CR> :<CR>
autocmd FileType tex setlocal sw=2 sts=2 et
autocmd FileType tex set wrap
autocmd FileType tex set nolist
autocmd FileType tex set linebreak

let g:tex_conceal = ""

" Trailing whitespace indicator
if !exists('g:extra_whitespace_ignored_filetypes')
    let g:extra_whitespace_ignored_filetypes = []
endif

function! ShouldMatchWhitespace()
    for ft in g:extra_whitespace_ignored_filetypes
        if ft ==# &filetype | return 0 | endif
    endfor
    return 1
endfunction

" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=darkred guibg=#382424
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * if ShouldMatchWhitespace() | match ExtraWhitespace /\s\+$/ | endif

" The above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * if ShouldMatchWhitespace() | match ExtraWhitespace /\s\+$/ | endif
autocmd InsertEnter * if ShouldMatchWhitespace() | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
