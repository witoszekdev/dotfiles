" vim:foldmethod=marker
call plug#begin('~/.vim/plugged')
" File navigation
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'

" File tree
" NerdTREE is killing performance
"Plug 'preservim/nerdtree'
"Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'antoinemadec/FixCursorHold.nvim'

" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'
Plug 'junegunn/gv.vim'
Plug 'SidOfc/mkdx', { 'for': 'markdown' }
Plug 'preservim/vim-markdown', {'for': 'markdown'}
Plug 'pantharshit00/vim-prisma'
"Plug 'jparise/vim-graphql'
Plug 'sheerun/vim-polyglot'

" Git
Plug 'tpope/vim-fugitive' 
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-rhubarb'
Plug 'pwntester/octo.nvim'

" Code snippets
Plug 'rafamadriz/friendly-snippets'

" Code formatting
 Plug 'jiangmiao/auto-pairs'
"Plug 'alvan/vim-closetag'
Plug 'godlygeek/tabular'
" Plug 'sbdchd/neoformat'
" Plug 'tpope/vim-commentary' " `gc` => toggle comment
Plug 'scrooloose/nerdcommenter'
" Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sleuth'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'tpope/vim-surround' " cs<current_wrapper><should_be_wrapper>, ex: cs\"'
Plug 'AndrewRadev/tagalong.vim'
Plug 'dkarter/bullets.vim'

" Other
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'sudormrfbin/cheatsheet.nvim'
Plug 'liuchengxu/vim-which-key'
Plug 'tpope/vim-unimpaired'
Plug 'thaerkh/vim-workspace'
"Plug 'tpope/vim-obsession'
Plug 'rbgrouleff/bclose.vim'
Plug 'vim-test/vim-test'
Plug 'wakatime/vim-wakatime'
Plug 'romainl/vim-qf' " better quickfixlist
Plug 'wsdjeg/vim-fetch' " open files with line numebr provided

" Theme
Plug 'ayu-theme/ayu-vim'
Plug 'gruvbox-community/gruvbox'
"Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lambdalisue/battery.vim'

call plug#end()

lua require("taniotanio7")

let mapleader = " "

" Disable that freaking Ex mode
map q: <Nop>
nnoremap Q <nop>
command! -nargs=0 W :w 
nnoremap <silent> <A-w> :Bclose<CR>

nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

" Use :close instead of :q
cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>

" Close all buffers except current one
nnoremap <leader>qa :%bd\|e#\|bd#<CR>

" Go to the end of tag
nnoremap ]t vit<C-c>
nnoremap [t vito<C-c>

"Telescope
nnoremap <C-p> :Telescope find_files<CR>
nnoremap <S-C-p> :Telescope find_files hidden=true<CR>
nnoremap <leader>pf :Telescope live_grep<CR>
nnoremap <leader>po :Telescope buffers<CR>
nnoremap <leader>h :Telescope help_tags<CR>
nnoremap <leader>u :UndotreeShow<CR>
" Fugitive
let g:fugitive_pty = 0 " Fix for Fugitve + lint-staged
nnoremap <leader>gh :GV<CR>
nnoremap <leader>ghf :GV!<CR>
nnoremap <leader>gs :Git<CR>
command! -nargs=0 Gp :Git push
command! -nargs=0 Gpf :Git push --force-with-lease
command! -nargs=1 Gco :Git checkout <f-args>
command! -nargs=1 Gcb :Git checkout -b <f-args>
command! -nargs=0 Gl :Git autopull
" note: autopull is defined in gitconfig

" Octo
nnoremap <leader>gpr :Octo pr list

" Fern
nnoremap <leader>pv :Fern . -reveal=% -drawer<CR>
nnoremap <leader>Pv :Fern %:h -reveal=% -drawer<CR>
" Terminal
nnoremap <leader>t <C-w>v:term<CR>
tnoremap <Esc> <C-\><C-n>
" Use CTRL+J/K to operate in Quickfix List
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
" paste without removing yank from history
vnoremap <leader>p "_dP
" save to system clipboard
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG<C-o>
" move selected line of code
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" resize windows
nnoremap <leader>= :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
" buffer shortcuts
" use []b instead from vim-unimpaired
"nnoremap <leader>[ :bprev<CR>
"nnoremap <leader>] :bnext<CR>
nnoremap <leader>bc :bd<CR>
"nnoremap <leader>1 :b1<CR>
"nnoremap <leader>2 :b2<CR>
"nnoremap <leader>3 :b3<CR>
"nnoremap <leader>4 :b4<CR>
"nnoremap <leader>5 :b5<CR>
"nnoremap <leader>6 :b6<CR>
"nnoremap <leader>7 :b7<CR>
"nnoremap <leader>8 :b8<CR>
"nnoremap <leader>9 :b9<CR>
" show keys when started with leader but didn't complete
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
" quick window navigation
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Temp fix - map .js files to .jsx file format
augroup filetype_jsx
    autocmd!
    autocmd FileType javascript set filetype=javascriptreact
augroup END

" Copy path of current file
" `@*=` assigns the result to the clipboard
command! -nargs=0 CopyPath let @*=expand('%') 
command! -nargs=0 CopyPathAbsolute let @*=expand('%:p') 
command! -nargs=0 CopyPathLine let @*=join([expand('%'),  line(".")], ':') 

" Make Sure that Vim returns to the same line when we reopen a file"
augroup line_return
    au!
    au BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \ execute 'normal! g`"zvzz' |
                \ endif
augroup END

" Ignore terminals and quickfixlist when cycling through buffers

"au BufEnter * if &buftype == 'terminal' | startinsert | else | stopinsert | endif
    "function! PrevBufferTab()
      "bprev
      "if &buftype == 'terminal' || &buftype == 'quickfix'
        "bprev
      "endif
    "endfunction
    "function! NextBufferTab()
      "bnext
      "if &buftype == 'terminal' || &buftype == 'quickfix'
"
        "bnext
      "endif
    "endfunction
"
"nnoremap [b :call PrevBufferTab()<CR>
"nnoremap ]b :call NextBufferTab()<CR>


" vim-test config
let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'neovim',
  \ 'suite':   'kitty',
\}

" set TypeScript compiler options
  autocmd FileType typescript let &makeprg='tsc --noEmit'
  autocmd FileType typescriptreact let &makeprg='tsc --noEmit'
