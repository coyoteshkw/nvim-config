" ======================================
"
"            Plugin Settings
"
" ======================================

" packloadall " 加载所有插件
" silent! helptags ALL "为所有插件加载帮助文档

call plug#begin()
Plug 'junegunn/vim-plug' " 加载文档
Plug 'tpope/vim-vinegar' " 给newtr目录管理添加- 键等小功能，如果安装Nerdtree会默认使用那个
" 快速搜索
Plug 'ctrlpvim/ctrlp.vim' " 搜索当前目录的文件、最近修改的文件、buffer
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" 快速移动
Plug 'mileszs/ack.vim' " 在vim中使用ack命令，将结果用quickfix窗口打开
Plug 'easymotion/vim-easymotion' " 快速移动
Plug 'rhysd/clever-f.vim' " 重复f/F键来执行原先;,的操作
" 实用工具
Plug 'tpope/vim-surround' " 添加、修改各种括号中的内容
Plug 'tpope/vim-unimpaired' " 为[ ] y 键添加一些实用映射
Plug 'christoomey/vim-tmux-navigator' " tmux支持
Plug 'tpope/vim-commentary' " 注释 gcc
Plug 'michaeljsmith/vim-indent-object' " 定义基于缩进级别的文本对象i和I
Plug 'terryma/vim-expand-region' " +/_ 扩大缩小可视选择的范围
Plug 'vimwiki/vimwiki'
" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'} " 语法补全
" 语言拓展
Plug 'godlygeek/tabular' " 为md提供目录支持
Plug 'preservim/vim-markdown', {'for': 'md'} " md支持

" 外观
Plug 'morhetz/gruvbox'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'junegunn/seoul256.vim'
Plug 'joshdick/onedark.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'sainnhe/everforest'
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
Plug 'cocopon/iceberg.vim'

Plug 'vim-airline/vim-airline' " 底栏美化及其主题
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify' " 美化启动界面
Plug 'machakann/vim-highlightedyank' " 高亮复制内容
Plug 'nathanaelkane/vim-indent-guides' " 缩进线，通过<leader>ig开关
call plug#end()

" ==> highlightedyank
let g:highlightedyank_highlight_duration = 500  " 高亮持续时间（毫秒）

" ==> ctrlp
let g:ctrlp_show_hidden = 0 " ctrl插件允许搜索隐藏文件
" Quickly find and open a file in the CWD
let g:ctrlp_map = '<C-p>'

" Quickly find and open a recently opened file
" map <leader>ff :CtrlPMRUFiles<CR>
" map <leader>ff :Files<CR>

" Quickly find and open a buffer
map <leader>b :CtrlPBuffer<cr>

" ==> vim-indent-guides
let g:indent_guides_guide_size = 1 " < shiftwidth's size
let g:indent_guides_start_level = 2
let g:indent_guides_space_guides = 0
let g:indent_guides_tab_guides = 0
" let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
" default mapping
" :nmap <silent> <Leader>ig <Plug>IndentGuidesToggle

" ==> clever-f
let g:clever_f_chars_match_any_signs = ";"
let g:clever_f_smart_case = 1

" ==> tpope/vim-commentary
nnoremap <C-/> :Commentary<CR>
" inoremap <C-/> :Commentary<CR>

" ==> vimwiki
let g:vimwiki_list = [{'path': '~/Documents/vimwiki', 'path_html': '~/Documents/vimwiki_public_html/'}]

" ==> vim-markdown
let g:vim_markdown_borderless_table = 1 " 允许不描边创建边框，看不懂那用就是了
