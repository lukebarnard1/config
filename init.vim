call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/seoul256.vim'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'spacewander/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
call plug#end()

" bindings

"  fzf
nmap <c-p> :Files<CR>
nmap <c-l> :Lines<CR>

"  disable
map <F1> <Esc>
imap <F1> <Esc>

" themes

colo seoul256
colo seoul256-light

set background=dark

" display settings

let g:lightline = {
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ], [ 'relativepath' , 'modified' ] ],
	\   'right': [ [ 'lineinfo' ], [ 'gitbranch'] ]
	\ },
	\ 'component_function': {
	\   'gitbranch': 'gitbranch#name'
	\ },
  \ 'colorscheme': 'seoul256',
\ }

set noshowmode " hide -- MODE --

" tabs
set tabstop=2
set softtabstop=0 expandtab
set shiftwidth=2

set guitablabel=%F

" lint
let g:ale_linters = {
\   'javascript': ['standard'],
\}
let g:ale_fixers = {'javascript': ['standard']}

let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

" hooks

autocmd BufWritePre *.* :%s/\s\+$//e
autocmd BufReadPost *.md :set fo+=a tw=60
