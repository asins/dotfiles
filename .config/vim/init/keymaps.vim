" keymaps.vim - 按键设置
"
" Last Modified: 2018/05/30 17:59:31
"======================================================================

" 保存/复制/剪切/粘贴 <Ctrl+{c,s,x}>
noremap <c-s> :update<CR>
vnoremap <c-s> <C-C>:update<CR>
inoremap <c-s> <C-O>:update<CR>

" CTRL-X 剪切
vnoremap <c-x> "+x

" CTRL-C 复制
vnoremap <c-c> "+y

" CTRL-V 粘贴
" map <c-v> "+gP
" 命令行模式
" cmap <c-v> <C-R>+
"

" N: 全选文本 {vA}
noremap vA ggVG
"

" N: 快速编辑 vimrc 文件 <Leader>e
nmap <silent> <Leader>e :edit $MYVIMRC<CR>
"

" V: 全文搜索选中的文字 <Leader>{f,F}

" 向上查找
vnoremap <silent> <Leader>f y/<c-r>=escape(@", "\\/.*$^~[]")<cr><cr>

" 向下查找
vnoremap <silent> <Leader>F y?<c-r>=escape(@", "\\/.*$^~[]")<cr><cr>
"

" N: 快速移动光标 <Ctrl+{h,l,j,k}>
"noremap <C-h> <left>
"noremap <C-j> <down>
"noremap <C-k> <up>
"noremap <C-l> <right>
"

" I: INSET模式快速移动光标 <Ctrl+{h,l,j,k,a,e}>
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>
inoremap <c-a> <home>
inoremap <c-e> <end>
"

" C: 命令模式快速移动光标 <Ctrl+{h,l,j,k,a,e}>
cnoremap <c-h> <left>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-l> <right>
cnoremap <c-a> <home>
cnoremap <c-e> <end>
"

" N: 切换 Tab <Leader>数字键
noremap <silent><leader>1 1gt<cr>
noremap <silent><leader>2 2gt<cr>
noremap <silent><leader>3 3gt<cr>
noremap <silent><leader>4 4gt<cr>
noremap <silent><leader>5 5gt<cr>
noremap <silent><leader>6 6gt<cr>
noremap <silent><leader>7 7gt<cr>
noremap <silent><leader>8 8gt<cr>
noremap <silent><leader>9 9gt<cr>
noremap <silent><leader>0 10gt<cr>
"noremap <silent><m-1> :tabn 1<cr>
"inoremap <silent><m-1> <ESC>:tabn 1<cr>

" MacVim 允许 CMD+数字键快速切换标签
if has("gui_macvim")
	set macmeta
	noremap <silent><d-1> :tabn 1<cr>
	noremap <silent><d-2> :tabn 2<cr>
	noremap <silent><d-3> :tabn 3<cr>
	noremap <silent><d-4> :tabn 4<cr>
	noremap <silent><d-5> :tabn 5<cr>
	noremap <silent><d-6> :tabn 6<cr>
	noremap <silent><d-7> :tabn 7<cr>
	noremap <silent><d-8> :tabn 8<cr>
	noremap <silent><d-9> :tabn 9<cr>
	noremap <silent><d-0> :tabn 10<cr>
	inoremap <silent><d-1> <ESC>:tabn 1<cr>
	inoremap <silent><d-2> <ESC>:tabn 2<cr>
	inoremap <silent><d-3> <ESC>:tabn 3<cr>
	inoremap <silent><d-4> <ESC>:tabn 4<cr>
	inoremap <silent><d-5> <ESC>:tabn 5<cr>
	inoremap <silent><d-6> <ESC>:tabn 6<cr>
	inoremap <silent><d-7> <ESC>:tabn 7<cr>
	inoremap <silent><d-8> <ESC>:tabn 8<cr>
	inoremap <silent><d-9> <ESC>:tabn 9<cr>
	inoremap <silent><d-0> <ESC>:tabn 10<cr>
endif
"

" N: Buffer切换 <Leader>{bn,bp}
" 插件 unimpaired 中定义了 [b, ]b 来切换缓存

" 切换到下一个Buffer
noremap <silent> <leader>bn :bn<cr>

" 切换至上一个Buffer
noremap <silent> <leader>bp :bp<cr>
"

" N: TAB 创建 关闭当前/其它 切换 移动 <Leader>{tc,tq,tn,tp,to,tl,tr}
" 其实还可以用原生的 CTRL+PageUp, CTRL+PageDown 来切换标签
noremap <silent> <leader>tc :tabnew<cr>
noremap <silent> <leader>tq :tabclose<cr>
noremap <silent> <leader>to :tabonly<cr>
noremap <silent> <leader>tn :tabnext<cr>
noremap <silent> <leader>tp :tabprev<cr>

noremap <silent> <leader>tl :call Tab_MoveLeft()<cr>
noremap <silent> <leader>tr :call Tab_MoveRight()<cr>

" 左移 tab
function! Tab_MoveLeft()
	let l:tabnr = tabpagenr() - 2
	if l:tabnr >= 0
		exec 'tabmove '.l:tabnr
	endif
endfunc

" 右移 tab
function! Tab_MoveRight()
	let l:tabnr = tabpagenr() + 1
	if l:tabnr <= tabpagenr('$')
		exec 'tabmove '.l:tabnr
	endif
endfunc

"

" Buffer窗口切换 <Ctrl + {h,j,k,l}>
" 传统的 CTRL+hjkl 移动窗口不适用于 vim 8.1 的终端模式，CTRL+hjkl 在
" bash/zsh 及带文本界面的程序中都是重要键位需要保留，不能 tnoremap 的

noremap <c-H> <c-w>h
noremap <c-L> <c-w>l
noremap <c-J> <c-w>j
noremap <c-K> <c-w>k

if has('terminal') && exists(':terminal') == 2 && has('patch-8.1.1')
	" vim 8.1 支持 termwinkey ，不需要把 terminal 切换成 normal 模式
	" 设置 termwinkey 为 CTRL 加减号（GVIM），有些终端下是 CTRL+?
	" 后面四个键位是搭配 termwinkey 的，如果 termwinkey 更改，也要改
	set termwinkey=<c-_>
	tnoremap <m-H> <c-_>h
	tnoremap <m-L> <c-_>l
	tnoremap <m-J> <c-_>j
	tnoremap <m-K> <c-_>k
	tnoremap <m-q> <c-\><c-n>
elseif has('nvim')
	" neovim 没有 termwinkey 支持，必须把 terminal 切换回 normal 模式
	tnoremap <m-H> <c-\><c-n><c-w>h
	tnoremap <m-L> <c-\><c-n><c-w>l
	tnoremap <m-J> <c-\><c-n><c-w>j
	tnoremap <m-K> <c-\><c-n><c-w>k
	tnoremap <m-q> <c-\><c-n>
endif
"

" 编译运行项目 <F10> <F5>
" 注：需先安装好skywind3000/asyncrun.vim插件
" 详细见：http://www.skywind.me/blog/archives/2084

" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

" F9 编译 C/C++ 文件
"nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" F5 运行文件
nnoremap <silent> <F5> :call ExecuteFile()<cr>

" F7 编译项目
"nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>

" F8 运行项目
"nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>

" F6 测试项目
"nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>

" 更新 cmake
"nnoremap <silent> <F4> :AsyncRun -cwd=<root> cmake . <cr>

" Windows 下支持直接打开新 cmd 窗口运行
" if has('win32') || has('win64')
" 	nnoremap <silent> <F8> :AsyncRun -cwd=<root> -mode=4 make run <cr>
" endif

" F5 运行当前文件：根据文件类型判断方法，并且输出到 quickfix 窗口
function! ExecuteFile()
	let cmd = ''
	if index(['c', 'cpp', 'rs', 'go'], &ft) >= 0
		" native 语言，把当前文件名去掉扩展名后作为可执行运行
		" 写全路径名是因为后面 -cwd=? 会改变运行时的当前路径，所以写全路径
		" 加双引号是为了避免路径中包含空格
		let cmd = '"$(VIM_FILEDIR)/$(VIM_FILENOEXT)"'
	elseif &ft == 'python'
		let $PYTHONUNBUFFERED=1 " 关闭 python 缓存，实时看到输出
		let cmd = 'python "$(VIM_FILEPATH)"'
	elseif &ft == 'javascript'
		let cmd = 'node "$(VIM_FILEPATH)"'
	elseif &ft == 'perl'
		let cmd = 'perl "$(VIM_FILEPATH)"'
	elseif &ft == 'ruby'
		let cmd = 'ruby "$(VIM_FILEPATH)"'
	elseif &ft == 'php'
		let cmd = 'php "$(VIM_FILEPATH)"'
	elseif &ft == 'lua'
		let cmd = 'lua "$(VIM_FILEPATH)"'
	elseif &ft == 'zsh'
		let cmd = 'zsh "$(VIM_FILEPATH)"'
	elseif &ft == 'ps1'
		let cmd = 'powershell -file "$(VIM_FILEPATH)"'
	elseif &ft == 'vbs'
		let cmd = 'cscript -nologo "$(VIM_FILEPATH)"'
	elseif &ft == 'sh'
		let cmd = 'bash "$(VIM_FILEPATH)"'
	else
		return
	endif
	" Windows 下打开新的窗口 (-mode=4) 运行程序，其他系统在 quickfix 运行
	" -raw: 输出内容直接显示到 quickfix window 不匹配 errorformat
	" -save=2: 保存所有改动过的文件
	" -cwd=$(VIM_FILEDIR): 运行初始化目录为文件所在目录
	if has('win32') || has('win64')
		exec 'AsyncRun -cwd=$(VIM_FILEDIR) -raw -save=2 -mode=4 '. cmd
	else
		exec 'AsyncRun -cwd=$(VIM_FILEDIR) -raw -save=2 -mode=0 '. cmd
	endif
endfunc
"

" 关闭Budder {Q}
nnoremap <silent> Q :call s:CloseSplitOrDeleteBuffer()<CR>

function! s:CloseSplitOrDeleteBuffer()
	if winnr('$') > 1
		wincmd c
	else
		execute 'bdelete'
	endif
endfunction
"

" F3 在项目目录下 Grep 光标下单词
" 默认 C/C++/Py/Js ，扩展名自己扩充 支持 rg/grep/findstr ，其他类型可以自己扩充
" 不是在当前目录 grep，而是会去到当前文件所属的项目目录 project root
" 下面进行 grep，这样能方便的对相关项目进行搜索
"----------------------------------------------------------------------
if executable('rg')
	noremap <silent><F3> :AsyncRun! -cwd=<root> rg -n --no-heading
				\ --color never -g "*.h" -g "*.c*" -g "*.py" -g "*.js" -g "*.vim"
				\ <C-R><C-W> "<root>" <cr>
elseif has('win32') || has('win64')
	noremap <silent><F3> :AsyncRun! -cwd=<root> findstr /n /s /C:"<C-R><C-W>"
				\ "\%CD\%\*.h" "\%CD\%\*.c*" "\%CD\%\*.py" "\%CD\%\*.js"
				\ "\%CD\%\*.vim"
				\ <cr>
else
	noremap <silent><F3> :AsyncRun! -cwd=<root> grep -n -s -R <C-R><C-W>
				\ --include='*.h' --include='*.c*' --include='*.py'
				\ --include='*.js' --include='*.vim'
				\ '<root>' <cr>
endif
"

" N: 关闭删除所有隐藏缓冲区 <Leader>bd
nnoremap <silent> <Leader>bd :call s:DeleteHiddenBuffers()<CR>

function! s:DeleteHiddenBuffers()
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
  echo 'delete hidden buffers success.'
endfunction
"

" N: 复制文件路径 <Ctrl+c> <Leader>c{f,F,t,h}
" 相对路径 (src/foo.txt)
nnoremap <leader>cf :let @+=expand("%") \| echo 'cb> '.@+<CR>

" 绝对路径 (/something/src/foo.txt)
nnoremap <leader>cF :let @+=expand("%:p") \| echo 'cb> '.@+<CR>
nnoremap <C-c> :let @+ = expand('%:p') \| echo 'cb> '.@+<CR>

" 文件名 (foo.txt)
nnoremap <leader>ct :let @+=expand("%:t") \| echo 'cb> '.@+<CR>

" 目录地址 (/something/src)
nnoremap <leader>ch :let @+=expand("%:p:h") \| echo 'cb> '.@+<CR>
"

" 开/关折叠 <Space>
nnoremap <silent> <Space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR>
"

" 删除一条CSS中无用空格 <Leader>co
" autocmd FileType css vnoremap <Leader>co J:s/\s*\([{:;,]\)\s*/\1/g<CR>:let @/=''<CR>
" autocmd FileType css nnoremap <Leader>co :s/\s*\([{:;,]\)\s*/\1/g<CR>:let @/=''<CR>
"

" 在VimScript中光标处关键词文档 <F1>
autocmd Filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>

