" ==================== IMPORTANT ====================
" 1. 用 n/v/imap + 按键(vmap i) 可以查找这个按键绑定的映射，
" 在找不到为什么这个按键被占用时非常有用
" 2. t=terminal n=normal v=visual c=command
" ==================== IMPORTANT ====================

" 设置leader键
let mapleader=" "
" 开局之后高亮哦
exec "nohlsearch"
" 不知道为啥我的tab不设置这个，Tab按了就会直接退回正常模式
inoremap <Tab> <Tab>
tnoremap <Tab> <Tab>


" ==================== Cursor Movement ====================
"     ^
"     i
" < y   o >
"     n
"     v
"noremap <silent> i k
"noremap <silent> y h
"noremap <silent> n j
"noremap <silent> o l
"noremap <silent> i l
noremap y h
noremap n j
noremap i k
noremap o l
" tnoremap y h
" tnoremap n j
" tnoremap i k
" tnoremap o l
"noremap s <nop> " 避免误操作->现在用来作leap.nvim的跳转键了

noremap r i
noremap l o
noremap L O
noremap j y
noremap J Y
noremap k r
noremap K R
noremap R I
" 涉及递归问题才需要"nore"
noremap p nzz " 保持居中，比较舒适
noremap P Nzz
noremap <c-e> <nop>

noremap h p

" 快速跳转
noremap N 5j
noremap I 5k
noremap W 5w
noremap B 5b
noremap Y 5h
noremap O 5l
"noremap <c-y> 5j
"noremap <c-o> 5k
" g mode
"           start
"           ^
"           i
" start <y (g) o > end
"           n
"           v
"           end
noremap gy 0
noremap go $
noremap gn G
noremap gi gg
"noremap Y 5h
"noremap O 5l
"noremap Y 0
"noremap O $

" A <- and enter insert mode
" T -> and enter insert mode
noremap A I
noremap T A
"map t 0
"map s $ 
	" 跳转到行尾
noremap <LEADER>g G
"noremap G gg
"noremap gg G 

" 方便命令模式
"nnoremap ; :
nnoremap <C-.> :

" 正常模式上插入新行
map <Enter> l<ESC>

" 插入模式下操作
"inoremap jj <ESC>
"inoremap jk <ESC>

"inoremap ii <ESC>

" 保存，退出，激活设置
	" 退出
map \ :q<CR>
map Q :q!<CR>
map <LEADER>q :q<CR>
	" 保存
map <LEADER>s :w<CR>
map <c-s> :w<CR>
map S :w<CR>
	" 激活
map <LEADER>r :source $MYVIMRC<CR>
"map R :source $MYVIMRC<CR>

" 取消高亮
noremap <LEADER><CR> :nohlsearch<CR>
noremap <LEADER>h :nohlsearch<CR>

" 在任何模式的窗口间交换
tnoremap <C-y> <C-\><C-N><C-w>h
tnoremap <C-n> <C-\><C-N><C-w>j
tnoremap <C-i> <C-\><C-N><C-w>k
tnoremap <C-o> <C-\><C-N><C-w>l
"inoremap <C-y> <C-\><C-N><C-w>h
"inoremap <C-n> <C-\><C-N><C-w>j
"inoremap <C-i> <C-\><C-N><C-w>k
"inoremap <C-o> <C-\><C-N><C-w>l
nnoremap <C-y> <C-w>h
nnoremap <C-n> <C-w>j
nnoremap <C-i> <C-w>k
nnoremap <C-o> <C-w>l

" 创建分割窗口
noremap <LEADER>v :vsplit<CR>

" 调整分隔窗口
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

" tab mode
"           
" start <y (t) o > end
"           
map tn :tabe<CR> " create new tab
map ty :-tabnext<CR> " left tab
map to :+tabnext<CR> " right tab
"map sv <c-w>t<c-w>H " 横竖格式转换，下面那个也是
"map sh <c-w>t<c-w>K

" terminal mode
tnoremap \ <C-\><C-n>:q!<CR>
tnoremap <Esc> <C-\><C-n>
"noremap tt :vs\|:te<CR> " 用tt打开终端速度会更快
map <LEADER>th :vs\|:te<CR> 
map <LEADER>ts :vs\|:te 
" 这里有一个空格，没有回车的话可以在后面添加自己的代码内容:D


"---------------------------------------------
"第三方插件
"---------------------------------------------

" translate
nmap <silent> mm <Plug>TranslateW "用窗口模式打开
vmap <silent> mm <Plug>TranslateWV "<LEADER>t

" nerdtree
"map <LEADER>n :NERDTreeToggle<CR> "开关tree

" indentline(BlanklineToggle)
map <LEADER>i :IndentBlanklineToggle<CR>

" leap.nvim
map s <Plug>(leap-forward-to)
map S <Plug>(leap-backward-to)

" 这个不知道有没有用
"map <Leader> <Plug>(easymotion-prefix)

" Undotree -
" 撤销树打开的时候，行号前面会增加一些描述的符号，关闭树面板后会自动消失
nnoremap <LEADER>u :UndotreeToggle<CR>

" surround
let g:surround_no_mappings = 1
" 修改为ms，原本为ys。可视模式下用大写S
nmap ds  <Plug>Dsurround
nmap cs  <Plug>Csurround
nmap cS  <Plug>CSurround
nmap ms  <Plug>Ysurround
nmap mS  <Plug>YSurround
nmap mss <Plug>Yssurround
nmap mSs <Plug>YSsurround
nmap mSS <Plug>YSsurround
xmap S   <Plug>VSurround
xmap gS  <Plug>VgSurround

" gitgutter - 不然在 V 模式下会影响正常上下选取
vnoremap <nop> <Plug>(GitGutterTextObjectInnerVisual)

" -----------------------------------------------------
" coc
" -----------------------------------------------------


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-l> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> ga <Plug>(coc-type-definition)
nmap <silent> gs <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

noremap <LEADER>g :CocDisable<CR>


let g:coc_global_extension = [
    \'coc-json',
    \ 'coc-vimlsp']

" -----------------------------------------------------
" Ultisnips
" -----------------------------------------------------
let g:UltiSnipsExpandTrigger="<c-r>"
" c-n跳到下一个转折点，原来我一直理解错了
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-i>"
let g:UltiSnipsSnippetDirectories= [$HOME.'/.config/nvim/Ultisnips/','UltiSnips']
let g:UltiSnipsEditSplit="vertical"

" -----------------------------------------------------
" coc-explorer
" -----------------------------------------------------

" 启动
nmap <LEADER>e <Cmd>CocCommand explorer<CR>

" -----------------------------------------------------
" nnn.nvim
" -----------------------------------------------------

nmap <LEADER>n :NnnExplorer<CR>
