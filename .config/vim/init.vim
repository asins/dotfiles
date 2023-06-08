" Author: Asins - asinsimple AT gmail DOT com
"         Get latest vimrc from http://nootn.com/
" Last Modified: 2023-06-08 17:15 (+0800)
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


"============================
" 加载基础配置
"============================
" 基础设置 {{{
" 禁用 vi 兼容模式
set nocompatible

" 设置 Backspace 键模式
set bs=eol,start,indent

" 自动缩进
set autoindent

" 打开 C/C++ 语言缩进优化
set cindent

" 允许在所有模式下使用鼠标
set mouse=a

" 键入时隐藏鼠标
set mousehide

" Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
set winaltkeys=no

" 关闭自动换行
set nowrap

" 设置缩进宽度
set shiftwidth=2

" 设置 TAB 宽度
set tabstop=2

" 键入Tab时转换成空格
set expandtab

" 如果后面设置了 expandtab 那么展开 tab 为多少字符
set softtabstop=2

" Vim自身命令行模式智能补全
set wildmenu

" 打开功能键超时检测（终端下功能键为一串 ESC 开头的字符串）
set ttimeout

" 功能键超时检测 50 毫秒
set ttimeoutlen=50

" 显示光标位置
set ruler
" }}}


" 搜索设置 {{{

" 搜索到文件两端时不重新搜索
set nowrapscan

" 搜索时忽略大小写
set ignorecase

" 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写字母
set smartcase

" 高亮搜索内容
set hlsearch

" 查找输入时动态增量显示查找结果
set incsearch
" }}}

" 编码设置 {{{
if has('multi_byte')

  " 解决console输出乱码
  language messages zh_CN.UTF-8

  " 显示中文帮助
  set helplang=cn

  " 内部工作编码
  set encoding=utf-8

  " 文件默认编码
  set fileencoding=utf-8

  " 打开文件时自动尝试下面顺序的编码
  set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1
endif
" }}}

" 允许 Vim 自带脚本根据文件类型自动设置缩进等 {{{
if has('autocmd')
  filetype plugin indent on
endif
" }}}


" 语法高亮设置 {{{
if has('syntax')
  syntax enable
  syntax on
endif
" }}}

" 其他设置 {{{

" 显示匹配的括号
set showmatch

" 显示括号匹配的时间
set matchtime=2

" 显示最后一行
set display=lastline

" 允许下方显示目录
set wildmenu

" 延迟绘制（提升性能）
set lazyredraw

" 错误格式
set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m

" 设置分隔符可视
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<

" 设置光标之下的最少行数
set scrolloff=2

" 保存操作记录和状态信息
set viminfo=%,'1000,<50,s20,h,n$VIMFILES/cache/viminfo

" 设置 tags：当前文件所在目录往上向根目录搜索直到碰到 .tags 文件
" 或者 Vim 当前目录包含 .tags 文件
set tags=./.tags;,.tags

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m

" 合并两行中文时，不在中间加空格
set formatoptions+=B

" 文件换行符，默认使用 unix 换行符
set fileformats=unix,dos,mac
" }}}

" 设置代码折叠 {{{
" zc 关闭当前打开的折叠
" zo 打开当前的折叠
" zm 关闭所有折叠
" zM 关闭所有折叠及其嵌套的折叠
" zr 打开所有折叠
" zR 打开所有折叠及其嵌套的折叠
" zd 删除当前折叠
" zE 删除所有折叠
" zj 移动至下一个折叠
" zk 移动至上一个折叠
" zn 禁用折叠
" zN 启用折叠
" 设置折叠层数为
"     manual  手工定义折叠
"     indent  更多的缩进表示更高级别的折叠
"     expr    用表达式来定义折叠
"     syntax  用语法高亮来定义折叠
"     diff    对没有更改的文本进行折叠
"     marker  对文中的标志折叠
if has('folding')
  " 允许代码折叠
  set foldenable

  " 代码折叠默认使用缩进
  set foldmethod=syntax

  " 默认打开所有缩进
  set foldlevel=99
endif
" }}}

" 文件搜索和补全时忽略下面扩展名 {{{
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class

set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz    " MacOSX/Linux
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android
set wildignore+=*/node_modules/** " Ignore Node.js modules
" }}}



"============================
" 加载扩展配置
"============================
" 没有的功能键超时（毫秒）{{{
if &ttimeoutlen > 80 || &ttimeoutlen <= 0
  set ttimeoutlen=80
endif
" }}}

" 终端下允许 ALT {{{
" ，详见：http://www.skywind.me/blog/archives/2021
" 记得设置 ttimeout 和 ttimeoutlen

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
" function! s:StripTrailingWhitespace()
"   " Preparation: save last search, and cursor position.
"   let _s=@/
"   let l = line(".")
"   let c = col(".")
"   " do the business:
"   %s/\n$\|\s\+$//e
"   " clean up: restore previous search history, and cursor position
"   let @/=_s
"   call cursor(l, c)
" endfunction
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






augroup MyPluginSetup
  autocmd!
augroup END

" 自动安装 vim-plug {{{
if empty(glob($VIMFILES.'/autoload/plug.vim'))
  silent execute('!curl -fLo '. $VIMFILES .'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
endif
" }}}

" 插件初始化开始
call plug#begin($VIMFILES.'/plugged')
"----------------------------------------------------------------------



" 异步执行脚本
Plug 'skywind3000/asyncrun.vim'

" 文件浏览器，代替 netrw {{{
Plug 'justinmk/vim-dirvish'

" 自动排序并隐藏文件，同时定位到相关文件
" 这个排序函数可以将目录排在前面，文件排在后面，并且按照字母顺序排序，比默认的纯按照字母排序更友好点。
function! s:setup_dirvish()
  if &buftype != 'nofile' && &filetype != 'dirvish'
    return
  endif
  if has('nvim')
    return
  endif
  " 取得光标所在行的文本（当前选中的文件名）
  let text = getline('.')
  if ! get(g:, 'dirvish_hide_visible', 0)
    exec 'silent keeppatterns g@\v[\/]\.[^\/]+[\/]?$@d _'
  endif
  " 排序文件名
  exec 'sort ,^.*[\/],'
  let name = '^' . escape(text, '.*[]~\') . '[/*|@=|\\*]\=\%($\|\s\+\)'
  " 定位到之前光标处的文件
  call search(name, 'wc')
  noremap <silent><buffer> ~ :Dirvish ~<cr>
  noremap <buffer> % :e %
endfunc

augroup MyPluginSetup
  autocmd FileType dirvish call s:setup_dirvish()
augroup END
" }}}

" " ale 动态语法检查 {{{
" Plug 'w0rp/ale'
"
" " 设定延迟和提示信息
" let g:ale_echo_delay = 20
" let g:ale_echo_msg_format = '[%linter%] %code: %%s'
" let g:ale_lint_delay = 500
" let g:ale_completion_delay = 500
"
" " 设定检测的时机：normal 模式文字改变，或者离开 insert模式
" " 禁用默认 INSERT 模式下改变文字也触发的设置，太频繁外，还会让补全窗闪烁
" let g:ale_lint_on_text_changed = 'normal'
" let g:ale_lint_on_insert_leave = 1
"
" let g:ale_sign_error = '✗'
" let g:ale_sign_warning = '⚡'
"
" " 在 linux/mac 下降低语法检查程序的进程优先级（不要卡到前台进程）
" if has('win32') == 0 && has('win64') == 0 && has('win32unix') == 0
"   let g:ale_command_wrapper = 'nice -n5'
" endif
"
" " 允许 airline 集成
" let g:airline#extensions#ale#enabled = 1
"
" " 编辑不同文件类型需要的语法检查器
" let g:ale_linters = {
"       \ 'c': ['gcc', 'cppcheck'],
"       \ 'cpp': ['gcc', 'cppcheck'],
"       \ 'python': ['flake8', 'pylint'],
"       \ 'lua': ['luac'],
"       \ 'go': ['go build', 'gofmt'],
"       \ 'java': ['javac'],
"       \ 'javascript': ['eslint'],
"       \ }
"
" let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
" let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
" let g:ale_c_cppcheck_options = ''
" let g:ale_cpp_cppcheck_options = ''
"
" let g:ale_linters.text = ['textlint', 'write-good', 'languagetool']
"
" " 如果没有 gcc 只有 clang 时（FreeBSD）
" if executable('gcc') == 0 && executable('clang')
"   let g:ale_linters.c += ['clang']
"   let g:ale_linters.cpp += ['clang']
" endif
" " }}}

" 一次性安装一大堆 colorscheme
Plug 'flazz/vim-colorschemes'

" 代码注释 {{{
Plug 'tomtom/tcomment_vim'
" Plug 'scrooloose/nerdcommenter'
" let NERDMenuMode = 0
" " 在注释符后加入空格
" let g:NERDSpaceDelims = 1
" " 使用紧凑语法美化多行注释
" let g:NERDCompactSexyComs = 1
" let g:NERDCommentEmptyLines = 1
" let g:NERDTrimTrailingWhitespace = 1
" <Leader>ca 在可选的注释方式之间切换，比如C/C++ 的块注释/* */和行注释//
" <Leader>cc 注释当前行
" <Leader>c<space> 切换注释
" <Leader>cs 以”性感”的方式注释
" <Leader>cA 在当前行尾添加注释符，并进入Insert模式
" <Leader>cu 取消注释
" <Leader>cm 添加块注释
" }}}

" 代码缩进可视化 {{{
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1
" 不向全局添加热键
" let g:indent_guides_default_mapping = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
" }}}

" 在状态行显示的信息 {{{
"set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %c:%l/%L%)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

let g:airline_powerline_fonts = 0
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_exclude_preview = 1
let g:airline_section_b = '%n'
let g:airline_theme='deus'
" let g:airline#extensions#branch#enabled = 0
" let g:airline#extensions#syntastic#enabled = 0
" let g:airline#extensions#fugitiveline#enabled = 0
" let g:airline#extensions#csv#enabled = 0
" let g:airline#extensions#vimagit#enabled = 0

" 修改排版方式
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'x', 'y', 'z']
      \ ]
let g:airline_section_c = '%<%n %F'
let g:airline_section_x = '%{strlen(&ft) ? &ft : "Noft"}%{&bomb ? " BOM" : ""}'
let g:airline_section_y = '%{&fileformat} %{(&fenc == "" ? &enc : &fenc)}'
let g:airline_section_z = '%2l:%-1v/%L'

" 显示 Mode 的简称
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'VL',
      \ '' : 'VB',
      \ 's'  : 'S',
      \ 'S'  : 'SL',
      \ '' : 'SB',
      \ }
" }}}

" NERDTree 文件系统浏览 {{{
Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind'] }
" 指定书签文件
let NERDTreeBookmarksFile = g:GetCacheDir('').'/NERDTreeBookmarks'
" 排除 . .. 文件
let NERDTreeIgnore = [ '\.DS_Store', '\.(git|svn|hg)$', '\.(swo|swp)$', '^\.\.?$' ]
let g:NERDTreeMinimalUI = 1
" 同时改变当前工作目录
let g:NERDTreeChDirMode = 2
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeShowBookmarks = 1

map <s-F2> :NERDTree<CR>
map <F2> :NERDTreeToggle<CR>
map! <F2> <Esc>:NERDTreeToggle<CR>
" }}}






" 语法提示 {{{
" Plug 'neoclide/coc.nvim'
" }}}

" 语法检测 syntastic {{{
" Plug 'scrooloose/syntastic', { 'for': ['php', 'javascript', 'css', 'less', 'scss'] }
" let g:syntastic_always_populate_loc_list = 1
" " 自动打开Location List
" let g:syntastic_auto_loc_list = 1
" " 打开文件时自动进行检查
" let g:syntastic_check_on_open = 1
" " 进行实时检查，如果觉得卡顿，将下面的选项置为1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_error_symbol = '✗'
" let g:syntastic_warning_symbol = '⚠'
" let g:syntastic_javascript_checkers   = ['eslint']
" "高亮错误
" let g:syntastic_enable_highlighting=1
" "关闭syntastic语法检查
" nnoremap <silent> <Leader>sc :SyntasticToggleMode<CR>
" }}}

" 快速标记跳转 {{{
" Plug 'kshenoy/vim-signature'
"  mx           切换显示标记 'x'，并在啊左侧列中呈现
"  dmx          删除标记 'x',x选值范围a-zA-Z
"
"  m,           Place the next available mark
"  m.           If no mark on line, place the next available mark. Otherwise, remove (first) existing mark.
"  m-           Delete all marks from the current line
"  m<Space>     Delete all marks from the current buffer
"  ]`           Jump to next mark
"  [`           Jump to prev mark
"  ]'           Jump to start of next line containing a mark
"  ['           Jump to start of prev line containing a mark
"  `]           Jump by alphabetical order to next mark
"  `[           Jump by alphabetical order to prev mark
"  ']           Jump by alphabetical order to start of next line having a mark
"  '[           Jump by alphabetical order to start of prev line having a mark
"  m/           Open location list and display marks from current buffer
"
"  m[0-9]       Toggle the corresponding marker !@#$%^&*()
"  m<S-[0-9]>   Remove all markers of the same type
"  ]-           Jump to next line having a marker of the same type
"  [-           Jump to prev line having a marker of the same type
"  ]=           Jump to next line having a marker of any type
"  [=           Jump to prev line having a marker of any type
"  m?           Open location list and display markers from current buffer
"  m<BS>        Remove all markers

"  '.          最后一次变更的地方
"  ''          跳回来的地方(最近两个位置跳转)
" }}}

" 给各种 tags 标记不同的颜色 {{{
Plug 'dimasg/vim-mark'
" 高亮光标下的单词
nmap <silent> <Leader>hl <plug>MarkSet
" 高亮选中的文本
vmap <silent> <Leader>hl <plug>MarkSet
" 删除光标所在单词，或清除所有高亮
nmap <silent> <Leader>hh <plug>MarkAllClear
" 输入正则规则来高亮匹配文本
nmap <silent> <Leader>hr <plug>MarkRegex
vmap <silent> <Leader>hr <plug>MarkRegex
"
" ,# / ,* 上下搜索高亮文本，之后可直接输入 # 或 * 继续查找该高亮文本
" <Leader>* 当前MarkWord的下一个     <Leader># 当前MarkWord的上一个
" <Leader>/ 所有MarkWords的下一个    <Leader>? 所有MarkWords的上一个
" }}}

" Quickfix的各种操作 {{{
Plug 'romainl/vim-qf'
let g:qf_loclist_window_bottom = 0
" 显示与否
nmap <F4> <Plug>(qf_loc_toggle_stay)
" }}}

" HTML/CSS快速输入 {{{
Plug 'mattn/emmet-vim', { 'for': [ 'css', 'html', 'less', 'sass', 'scss', 'xml' ] }
let g:user_emmet_settings = {
      \   'variables' : {
        \       'lang' : 'zh-cn',
        \   },
        \}
" 常用命令可看：http://nootn.com/blog/Tool/23/
" <c-y>m  合并多行
" }}}

" 高亮显示光标处配对的HTML/XML标签 {{{
Plug 'Valloric/MatchTagAlways', { 'for': [ 'html', 'xml' ] }
" }}}

" HTML/XML闭合标签间跳转 MatchIt {{{
Plug 'benjifisher/matchit.zip', { 'for': ['html', 'xml'] }
" 映射     描述
" %        正向匹配
" g%       反向匹配
" [%       定位块首
" ]%       定位块尾
" }}}

" [ ] 键的功能大全 {{{
Plug 'asins/vim-unimpaired'
let g:unimpaired_disabled_pasting_enhancement = 1
" N: 移动光标所在行
nmap <s-up> <Plug>unimpairedMoveUp
nmap <s-down> <Plug>unimpairedMoveDown
" V: 移动选中的行
xmap <s-up> <Plug>unimpairedMoveSelectionUp
xmap <s-down> <Plug>unimpairedMoveSelectionDown
" ]ow [ow wrap/nowrap切换，文本是否自动换行
" ]p [p  在行前/后粘贴
" [on ]on 开/关行号
" [or ]or 开/关相对行号
" [b, ]b 来切换缓存
" yo yO 在行前/后进入插入模式（无视缩进、注释继承）与O键不同
" }}}

" clever-f {{{
Plug 'rhysd/clever-f.vim'
let g:clever_f_across_no_line = 1
" }}}

" JS语法、缩进支持 {{{
" Plug 'mxw/vim-jsx'

Plug 'pangloss/vim-javascript', { 'for': [ 'javascript', 'typescript' ] }
" 允许高亮JSDocs注释语法
let g:javascript_plugin_jsdoc = 1

Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/es.next.syntax.vim', { 'for': [ 'javascript' ] }
Plug 'othree/yajs.vim', { 'for': [ 'javascript' ] }
let g:used_javascript_libs = 'jquery,vue'
" }}}

" TypeScript语法支持 {{{
Plug 'leafgarland/typescript-vim', { 'for': [ 'typescript' ] }
" 编译器及参数，执行:make可进行编译
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
" }}}

" Vue语法 {{{
Plug 'posva/vim-vue'
" }}}

" Rust语法 {{{
Plug 'rust-lang/rust.vim'
" }}}

" 打开光标下的链接 <Leader>ur {{{
" Plug 'tyru/open-browser.vim'
" nmap <silent> <Leader>ur :OpenBrowser <C-U>call GetPatternAtCursor('\v%(https?|ftp)://[^]''" \t\r\n>*。，\`)]*')
" }}}

" 语法/高亮支持 {{{
Plug 'othree/html5.vim', { 'for': ['html'] }
Plug 'othree/html5-syntax.vim', { 'for': ['html'] }
" Nginx语法
Plug 'chr4/nginx.vim', { 'for': [ 'nginx' ] }
" Markdown 语法
Plug 'tpope/vim-markdown', { 'for': [ 'markdown' ] }
" fish shell 语法
Plug 'dag/vim-fish'
" Docker 语法
Plug 'ekalinin/Dockerfile.vim'
" toml 语法
Plug 'cespare/vim-toml', { 'branch': 'main' }
" Log 语法
Plug 'mtdl9/vim-log-highlighting'
" }}}

" Mru 打开历史文件列表 {{{
" Plug 'yegappan/mru'
" let MRU_File = g:GetCacheDir("mru_file")
" nmap <Leader>bb :MRU<CR>
" }}}

" Buffer列表管理 {{{
" Plug 'jlanzarotta/bufexplorer'
" let g:bufExplorerShowRelativePath=1 " 显示相当地址
" let g:bufExplorerDefaultHelp = 0  " 不显示默认帮助信息
" let g:bufExplorerFindActive = 0
" <Leader>be 打开历史文件列表
" <Leader>bs 水平新建历史文件列表窗口
" <Leader>bv 垂直新建历史文件列表
" }}}

" LeaderF {{{
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

" CTRL+p 打开文件模糊匹配
let g:Lf_ShortcutF = '<c-p>'

" <Leader>bb 打开 buffer 模糊匹配
let g:Lf_ShortcutB = '<Leader>bb'

" <Leader>bm 打开最近使用的文件 MRU，进行模糊匹配
noremap <silent> <Leader>bm :LeaderfMru<cr>

" <Leader>bf 打开函数列表，按 i 进入模糊匹配，ESC 退出
noremap <silent> <Leader>bf :LeaderfFunction!<cr>

" <Leader>bi 打开 tag 列表，i 进入模糊匹配，ESC退出
noremap <silent> <Leader>bi :LeaderfBufTag!<cr>

" <Leader>bb 打开 buffer 列表进行模糊匹配
noremap <silent> <Leader>bb :LeaderfBuffer<cr>

" 全局 tags 模糊匹配
noremap <silen> <Leader>bt :LeaderfTag<cr>

" 最大历史文件保存 2048 个
let g:Lf_MruMaxFiles = 2048

" ui 定制
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

" 如何识别项目目录，从当前文件目录向父目录递归知道碰到下面的文件/目录
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = g:GetCacheDir('leaderf')

" 显示绝对路径
let g:Lf_ShowRelativePath = 0

" 隐藏帮助
let g:Lf_HideHelp = 1

" 模糊匹配忽略扩展名
let g:Lf_WildIgnore = {
      \ 'dir': ['.svn','.git','.hg'],
      \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
      \ }

" MRU 文件忽略扩展名
let g:Lf_MruFileExclude = ['*.so', '*.exe', '*.py[co]', '*.sw?', '~$*', '*.bak', '*.tmp', '*.dll']
let g:Lf_StlColorscheme = 'powerline'

" 禁用 function/buftag 的预览功能，可以手动用 p 预览
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

" 使用 ESC 键可以直接退出 leaderf 的 normal 模式
let g:Lf_NormalMap = {
      \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
      \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<cr>']],
      \ "Mru": [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<cr>']],
      \ "Tag": [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<cr>']],
      \ "BufTag": [["<ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<cr>']],
      \ "Function": [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<cr>']],
      \ }
" }}}

" 自动实例配对符号 delimitMate {{{
" Plug 'Raimondi/delimitMate'
" let delimitMate_expand_cr = 2
" let delimitMate_expand_space = 1 " {|} => { | }
" }}}

" 中文排版自动规范化 {{{
Plug 'hotoo/pangu.vim', { 'on': [ 'Pangu', 'PanguEnable', 'PanguDisable' ], 'for': [ 'markdown', 'text' ] }
" }}}

" 文件重命令 {{{
Plug 'inkarkat/renamer.vim'
" :Renamer 将当前文件所在文件夹下的内容显示在一个新窗口
" :Ren 开始重命名
" }}}

" Git操作 {{{
Plug 'tpope/vim-fugitive'

augroup fugitiveSettings
  autocmd!
  autocmd FileType gitcommit setlocal nolist
  autocmd BufReadPost fugitive://* setlocal bufhidden=delete
augroup END

function! ReviewLastCommit()
  if exists('b:git_dir')
    Gtabedit HEAD^{}
    nnoremap <buffer> <silent> q :<C-U>bdelete<CR>
  else
    echo 'No git a git repository:' expand('%:p')
  endif
endfunction

nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <silent> <leader>gE :Gedit<space>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gR :Gread<space>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gW :Gwrite!<CR>
nnoremap <silent> <leader>gq :Gwq<CR>
nnoremap <silent> <leader>gQ :Gwq!<CR>
nnoremap <silent> <leader>g` :call ReviewLastCommit()<CR>
" }}}

" 代码美化 {{{
" Plug 'maksimr/vim-jsbeautify', { 'for': [ 'html', 'xml', 'javascript', 'json', 'css', 'less', 'scss'], 'do': 'npm install --registry=http://registry.npm.alibaba-inc.com' }
" let g:editorconfig_Beautifier = resolve(expand($VIMFILES. '/jsbeautify.editorconfig'))
" }}}

" 光标选择功能 <C-{n,p,x}> {{{
Plug 'terryma/vim-multiple-cursors'
" <c-n> 选中下一个
" <c-p> 回退
" <C-x> 跳过
" <Esc> 退出
" }}}

" 保存时自动删除多余空格 {{{
Plug 'bronson/vim-trailing-whitespace'
map <leader><space> :FixWhitespace<cr>
" }}}

" css中的颜色显示
Plug 'ap/vim-css-color'

" 自动创建目录
Plug 'travisjeffery/vim-auto-mkdir'

" Vim 中文文档计划
Plug 'asins/vimcdoc'

" 关键词字典 <ctrl-x>_<ctrl-k> 打开提示
Plug 'asins/vim-dict'

"----------------------------------------------------------------------
" 插件初始化完成
call plug#end()









"============================
" 界面样式
"============================
"----------------------------------------------------------------------
" 显示设置
"----------------------------------------------------------------------

" 总是显示状态栏
set laststatus=2

" 总是显示行号
set number

" 启动的时候不显示那个援助乌干达儿童的提示
set shortmess=atI

" 总是显示侧边栏（用于显示 mark/gitdiff/诊断信息）
set signcolumn=yes

" 至少2个Tab时才显示标签栏
set showtabline=1

" 设置显示制表符等隐藏字符
set list

" 右下角显示命令
set showcmd

" 插入模式在状态栏下面显示 -- INSERT --，
" 先注释掉，默认已经为真了，如果这里再设置一遍会影响 echodoc 插件
" set showmode

" 水平切割窗口时，默认在右边显示新窗口
set splitright


"----------------------------------------------------------------------
" 颜色主题：色彩文件位于 colors 目录中
"----------------------------------------------------------------------

" 设置黑色背景
set background=dark

" 允许 256 色
set t_Co=256

" 设置颜色主题，会在所有 runtimepaths 的 colors 目录寻找同名配置
colorscheme molokai


"----------------------------------------------------------------------
" 状态栏设置
"----------------------------------------------------------------------
set statusline=                                 " 清空状态了
set statusline+=\ %F                            " 文件名
set statusline+=\ [%1*%M%*%n%R%H]               " buffer 编号和状态
set statusline+=%=                              " 向右对齐
set statusline+=\ %y                            " 文件类型

" 最右边显示文件编码和行号等信息，并且固定在一个 group 中，优先占位
set statusline+=\ %0(%{&fileformat}\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %v:%l/%L%)


"----------------------------------------------------------------------
" 更改样式
"----------------------------------------------------------------------

" 更清晰的错误标注：默认一片红色背景，语法高亮都被搞没了
" 只显示红色或者蓝色下划线或者波浪线
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! clear SpellLocal
if has('gui_running')
  hi! SpellBad gui=undercurl guisp=red
  hi! SpellCap gui=undercurl guisp=blue
  hi! SpellRare gui=undercurl guisp=magenta
  hi! SpellRare gui=undercurl guisp=cyan
else
  hi! SpellBad term=standout ctermfg=1 term=underline cterm=underline
  hi! SpellCap term=underline cterm=underline
  hi! SpellRare term=underline cterm=underline
  hi! SpellLocal term=underline cterm=underline
endif

" 去掉 sign column 的白色背景
hi! SignColumn guibg=NONE ctermbg=NONE

" 修改行号为浅灰色，默认主题的黄色行号很难看，换主题可以仿照修改
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE
      \ gui=NONE guifg=DarkGrey guibg=NONE

" 修正补全目录的色彩：默认太难看
hi! Pmenu guibg=gray guifg=black ctermbg=gray ctermfg=black
hi! PmenuSel guibg=gray guifg=brown ctermbg=brown ctermfg=gray


"----------------------------------------------------------------------
" 终端设置，隐藏行号和侧边栏
"----------------------------------------------------------------------
if has('terminal') && exists(':terminal') == 2
  if exists('##TerminalOpen')
    augroup VimUnixTerminalGroup
      au!
      au TerminalOpen * setlocal nonumber signcolumn=no
    augroup END
  endif
endif


"----------------------------------------------------------------------
" quickfix 设置，隐藏行号
"----------------------------------------------------------------------
augroup VimInitStyle
  au!
  au FileType qf setlocal nonumber
augroup END


"----------------------------------------------------------------------
" 标签栏文字风格：默认为零，GUI 模式下空间大，按风格 3显示
" 0: filename.txt
" 2: 1 - filename.txt
" 3: [1] filename.txt
"----------------------------------------------------------------------
if has('gui_running')
  let g:config_vim_tab_style = 3
endif


"----------------------------------------------------------------------
" 终端下的 tabline
"----------------------------------------------------------------------
function! Vim_NeatTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{Vim_NeatTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999XX'
  endif

  return s
endfunc


"----------------------------------------------------------------------
" 需要显示到标签上的文件名
"----------------------------------------------------------------------
function! Vim_NeatBuffer(bufnr, fullname)
  let l:name = bufname(a:bufnr)
  if getbufvar(a:bufnr, '&modifiable')
    if l:name == ''
      return '[No Name]'
    else
      if a:fullname
        return fnamemodify(l:name, ':p')
      else
        let aname = fnamemodify(l:name, ':p')
        let sname = fnamemodify(aname, ':t')
        if sname == ''
          let test = fnamemodify(aname, ':h:t')
          if test != ''
            return '<'. test . '>'
          endif
        endif
        return sname
      endif
    endif
  else
    let l:buftype = getbufvar(a:bufnr, '&buftype')
    if l:buftype == 'quickfix'
      return '[Quickfix]'
    elseif l:name != ''
      if a:fullname
        return '-'.fnamemodify(l:name, ':p')
      else
        return '-'.fnamemodify(l:name, ':t')
      endif
    else
    endif
    return '[No Name]'
  endif
endfunc


"----------------------------------------------------------------------
" 标签栏文字，使用 [1] filename 的模式
"----------------------------------------------------------------------
function! Vim_NeatTabLabel(n)
  let l:buflist = tabpagebuflist(a:n)
  let l:winnr = tabpagewinnr(a:n)
  let l:bufnr = l:buflist[l:winnr - 1]
  let l:fname = Vim_NeatBuffer(l:bufnr, 0)
  let l:num = a:n
  let style = get(g:, 'config_vim_tab_style', 0)
  if style == 0
    return l:fname
  elseif style == 1
    return "[".l:num."] ".l:fname
  elseif style == 2
    return "".l:num." - ".l:fname
  endif
  if getbufvar(l:bufnr, '&modified')
    return "[".l:num."] ".l:fname." +"
  endif
  return "[".l:num."] ".l:fname
endfunc


"----------------------------------------------------------------------
" GUI 下的标签文字，使用 [1] filename 的模式
"----------------------------------------------------------------------
function! Vim_NeatGuiTabLabel()
  let l:num = v:lnum
  let l:buflist = tabpagebuflist(l:num)
  let l:winnr = tabpagewinnr(l:num)
  let l:bufnr = l:buflist[l:winnr - 1]
  let l:fname = Vim_NeatBuffer(l:bufnr, 0)
  let style = get(g:, 'config_vim_tab_style', 0)
  if style == 0
    return l:fname
  elseif style == 1
    return "[".l:num."] ".l:fname
  elseif style == 2
    return "".l:num." - ".l:fname
  endif
  if getbufvar(l:bufnr, '&modified')
    return "[".l:num."] ".l:fname." +"
  endif
  return "[".l:num."] ".l:fname
endfunc



"----------------------------------------------------------------------
" 设置 GUI 标签的 tips: 显示当前标签有哪些窗口
"----------------------------------------------------------------------
function! Vim_NeatGuiTabTip()
  let tip = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  for bufnr in bufnrlist
    " separate buffer entries
    if tip != ''
      let tip .= " \n"
    endif
    " Add name of buffer
    let name = Vim_NeatBuffer(bufnr, 1)
    let tip .= name
    " add modified/modifiable flags
    if getbufvar(bufnr, "&modified")
      let tip .= ' [+]'
    endif
    if getbufvar(bufnr, "&modifiable")==0
      let tip .= ' [-]'
    endif
  endfor
  return tip
endfunc


"----------------------------------------------------------------------
" 标签栏最终设置
"----------------------------------------------------------------------
set tabline=%!Vim_NeatTabLine()
set guitablabel=%{Vim_NeatGuiTabLabel()}
set guitabtooltip=%{Vim_NeatGuiTabTip()}

" 不显示滚动条 {{{
if has("gui_running")
  " 禁止显示滚动条
  set guioptions-=r
  set guioptions-=R
  set guioptions-=L
  set guioptions-=L
  " 禁止显示菜单和工具条
  set guioptions-=T "工具栏
  set guioptions-=m "菜单
endif
" }}}






"============================
" 自定义按键
"============================
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
  set guifont=Hack_Nerd_Font_Mono:h14
  " }}}
endif
" ========= 只设置一次结果 ========


" 特殊文件类型自动命令组 {{{
augroup Filetype_Specific
  autocmd!
  " 文本文件{{{
  " pangu.vim
  autocmd BufWritePre *.markdown,*.md,*.text,*.txt call PanGuSpacing()
  " }}}
  " 自动更新Last Modified {{{
  autocmd BufWritePre,FileWritePre,FileAppendPre * call <SID>UpdateLastMod()
  " }}}
augroup END
" }}}

