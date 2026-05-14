" ======================================
" 
"              Colorscheme
" 
" ======================================

" seoul256 config info:https://github.com/junegunn/seoul256.vim

" hi Normal guibg=NONE ctermbg=NONE
" let t:is_transparent = 0

" Toggle transparent background
let t:is_transparent = 0
function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
"        set background=dark
        let t:is_tranparent = 0
    endif
endfunction

nnoremap gl : call Toggle_transparent()<CR>


" ====================================== 
"
" configuration option should be placed before colorscheme
"
" ====================================== 
"

" => everforest
" Set contrast.
" Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'medium'

" For better performance
let g:everforest_better_performance = 1

let g:airline_theme = 'everforest'
let g:everforest_enable_italic = 1
" To use transparent background, set this option to `1`.
" If you want more ui components to be transparent (for example, status line background), set this option to `2`.
" let g:everforest_transparent_background = 1
" Some plugins support highlighting error/warning/info/hint texts, by default 
" these texts are only underlined, but you can use this option to also highlight the background of them.
let g:everforest_diagnostic_text_highlight = 1
" Some plugins support highlighting error/warning/info/hint lines, but this feature is disabled by default in this color scheme. To enable this feature, set this option to `1`.
let g:everforest_diagnostic_line_highlight = 1
let g:everforest_inlay_hints_background = 'dimmed' " none

" => iceberg
" TODO 
" let g:airline_theme = 'iceberg'


"
set background=dark
" set background=light
" colorscheme catppuccin-mocha " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
" colorscheme onedark
colorscheme everforest

hi CocHighlightText guibg=#45475a ctermbg=238
