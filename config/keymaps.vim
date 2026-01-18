" ======================================
" 
"            Keyboard Mapping
" 
" ======================================
" 原生vim按键配置

" 快速退出插入模式
inoremap jk <esc>
" <c-c>可以在命令行和可视模式下进入normal模式
" vnoremap jk <esc>
" cnoremap kj <C-C>

" 快速移动
noremap J 5j
noremap K 5k
" noremap gj G
nnoremap <BS> ciw
noremap <Enter> o<Esc>

" set leader key
let mapleader=" "

" 保存退出快捷键
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
" nnoremap <leader>rr so %<cr>
" 重映射分号，避免重复输入冒号到手痛
noremap ; :
" noremap ' :

" 求你别一直高亮了
nmap <silent> <leader>n :silent :nohlsearch<CR>

" === 窗口 ===
" c-w q 可以关系当前窗口 c-w o 关闭除当前窗口外的所有窗口
tnoremap <c-j> <c-w><c-j>
tnoremap <c-k> <c-w><c-k>
tnoremap <c-l> <c-w><c-l>
tnoremap <c-h> <c-w><c-h>

" 在tmux下无效
inoremap <C-Enter> <Esc>o

" cnoremap
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

" === 命令缩写 ===
" 强制退出缩写 :qqq -> :q!
cnoreabbrev qqq q!