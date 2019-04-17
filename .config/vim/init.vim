" Author: Asins - asinsimple AT gmail DOT com
"         Get latest vimrc from http://nootn.com/
" Last Modified: 2018-05-25 00:13 (+0800)
"======================================================================
" vim:fdm=marker:fmr={{{,}}}

" 防止重复加载 {{{
if get(s:, 'loaded', 0) != 0
	finish
else
	let s:loaded = 1
endif
" }}}

"----------------------------------------------------------------------
" 全局变量及函数
"----------------------------------------------------------------------
let g:mapleader = "," " 设置 <Leader>字符

" 取得本文件所在的目录 {{{
let $VIMFILES = fnamemodify(resolve(expand('<sfile>:p')), ':h')
" let $VIMFILES = fnamemodify($MYVIMRC, ':p:h') . '/.vim'

" 保证该目录存在，若不存在则新建目录
function! s:EnsureExists(path)
	if !isdirectory(expand(a:path))
		call mkdir(expand(a:path), 'p', 0755)
	endif
endfunction

" 获取缓存目录并确保存在
function! g:GetCacheDir(suffix)
	let l:dir = resolve(expand($VIMFILES . '/cache/' . a:suffix))
  call s:EnsureExists(l:dir)
  return l:dir
endfunction
" }}}

" 保证缓存目录存在
call s:EnsureExists($VIMFILES . '/cache')


" 模块加载 {{{

" 定义一个命令用来加载文件
command! -nargs=1 LoadScript exec 'so '.$VIMFILES.'/'.'<args>'

" 加载基础配置
LoadScript init/basic.vim

" 加载扩展配置
LoadScript init/config.vim

" 插件
LoadScript init/plugins.vim

" 界面样式
LoadScript init/style.vim

" 自定义按键
LoadScript init/keymaps.vim
" }}}

" 取得光标处的匹配 {{{
function! GetPatternAtCursor(pat)
	let col = col('.') - 1
	let line = getline('.')
	let ebeg = -1
	let cont = match(line, a:pat, 0)
	while (ebeg >= 0 || (0 <= cont) && (cont <= col))
		let contn = matchend(line, a:pat, cont)
		if (cont <= col) && (col < contn)
			let ebeg = match(line, a:pat, cont)
			let elen = contn - ebeg
			break
		else
			let cont = match(line, a:pat, contn)
		endif
	endwhile
	if ebeg >= 0
		return strpart(line, ebeg, elen)
	else
		return ""
	endif
endfunction
" }}}
" 切换选项开关 {{{
function! ToggleOption(optionName)
  execute 'setlocal '.a:optionName.'!'
  execute 'setlocal '.a:optionName.'?'
endfunction
" }}}

" 更新最后修改时间 {{{
function! <SID>UpdateLastMod()
	" preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")

	let n = min([10, line('$')]) " 检查头部多少行
	let timestamp = strftime('%Y-%m-%d %H:%M (%z)') " 时间格式
	let timestamp = substitute(timestamp, '%', '\%', 'g')
	let pat = substitute('\s\+Last Modified:\s*\zs.*\ze', '%', '\%', 'g')
	keepjumps silent execute '1,'.n.'s%^.*'.pat.'.*$%'.timestamp.'%e'

	" clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction
" }}}



" ========= 以下配置只设置一次 ========
if !exists('g:VimrcIsLoaded')
	" 设置文字编辑配置 {{{
	set autochdir " 根目录自动更新
	set hidden " TODO 允许在有未保存的修改时切换缓冲区
	set smartindent " 智能自动缩进
	"set showtabline=0 " 不显示Tab栏
	" set smarttab
	" }}}
	" 设置图形界面选项 {{{
	" 设置显示字体和大小
	set guifont=Monaco:h14
	" }}}
endif
" ========= 只设置一次结果 ========


" 特殊文件类型自动命令组 {{{
augroup Filetype_Specific
	autocmd!
	" * {{{
	" CSS {{{
	" 美化代码(need vim-JsBeautify plugin)
	autocmd FileType css noremap <buffer> <silent> <Leader>ff :call CSSBeautify()<cr>
	" }}}
	" JavaScript {{{
	" Vue模板使用html高亮
	" 美化代码(need vim-JsBeautify plugin)
	autocmd FileType javascript noremap <buffer> <silent> <Leader>ff :call JsBeautify()<cr>
  autocmd FileType json noremap <buffer> <silent> <Leader>ff :call JsonBeautify()<cr>
	autocmd FileType jsx noremap <buffer> <silent> <Leader>ff :call JsxBeautify()<cr>
  autocmd FileType css noremap <buffer> <silent> <Leader>ff :call CSSBeautify()<cr>
  " 只格式化选择的代码
  autocmd FileType javascript vnoremap <buffer> <silent> <Leader>ff :call RangeJsBeautify()<cr>
  autocmd FileType json vnoremap <buffer> <silent> <Leader>ff :call RangeJsonBeautify()<cr>
  autocmd FileType html vnoremap <buffer> <silent> <Leader>ff :call RangeHtmlBeautify()<cr>
  autocmd FileType css vnoremap <buffer> <silent> <Leader>ff :call RangeCSSBeautify()<cr>
	" }}}
	" HTML {{{
	" 美化代码(need vim-JsBeautify plugin)
	autocmd FileType html noremap <buffer> <silent> <Leader>ff :call HtmlBeautify()<cr>
	" }}}
	" PHP {{{
	" }}}
	" Python {{{
	" }}}
	" VimFiles {{{
	" 文本文件{{{
	" pangu.vim
	autocmd BufWritePre *.markdown,*.md,*.text,*.txt call PanGuSpacing()
	" }}}
	" 自动更新Last Modified {{{
	" autocmd BufWritePre,FileWritePre,FileAppendPre * call <SID>UpdateLastMod()
	" }}}
augroup END
" }}}

