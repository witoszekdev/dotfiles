" Vim compiler file
" Compiler:	TypeScript Compiler
" Maintainer:	Doug Kearns <dougkearns@gmail.com>
" Last Change:	2020 Feb 10
" Copied from https://github.com/neovim/neovim/blob/0bc323850410df4c3c1dd8fabded9d2000189270/runtime/compiler/tsc.vim#L4

if exists("current_compiler")
  finish
endif
let current_compiler = "tsc"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

" CompilerSet makeprg=npx\ tsc

CompilerSet makeprg=tsc\ --noEmit
CompilerSet errorformat=%f\ %#(%l\\,%c):\ %trror\ TS%n:\ %m,
		       \%trror\ TS%n:\ %m,
		       \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
