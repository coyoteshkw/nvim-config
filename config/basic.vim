" ======================================
" 
"            Basic Settings
" 
" ======================================
" source: https://web.archive.org/web/20090213130939/http://items.sjbach.com/319/configuring-vim-right

syntax on
set mouse=a
set hidden
set number
set relativenumber
set nobackup
set encoding=utf-8
set hlsearch
filetype plugin indent on
set autoindent
set backspace=2
"设置两缩进
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2

set wildmenu
set wildmode=list:longest,full
set ignorecase
set smartcase
set title
set scrolloff=3
set ruler
" Highlight search terms...
set hlsearch
set incsearch " dynamically as they are typed.
set belloff=all " so annoying
" 修复按下Esc后光标恢复有延迟的问题
set ttimeout
set ttimeoutlen=1
set ttyfast
set termguicolors " 24位真彩色(比256色还大)
set laststatus=2

" 设置 textwidth (全局默认值)
" set textwidth=80  " 0 表示禁用全局的 textwidth

" 使自动换行生效
" set wrap

" 控制格式化行为，t表示启用自动换行
" set formatoptions+=tcqrn

" " 文件类型特定设置
" autocmd FileType c,cpp,h,hpp setlocal textwidth=80
" autocmd FileType python setlocal textwidth=79
" autocmd FileType markdown,vimwiki,wiki setlocal textwidth=72 " Markdown通常建议更小的宽度

" 高亮当前行
set cursorline
highlight CursorLine cterm=NONE ctermbg=darkgray guibg=lightgrey
" 在大约 80 字符的位置显示一条竖线，
" 如果配置了特定文件的textwidth选项则使用它定义的宽度
" set colorcolumn=80
augroup ColorColumn
  autocmd!
  autocmd FileType * let &colorcolumn = &textwidth ? &textwidth : 80
augroup END
highlight ColorColumn ctermbg=7 guibg=lightgrey

" 自动跳转到上次关闭时的光标位置
autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

" 复制粘贴使用系统剪贴板
" set clipboard=unnamedplus  " Linux/WSL (使用寄存器 '+')
set clipboard=unnamed   " Mac (使用寄存器 '*', 但现代 Mac 也支持 +)

" cursor插入模式光标设置
" > https://stackoverflow.com/questions/6488683/how-to-change-the-cursor-between-normal-and-insert-modes-in-vim
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" 另一种方法光标设置方法
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_SR = "\<Esc>]50;CursorShape=2\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" 折叠
set foldmethod=indent
set foldlevel=99
nnoremap god :if &foldlevel == 0 <Bar> set foldlevel=99 <Bar> else <Bar> set foldlevel=0 <Bar> endif<CR>
set nowrap
