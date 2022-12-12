exec "nohlsearch"



call plug#begin()
Plug 'yaocccc/vim-fcitx2en'
"Plug 'scrooloose/nerdtree'
"Plug 'Svtter/ACM.vim'
"Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'ggandor/leap.nvim'
Plug 'airblade/vim-gitgutter'
"Plug 'terryma/vim-expand-region'
"Plug 'vimwiki/vimwiki'
Plug 'mhinz/vim-signify'
Plug 'voldikss/vim-translator' "翻译
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'luukvbaal/nnn.nvim'

" 美化
Plug 'joshdick/onedark.vim' "主题
Plug 'connorholyday/vim-snazzy'
Plug 'ayu-theme/ayu-vim'
Plug 'sts10/vim-pink-moon'
"Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'sainnhe/everforest'
" ----------------------------
Plug 'sheerun/vim-polyglot' " vim语言包
Plug 'arcticicestudio/nord-vim'
Plug 'mhinz/vim-startify' " 更好的启动页
"Plug 'luochen1990/rainbow'
Plug 'hotoo/pangu.vim', { 'for': ['markdown', 'vimwiki', 'text'] } " 中文格式化
let g:pangu_rule_date = 1
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

call plug#end()

" -----------------------------------------------------
" nnn.nvim
" -----------------------------------------------------

lua << EOF
require("nnn").setup()
EOF

" -----------------------------------------------------
" 主题配色设置
" -----------------------------------------------------

" enable true colors support
set termguicolors

" snazzy
colorscheme snazzy
let g:SnazzyTransparent = 1 " 给snazzy主题用的，会让背景透明

" ayu
"let ayucolor="light"  
"let ayucolor="mirage"
"let ayucolor="dark"  
"colorscheme ayu

" everforest-configuration
" For dark version.
" set background=dark

" For light version.
" set background=light

" Set contrast.
" This configuration option should be placed before `colorscheme everforest`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'medium'

" For better performance
" let g:everforest_better_performance = 1
" let g:everforest_transparent_background = 2
" let g:everforest_show_eob = 1
" let g:everforest_ui_contrast = 'high'
" colorscheme everforest


" -----------------------------------------------------
" lightline配置
" -----------------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'everforest',
      \ }
" 修改为nord主题自带的，原本是wombat
" snazzy,ayu,nord,everforest


" -----------------------------------------------------
" startify配置
" -----------------------------------------------------

let g:startify_bookmarks = [ {'i': '~/.config/nvim'}]
" 你可以通过键入i来直接进入文件中，像输入其他数字那样

      " 排序
  let g:startify_lists = [
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ ]

" -----------------------------------------------------
" 彩虹括号rainbow官方配置
" -----------------------------------------------------
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

	let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'lisp': {
	\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'css': 0,
	\	}
	\}

" -----------------------------------------------------
" nerdcommenter注释
" -----------------------------------------------------

" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1


" -----------------------------------------------------
" pangu-vim
" -----------------------------------------------------

" vimrc 中开启保存文件时自动规范化功能
autocmd BufWritePre *.markdown,*.md,*.text,*.txt,*.wiki,*.cnx call PanGuSpacing('ALL')

" -----------------------------------------------------
" IndentLine 暂时没在用了
" -----------------------------------------------------

" IndentLine {{
"let g:indentLine_char = '¦'
"let g:indentLine_first_char = '¦'
"let g:indentLine_showFirstIndentLevel = 1
"let g:indentLine_setColors = 0
" }}

"let g:markdown_syntax_conceal=0
"let g:vim_json_conceal=0

" -----------------------------------------------------
" coc settings
" -----------------------------------------------------
