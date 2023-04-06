" Copied from https://github.com/neovim/neovim/blob/0bc323850410df4c3c1dd8fabded9d2000189270/runtime/compiler/eslint.vim

if exists("current_compiler")
  finish
endif
let current_compiler = "nextjs"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=npx\ next\ lint\ --dir\ src\ --format\ compact
CompilerSet errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m,%-G%.%#
