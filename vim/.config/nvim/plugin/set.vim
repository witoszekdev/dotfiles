set scrolloff=8
set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set smartcase " include capital letter in search
set ignorecase smartcase
set incsearch
" about history
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set termguicolors     " enable true colors support
set noerrorbells
set completeopt=menuone,menu,noinsert,noselect " autocomplete, don't choose automatically
set nocompatible " for vim-polyglot
"set spell spelllang=en,pl
set cursorline
set exrc " source vim.rc inside the folder vim is opened
" set nohlsearch " hide search after we're done searching
set hidden " keep opened files in the background
set autoread " reload file when changed from outside
lan mes en_US  " Change language to English
"set sessionoptions-=blank sessionoptions-=options
set sessionoptions=buffers,curdir,tabpages,winsize
set lazyredraw
set laststatus=3 " globa status bar

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

"" Redraw screen every time when focus gained
"au FocusGained * :redraw!
"
"" Set vim to save the file on focus out.
"au FocusLost * :wa

" Use Polish keyboard
"function! SetUsLayout()
    "silent set keymap=""
"endfunction
"
"function! SetPlLayout()
    "silent set keymap=polish-slash_utf-8
"endfunction
"
"autocmd InsertLeave * call SetUsLayout()
"autocmd InsertEnter * call SetPlLayout()
"set iminsert=0

" NeoVim fix for volta
let g:node_host_prog = system('volta which neovim-node-host | tr -d "\n"')
