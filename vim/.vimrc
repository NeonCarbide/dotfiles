" SETTINGS ----------------------------------------------------------------- {{{

set nocompatible " disable vi compatibility

filetype on " enable filetype detection
filetype plugin on " enable plugins and load plugin for detected filetype
filetype indent on " load an indent file for detected filetype

syntax on " enable syntax highlighting

set number relativenumber " enable hybrid relative line numbers

set shiftwidth=4 " set shift width to 4 spaces
set tabstop=4 " set tab width to 4 columns
set expandtab " use spaces instead of tabs

set scrolloff=10 " don't let cursor scroll above or below N lines
" set ttyfast " speed up scrolling

set splitbelow " new hsplit below
set splitright " new vsplit right

set nowrap " disable line wrapping

set matchpairs+=<:> " highlight matching bracket pairs and jump with '%'

set list " display whitespace
set listchars=tab:>\ ,trail:*,extends:#,nbsp:. " set whitespace characters

set hlsearch " use highlighting during search
set incsearch " incrementally highlight matching characters during search
set ignorecase " ignore capital letters during search ...
set smartcase " ... unless specifically searching for them
set showmatch " show matching words during search

set showcmd " show partial commands
set showmode " show active mode

set history=200 " set number of commands to save in history

set wildmenu " enable autocompletion after pressing <Tab>
set wildmode=list:longest " make wildmenu behave like bash-completion

" make wildmenu ignore certain file extensions
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx 

let g:netrw_banner=0 " disable top banner in netrw
let g:netrw_browse_split=3 " open file in new tab
let g:netrw_keepdir=0 " keep current directory and browsing directory the same
let g:netrw_liststyle=3 " set netrw to tree-view
let g:netrw_localcopydircmd='cp -r' " enable recursive copying of directories
let g:netrw_winsize=-28 " absolute width of netrw

" highlight marked files in netrw the same way as search matches
hi! link netrwMarkFile Search

let g:airline_powerline_fonts=1 " populate the airline symbol dictionary with powerline symbols
let g:airline_theme='base16_gruvbox_dark_hard' " set airline theme

let g:gruvbox_contrast_dark='hard' " set gruvbox contrast
let g:gruvbox_italic=1
set background=dark " set gruvbox mode

" }}}

" PLUGINS ------------------------------------------------------------------ {{{

call plug#begin('~/.vim/plugged') " specify plugin directory

Plug 'airblade/vim-gitgutter' " git status to the left of line number
Plug 'ap/vim-css-color' " highlight colours with their colour
Plug 'dense-analysis/ale' " code linting
Plug 'morhetz/gruvbox' " gruvbox theme
Plug 'tpope/vim-fugitive' " git wrapper
Plug 'tpope/vim-surround' " add, change, and delete bracket and quote pairs
Plug 'vim-airline/vim-airline' " status bar
Plug 'vim-airline/vim-airline-themes' " status bar themes

call plug#end()

" }}}

" MAPPINGS ----------------------------------------------------------------- {{{

let mapleader=',' " set leader key

" reload vim
nmap <silent> <Leader>v :source ~/.vimrc<CR>:echo '.vimrc reloaded'<CR>

" toggle folds closed/open with <Space>
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" easier split navigation
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" --- netrw mappings ------------------------------------------------------- {{{

" open netrw in current file's directory
nnoremap <silent> <Leader>dd :Lexplore %:p:h<CR>

" open netrw in current working directory
nnoremap <silent> <Leader>da :Lexplore<CR>

function! NetrwMapping()
    " create bookmark
    nmap <buffer> bb mb

    " remove most recent bookmark
    nmap <buffer> bd mB

    " jump to most recent bookmark
    nmap <buffer> bl gb

    " create new file
    nmap <buffer> ff %:w<CR>:b #<CR>

    " rename file
    nmap <buffer> fe R

    " copy marked files
    nmap <buffer> fc mc

    " copy marked files to directory beneath cursor
    nmap <buffer> fC mtmc

    " move marked files
    nmap <buffer> fx mm

    " move marked files to directory beneath cursor
    nmap <buffer> fX mtmm

    " run external command on marked files
    nmap <buffer> f; mx

    " show list of marked files
    nmap <buffer> fl :echo join(netrw#Expose("netrwmarkfilelist"), "\n")<CR>

    " show target directory
    nmap <buffer> fq :echo 'Target:' . netrw#Expose("netrwmftgt")<CR>
    nmap <buffer> fd mtfq

    " go back in history
    nmap <buffer> H u

    " go up to parent directory
    nmap <buffer> h -^

    " open directory or file
    nmap <buffer> l <CR>

    " open file and close netrw
    nmap <buffer> L <CR>:Lexplore<CR>

    " close preview window
    nmap <buffer> P <C-w>z

    " toggle dotfile visibility
    nmap <buffer> . gh

    " toggle marked file
    nmap <buffer> <TAB> mf

    " unmark all files in current buffer
    nmap <buffer> <S-TAB> mF

    " unmark all files
    nmap <buffer> <Leader><TAB> mu

    " close netrw
    nmap <buffer> <Leader>dd :Lexplore<CR>

endfunction

" }}}

" }}}

" VIMSCRIPT ---------------------------------------------------------------- {{{

" if (has("termguicolors"))
"   set termguicolors
" endif

autocmd vimenter * ++nested colorscheme gruvbox

augroup filetype_netrw
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

augroup filetype_vim
    autocmd!
    autocmd filetype vim setlocal foldmethod=marker
augroup END

" }}}

" STATUS LINE -------------------------------------------------------------- {{{



" }}}
