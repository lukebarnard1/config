call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/seoul256.vim'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'airblade/vim-gitgutter'
Plug 'python/black'
Plug 'dense-analysis/ale'
Plug 'mxw/vim-jsx'
Plug 'jxnblk/vim-mdx-js'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'mileszs/ack.vim'
call plug#end()

" leader (\)
let mapleader = ","

" ag
let g:ackprg = 'ag --nogroup --nocolor --column'

" coc
"  tab to complete, shift-tab to reverse
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"  enter to confirm
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" holding shift is slow
nnoremap ' "
nnoremap <Leader>s :w<CR>

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
nmap <Leader>l :Lines<CR>

imap <c-x><c-f> <plug>(fzf-complete-path)
let g:fzf_layout = { 'down': '40%' }

nmap <Leader>d :noh<CR>

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

nmap <Leader>s :w<CR>

xnoremap p pgvy

" find replace
" after selection and replace
nmap <Leader>/ :%s/<c-R>//<c-R>./g

" scrolling
"
:map <ScrollWheelUp> k0g^
:map <ScrollWheelDown> j0g^

"  expand js blocks
vmap + :ma 1<CR>:s/{/{\r/g<CR>:s/}/\r}/g<CR>:ma 2<CR>v`1==v`2:%s/\s\+$//e<CR>:noh<CR>

"  expand selected json
vmap ..json :'<,'>!jq .<CR>

"  insert js console
vmap <Leader>log cconsole.info({  thing: ",})v%=jw

" CoC
"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" edit this file
nmap <Leader>conf :tabe $CONFIG_DEV_DIR/init.vim<CR>

"  disable
map <F1> <Esc>
imap <F1> <Esc>

" themes

colo seoul256
colo seoul256-light

set background=light

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
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'mdx': ['eslint'],
\   'typescriptreact': ['eslint'],
\   'python': ['flake8']
\}
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'mdx': ['eslint'],
\   'typescriptreact': ['eslint'],
\   'python': ['black']
\}
let g:ale_fix_on_save = 1
"let g:ale_open_list = 1
" hooks

autocmd! BufWritePost init.vim source %
autocmd BufWritePre *.* :%s/\s\+$//e
autocmd FileType Markdown setlocal tw=80 spell spelllang=en_us

" disable paste mode when leaving insert
autocmd InsertLeave * set nopaste

" vim-js-file-import
let g:js_file_import_from_root = 1
let g:js_file_import_root = getcwd().'/src'
let g:js_file_import_root_alias = 'src/'
let g:js_file_import_omit_semicolon = 1
let g:js_file_import_use_fzf = 1
let g:js_file_import_strip_file_extension = 1

" vim-jsx-typescript
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact


" gutentags
let g:gutentags_ctags_tagfile = '.git/tags'

" bash env
let $BASH_ENV = $CONFIG_DEV_DIR . "/vim/bash_env.sh"

set shell=/bin/bash
