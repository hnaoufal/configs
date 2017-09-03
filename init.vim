let g:python_host_prog='/usr/bin/python3'
let g:deoplete#enable_at_startup = 1

set nocompatible
filetype off

call plug#begin("~/.nvim/bundle")
" Plugin List
Plug 'rking/ag.vim'
Plug 'kien/ctrlp.vim'
Plug 'Yggdroot/indentLine'
Plug 'Valloric/MatchTagAlways'
Plug 'Valloric/YouCompleteMe', {'do': 'CXX=clang++ CC=clang python install.py --clang-completer'}
Plug 'altercation/vim-colors-solarized'
Plug 'jlanzarotta/bufexplorer'
Plug 'bigeagle/molokai'
Plug 'lervag/vimtex'
Plug 'bling/vim-airline'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'mxw/vim-jsx'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'wakatime/vim-wakatime'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'townk/vim-autoclose'
Plug 'ap/vim-css-color'
Plug 'docunext/closetag.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'scrooloose/nerdtree'
if has('nvim')
	Plug 'benekastah/neomake'
else
	Plug 'scrooloose/syntastic'
endif
Plug 'tpope/vim-sensible'
Plug 'shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim'
Plug 'vimlab/split-term.vim'
Plug 'moll/vim-node'
Plug 'othree/yajs.vim'
Plug 'pangloss/vim-javascript'
Plug 'carlitux/deoplete-ternjs',  { 'do': 'npm install --cache-min Infinity --loglevel http -g tern' }
Plug 'ternjs/tern_for_vim',       { 'do': 'npm install --cache-min Infinity --loglevel http' }
Plug 'neovim/node-host',          { 'do': 'npm install --cache-min Infinity --loglevel http' }
Plug 'vim-scripts/DrawIt'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'embear/vim-localvimrc'
Plug 'jrosiek/vim-mark'
Plug 'mbbill/undotree'
Plug 'kien/rainbow_parentheses.vim'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-obsession'
Plug 'mattn/emmet-vim'
Plug 'moll/vim-node'
Plug 'hdima/python-syntax'
Plug 'hynek/vim-python-pep8-indent'
Plug 'davidhalter/jedi-vim'
Plug 'fatih/vim-go'
Plug 'lervag/vim-latex'
Plug 'cakebaker/scss-syntax.vim'
Plug 'tpope/vim-fugitive'
Plug 'zaiste/tmux.vim'
Plug 'elzr/vim-json'
Plug 'lepture/vim-jinja'
Plug 'cespare/vim-toml'
Plug 'scrooloose/nerdcommenter'
Plug 'isRuslan/vim-es6'
Plug 'bigeagle/sieve.vim'
Plug 'posva/vim-vue'
Plug 'google/vim-ft-bzl'

Plug 'caio/querycommandcomplete.vim'
Plug 'justinmk/vim-gtfo'
Plug 'freitass/todo.txt-vim'
Plug 'jpraise/vim-graphql'
call plug#end()

" Some configs on Plugins "
let g:jsx_ext_required = 0
let g:neomake_open_list=0
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_logfile = '/home/hicham/log/neomake.log'
autocmd! BufWritePost * Neomake

let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let g:used_javascript_libs = 'jquery,underscore,react,chai,vue'

" "

set so=10
set number
syntax on
filetype on
filetype plugin on
filetype indent on
syntax enable
set background=dark
colorscheme solarized

set list lcs=tab:\¦\   

if has("autocmd")  " go back to where you exited
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif
endif

set completeopt=longest,menu " preview

if has('mouse')
    set mouse=a
    set selectmode=mouse,key
    set nomousehide
endif

set autoindent
set modeline
set cursorline
set cursorcolumn

set tabstop=2
set shiftwidth=2
set expandtab

set showmatch
set matchtime=0
set nobackup
set nowritebackup
set directory=~/.nvim/.swapfiles//

if has('nvim')
  set termguicolors
  set ttimeout
  set ttimeoutlen=0
endif

"在insert模式下能用删除键进行删除
set backspace=indent,eol,start

set fenc=utf-8
set fencs=utf-8,gbk,gb18030,gb2312,cp936,usc-bom,euc-jp
set enc=utf-8

"按缩进或手动折叠
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
set foldcolumn=0 "设置折叠区域的宽度
set foldlevelstart=200
set foldlevel=200  " disable auto folding
" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
vnoremap <Space> zf


set smartcase
set ignorecase
set nohlsearch
set incsearch
set autochdir

" Mappings
"
vmap j gj
vmap k gk
nmap j gj
nmap k gk


nmap <F8> :TagbarToggle<CR>
nmap T :tabnew<cr>

au FileType c,cpp,h,java,css,js,nginx,scala,go inoremap  <buffer>  {<CR> {<CR>}<Esc>O

au BufNewFile *.py call ScriptHeader()
au BufNewFile *.sh call ScriptHeader()
au FileType vue syntax sync minlines=500

function ScriptHeader()
    if &filetype == 'python'
        let header = "#!/usr/bin/env python2"
        let coding = "# -*- coding:utf-8 -*-"
        let future = "from __future__ import print_function, division, unicode_literals"
        let cfg = "# vim: ts=4 sw=4 sts=4 expandtab"
    elseif &filetype == 'sh'
        let header = "#!/bin/bash"
    endif
    let line = getline(1)
    if line == header
        return
    endif
    normal m'
    call append(0,header)
    if &filetype == 'python'
        call append(1, coding)
        call append(2, future)
        call append(4, cfg)
    endif
    normal ''
endfunction


source ~/.config/nvim/config/airline.vim
source ~/.config/nvim/config/python.vim
source ~/.config/nvim/config/tagbar.vim
source ~/.config/nvim/config/nerdtree.vim
source ~/.config/nvim/config/cscope.vim
source ~/.config/nvim/config/syntastic.vim
source ~/.config/nvim/config/ycm.vim
source ~/.config/nvim/config/ultisnips.vim
source ~/.config/nvim/config/rainbow_brackets.vim
source ~/.config/nvim/config/latex.vim
source ~/.config/nvim/config/vim-go.vim
source ~/.config/nvim/config/pandoc.vim
source ~/.config/nvim/config/scss.vim
source ~/.config/nvim/config/querycommand.vim
source ~/.config/nvim/config/localvimrc.vim
source ~/.config/nvim/config/ctrlp.vim
source ~/.config/nvim/config/vim-notes.vim
source ~/.config/nvim/config/indentLine.vim
source ~/.config/nvim/config/easymotion.vim
source ~/.config/nvim/config/noplaintext.vim
source ~/.config/nvim/config/json.vim

" Load local config if exists
if filereadable(expand("~/.nvim/config/local.vim"))
	source ~/.nvim/config/local.vim
endif

