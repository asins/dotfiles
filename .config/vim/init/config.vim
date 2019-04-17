" config.vim - 正常模式下的配置
"
" Last Modified: 2018/05/30 19:20:46
"======================================================================
" vim:fdm=marker:fmr={{{,}}}


" 有 tmux 何没有的功能键超时（毫秒）{{{
if $TMUX != ''
  set ttimeoutlen=30
elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
  set ttimeoutlen=80
endif
" }}}

" 防止tmux下vim的背景色显示异常 {{{
" Refer: http://sunaku.github.io/vim-256color-bce.html

if &term =~ '256color' && $TMUX != ''
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
" }}}

" 终端下允许 ALT {{{
" ，详见：http://www.skywind.me/blog/archives/2021
" 记得设置 ttimeout （见 init-basic.vim） 和 ttimeoutlen （上面）

if has('nvim') == 0 && has('gui_running') == 0
  function! s:metacode(key)
    exec "set <M-".a:key.">=\e".a:key
  endfunc
  for i in range(10)
    call s:metacode(nr2char(char2nr('0') + i))
  endfor
  for i in range(26)
    call s:metacode(nr2char(char2nr('a') + i))
    call s:metacode(nr2char(char2nr('A') + i))
  endfor
  for c in [',', '.', '/', ';', '{', '}']
    call s:metacode(c)
  endfor
  for c in ['?', ':', '-', '_', '+', '=', "'"]
    call s:metacode(c)
  endfor
endif
" }}}

" 功能键终端码矫正 {{{

" 终端下功能键设置
function! s:key_escape(name, code)
  if has('nvim') == 0 && has('gui_running') == 0
    exec "set ".a:name."=\e".a:code
  endif
endfunc

call s:key_escape('<F1>', 'OP')
call s:key_escape('<F2>', 'OQ')
call s:key_escape('<F3>', 'OR')
call s:key_escape('<F4>', 'OS')
call s:key_escape('<S-F1>', '[1;2P')
call s:key_escape('<S-F2>', '[1;2Q')
call s:key_escape('<S-F3>', '[1;2R')
call s:key_escape('<S-F4>', '[1;2S')
call s:key_escape('<S-F5>', '[15;2~')
call s:key_escape('<S-F6>', '[17;2~')
call s:key_escape('<S-F7>', '[18;2~')
call s:key_escape('<S-F8>', '[19;2~')
call s:key_escape('<S-F9>', '[20;2~')
call s:key_escape('<S-F10>', '[21;2~')
call s:key_escape('<S-F11>', '[23;2~')
call s:key_escape('<S-F12>', '[24;2~')
" }}}

" 备份设置 {{{

" 允许备份
" set backup

" 保存时备份
" set writebackup

" 备份文件地址，统一管理
" set backupdir=~/.vim/tmp

set nobackup " 覆盖文件时不备份
set nowritebackup "文件保存后取消备份

" 禁用交换文件
set noswapfile

" 将撤销树保存到文件
if has('persistent_undo')
  set undofile
  let &undodir = g:GetCacheDir("undo")
endif
" }}}

" 配置微调 {{{

" 修正 ScureCRT/XShell 以及某些终端乱码问题，主要原因是不支持一些
" 终端控制命令，比如 cursor shaping 这类更改光标形状的 xterm 终端命令
" 会令一些支持 xterm 不完全的终端解析错误，显示为错误的字符，比如 q 字符
" 如果你确认你的终端支持，不会在一些不兼容的终端上运行该配置，可以注释
if has('nvim')
  set guicursor=
elseif (!has('gui_running')) && has('terminal') && has('patch-8.0.1200')
  let g:termcap_guicursor = &guicursor
  let g:termcap_t_RS = &t_RS
  let g:termcap_t_SH = &t_SH
  set guicursor=
  set t_RS=
  set t_SH=
endif

" }}}

" 文件类型微调 {{{
augroup InitFileTypesGroup

  " 清除同组的历史 autocommand
  autocmd!

  " 打开文件时恢复上一次光标所在位置
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \	 exe "normal! g`\"" |
        \ endif

  " 保存时自动删除多余空格
  autocmd BufWritePre * call s:StripTrailingWhitespace()

  " C/C++ 文件使用 // 作为注释
  autocmd FileType c,cpp setlocal commentstring=//\ %s

  " markdown 允许自动换行
  autocmd FileType markdown setlocal wrap

  " lisp 进行微调
  autocmd FileType lisp setlocal ts=8 sts=2 sw=2 et

  " scala 微调
  autocmd FileType scala setlocal sts=4 sw=4 noet

  " haskell 进行微调
  autocmd FileType haskell setlocal et

  " quickfix 隐藏行号
  autocmd FileType qf setlocal nonumber

  " Java Velocity 模板使用html高亮
  autocmd BufNewFile,BufRead *.vm setlocal ft=vm =html

  " NunJucks,jinja2
  autocmd BufNewFile,BufRead *.nj setlocal filetype=jinja

  " PHP Twig 模板引擎语法
  autocmd BufNewFile,BufRead *.twig set =twig

  " 在VimScript中快速查找帮助文档
  autocmd Filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>

  " 保存vimrc文件时自动加载设置
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC

  " 强制对某些扩展名的 filetype 进行纠正
  autocmd BufNewFile,BufRead *.as setlocal filetype=actionscript
  autocmd BufNewFile,BufRead *.pro setlocal filetype=prolog
  autocmd BufNewFile,BufRead *.es setlocal filetype=erlang
  autocmd BufNewFile,BufRead *.asc setlocal filetype=asciidoc
  autocmd BufNewFile,BufRead *.vl setlocal filetype=verilog

  " Java Velocity 模板使用html高亮
  autocmd BufNewFile,BufRead *.vm setlocal ft=vm =html

  " NunJucks,jinja2
  autocmd BufNewFile,BufRead *.nj setlocal filetype=jinja

  " CSS
  autocmd FileType css setlocal smartindent noexpandtab foldmethod=indent
  autocmd BufNewFile,BufRead *.less,*.scss setlocal filetype=css

  " less文件保存时自动编译为css文件
  " autocmd BufWritePost,FileWritePost *.less,*.scss,*.sass call s:CompileToCss()

augroup END
" }}}

" :Delete 删除当前文件 自定义命令 {{{
if has('user_commands')
	command! -nargs=0 Delete
				\ if delete(expand('%'))
				\|    echohl WarningMsg
				\|    echo "删除当前文件失败!"
				\|    echohl None
				\|endif
endif
" }}}

" 保存时自动删除多余空格 {{{
function! s:StripTrailingWhitespace()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  %s/$\|\s\+$//e
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
" }}}

" 编译scss/less为css 自动使用autoprefixer {{{

" 需要安装:
" npm install less node-scss postcss postcss-cli autoprefixer cssnano -g

function! s:CompileToCss()
	let current_file = expand('%:p')
	let suffix = expand('%:e')
	if(suffix == 'less')
		let cmd = 'lessc'
		let args = ''
	else
		let cmd = 'node-sass'
		let args = '--output-style expanded'
	endif
	if !executable(cmd)
		echoerr "Error: Command not found ". a:cmd . ". 'npm install -g ". a:cmd . "' to install command!"
	endif

	let filename = fnamemodify(current_file, ':r') . ".css"
	let command = '!'. cmd .' "' . current_file . '" "' . filename .'" '.args
	" 无提示模式，开发中出错无提示蛋疼
	" silent execute command
	execute command

	if !executable('postcss')
		echoerr "Error: Command not found postcss. 'npm install -g postcss postcss-cli autoprefixer cssnano' to install command!"
	endif

	execute '!postcss --use autoprefixer -b "ie >= 8, last 3 versions, > 2\%"  --use cssnano "'. filename .'" --output "'. filename .'"'
endfunction
" }}}
