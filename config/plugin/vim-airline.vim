" ==> vim-airline 
" let g:airline_theme='bubblegum'
let g:airline_theme = 'catppuccin'
" let g:airline_left_sep = '▶'
let g:airline_left_sep = ''
let g:airline_left_sep = ''
" let g:airline_left_alt_sep = '❯'
let g:airline_left_alt_sep = ''
" let g:airline_right_sep = '◀'
" let g:airline_right_alt_sep = '❮'
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_powerline_fonts = 1 " 使用nerdfont字符
let g:airline_section_x = '%{strftime("%H:%M")}'
let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]' " Skip display if encoding matches default (e.g., utf-8[unix])
let g:airline_section_z = '%p%% %l/%L'
