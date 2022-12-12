""" 通用设置

"when vim is started, execute this command in command mode
exec "nohlsearch"
"colorscheme nord "nord

" 设置256彩色
"if !has('gui_running')
"		  set t_Co=256
"endif

set signcolumn=yes
set encoding=utf-8
let &t_ut=''
set nocompatible

filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.
set number
set relativenumber
" set noshowmode

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

set wrap "不会让代码跑到窗口之外（自适应窗口大小）
set wildmenu "在命令模式下按tab显示可用选项

set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set backspace=indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.
set ignorecase "忽略大小写
set smartcase " 自动匹配大小写set ttyfast                " Faster redrawing.

set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.
"set list lcs=tab:\¦\

set hidden
set updatetime=200
set shortmess
