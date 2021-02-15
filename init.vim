call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/seoul256.vim'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'spacewander/vim-gitgutter'
Plug 'airblade/vim-gitgutter'
Plug 'python/black'
Plug 'dense-analysis/ale'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'jxnblk/vim-mdx-js'
Plug 'leafgarland/typescript-vim'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'mileszs/ack.vim'
call plug#end()

" leader (\)
let mapleader = ","

" ag
let g:ackprg = 'ag --nogroup --nocolor --column'

" holding shift is slow
nnoremap ; :
nnoremap ' "

" fast escape
inoremap jj <ESC>

" move tabs
nmap H gT
nmap L gt

" bindings

nnoremap Q :q<CR>

"  fzf
nmap <c-p> :Files<CR>
nmap <c-l> :Lines<CR>
nmap <c-f> :Tags<CR>
nmap <Leader>a :Ag<CR>

imap <c-x><c-f> <plug>(fzf-complete-path)

"  quotes

nmap <Leader>w viw<Leader>
nmap <Leader>W viW<Leader>

vmap <Leader>( c(<c-R>")<Esc>F(
vmap <Leader>) c(<c-R>")<Esc>F(
vmap <Leader>[ c[<c-R>"]<Esc>F[
vmap <Leader>] c[<c-R>"]<Esc>F[
vmap <Leader>{ c{<c-R>"}<Esc>F{
vmap <Leader>} c{<c-R>"}<Esc>F{
vmap <Leader>' c'<c-R>"'<Esc>F'
vmap <Leader>" c"<c-R>""<Esc>F"
vmap <Leader>` c`<c-R>"`<Esc>F`

imap <Leader>( ()<Esc>i
imap <Leader>{ {}<Esc>i
imap <Leader>[ []<Esc>i

vmap @ "pdvh"pp

vmap <Leader>/ dO/*<CR>*/<Esc>P
vmap <Leader>? dO/*<CR>*/<Esc>P

xnoremap p pgvy

"  expand js blocks
vmap + :ma 1<CR>:s/{/{\r/g<CR>:s/}/\r}/g<CR>:ma 2<CR>v`1==v`2:%s/\s\+$//e<CR>:noh<CR>

"  expand selected json
vmap ..json :'<,'>!jq .<CR>

"  insert js console
vmap <Leader>log cconsole.info({  thing: ",})v%=jw

" edit this file
nmap <Leader>conf :tabe $CONFIG_DEV_DIR/init.vim<CR>

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

" tags
"
set tags=.git/tags;~

" lint
"
let g:ale_linters = {
\   'javascript': ['standard'],
\   'python': ['flake8']
\}
let g:ale_fixers = {
\   'javascript': ['standard'],
\   'python': ['black']
\}
let g:ale_fix_on_save = 1
"let g:ale_open_list = 1
" hooks

autocmd! BufWritePost init.vim source %
autocmd BufWritePre *.* :%s/\s\+$//e
autocmd BufReadPost *.md :set tw=60 spell spelllang=en_us

" disable paste mode when leaving insert
autocmd InsertLeave * set nopaste

" bash env
let $BASH_ENV = $CONFIG_DEV_DIR . "/vim/bash_env.sh"

set shell=/bin/bash
