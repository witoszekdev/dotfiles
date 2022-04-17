set colorcolumn=80
set signcolumn=yes
"colorscheme ayu
"let ayucolor="dark"   " for dark version of theme

" Gruvbox
let g:gruvbox_contrast_dark = "hard"
colorscheme gruvbox
set background=dark

" IndentLine
let g:indentLine_car_list = ['|', '¦', '┆', '┊']
let g:indentLine_fileTypeExclude = ['json', 'markdown']

" Airline
"let g:airline_theme = 'ayu_dark'
let g:airline_theme = 'base16_gruvbox_dark_hard'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_detect_spell=0
let g:airline#extensions#battery#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#keymap#enabled = 0
"let g:airline#extensions#keymap#short_codes = {'polish-slash_utf-8': '⠀'}
"let g:airline#extensions#keymap#label = ""
let g:airline#extensions#tagbar#enabled = 0
call airline#parts#define_minwidth('percentage', 175)
call airline#parts#define_minwidth('fileencoding', 175)
call airline#parts#define_minwidth('line number', 175)
