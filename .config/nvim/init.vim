" Author: Asins - asinsimple AT gmail DOT com
"         Get latest vimrc from http://nootn.com/
" Last Modified: 2018-05-25 00:13 (+0800)

" 全局变量及函数 {{{
let g:python_host_prog='/usr/bin/python'
let g:mapleader = "," " 设置 <Leader>字符
" 判断系统类型 {{{
let $VIMFILES = fnamemodify($MYVIMRC, ':p:h') " neovim工作目录
" }}}
" --------- 定义函数 ------
" 保证该目录存在，若不存在则新建目录 {{{
function! EnsureExists(path)
	if !isdirectory(expand(a:path))
		call mkdir(expand(a:path))
	endif
endfunction
" }}}
" 获取缓存目录 {{{
function! s:GetCacheDir(suffix)
	return resolve(expand(s:cacheDir. '/' . a:suffix))
endfunction
let s:cacheDir = $VIMFILES . '/cache'
call EnsureExists(s:cacheDir) " 保证缓存目录存在
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
" 删除文件末尾空格 {{{
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
function! CompileToCss()
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
"   }}}
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
" }}}

" 自动安装 vim-plug {{{
if empty(glob($VIMFILES.'/autoload/plug.vim'))
	silent execute('!curl -fLo '. $VIMFILES .'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
endif
" }}}
call plug#begin($VIMFILES.'/plugged') " 插件初始化开始{{{
" }}}
" 设置主题色 molokai {{{
Plug 'tomasr/molokai'
let g:molokai_original = 1
" }}}
" 设置主题色 jellybeans {{{
Plug 'nanotech/jellybeans.vim'
let g:jellybeans_use_term_background_color = 0
" }}}
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
Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 0
let g:airline_left_sep=''
let g:airline_right_sep=''
" 修改排版方式
let g:airline#extensions#default#layout = [
  \ [ 'a', 'b', 'c' ],
  \ [ 'x', 'y', 'z']
  \ ]
let g:airline_section_c = '%<%n %F'
let g:airline_section_x = '%{strlen(&ft) ? &ft : "Noft"}%{&bomb ? " BOM" : ""}'
let g:airline_section_y = '%{&fileformat} %{(&fenc == "" ? &enc : &fenc)}'
let g:airline_section_z = '%2l:%-1v/%L'
" 显示icon修改
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.branch = '⎇'

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
" 语法提示 {{{
Plug 'vim-scripts/L9'
Plug 'othree/vim-autocomplpop'
" }}}
" ripgrep rg 文件查找 {{{
Plug 'jremmen/vim-ripgrep'
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
" 快速打开子文件 {{{
Plug 'asins/OpenRequireFile.vim'
let g:OpenRequireFile_By_Map = [
	\ $HOME.'/tudou/static_v3/src/js',
	\ $HOME.'/tudou/static_v3/src/css',
	\ $HOME.'/tudou/static_youku/src/js',
	\ $HOME.'/tudou/static_youku/src/css',
	\ ]
" nmap <silent> <Leader>gf :call OpenRequireFile()<cr>
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
Plug 'tpope/vim-unimpaired'
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
" yo yO 在行前/后进入插入模式（无视缩进、注释继承）与O键不同
" }}}
" clever-f {{{
Plug 'rhysd/clever-f.vim'
let g:clever_f_across_no_line = 1
" }}}
" JS语法、缩进支持 {{{
" Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'

Plug 'pangloss/vim-javascript', { 'for': [ 'javascript' ] }
" 允许高亮JSDocs注释语法
let g:javascript_plugin_jsdoc = 1

Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/es.next.syntax.vim', { 'for': [ 'javascript' ] }
Plug 'othree/yajs.vim', { 'for': [ 'javascript' ] }
let g:used_javascript_libs = 'jquery,vue'
" }}}
" Vue语法 {{{
Plug 'posva/vim-vue'
" }}}
" 打开光标下的链接 <Leader>ur {{{
" Plug 'tyru/open-browser.vim'
" nmap <silent> <Leader>ur :OpenBrowser <C-U>call GetPatternAtCursor('\v%(https?|ftp)://[^]''" \t\r\n>*。，\`)]*')
" }}}
" 语法/高亮支持 {{{
Plug 'othree/html5.vim', { 'for': ['html'] }
Plug 'othree/html5-syntax.vim', { 'for': ['html'] }
" Nginx语法
"Plug 'evanmiller/nginx-vim-syntax', { 'for': [ 'nginx' ] }
" Markdown 语法
Plug 'tpope/vim-markdown', { 'for': [ 'markdown' ] }
" fish shell 语法
Plug 'dag/vim-fish'
" Docker 语法
Plug 'ekalinin/Dockerfile.vim'
" }}}
" Mru 打开历史文件列表 {{{
" Plug 'yegappan/mru'
" let MRU_File = s:GetCacheDir("mru_file")
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
" BufferLine {{{
" Plug 'ap/vim-buftabline'
" let g:buftabline_numbers=1
" nmap <Leader>1 <Plug>BufTabLine.Go(1)
" nmap <Leader>2 <Plug>BufTabLine.Go(2)
" nmap <Leader>3 <Plug>BufTabLine.Go(3)
" nmap <Leader>4 <Plug>BufTabLine.Go(4)
" nmap <Leader>5 <Plug>BufTabLine.Go(5)
" nmap <Leader>6 <Plug>BufTabLine.Go(6)
" nmap <Leader>7 <Plug>BufTabLine.Go(7)
" nmap <Leader>8 <Plug>BufTabLine.Go(8)
" nmap <Leader>9 <Plug>BufTabLine.Go(9)
" nmap <Leader>0 <Plug>BufTabLine.Go(10)
" }}}
" Ctrlp 模糊文件查找 <C-p> <Leader>{f,l,b} {{{
" 模糊文件查找
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_working_path_mode = 'ra'
" 设置缓存目录
let g:ctrlp_cache_dir = s:GetCacheDir("ctrlp")
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git|hg|svn|cache|Trash)$',
			\ 'file': '\v\.(log|jpg|png|jpeg|exe|so|dll|pyc|pyo|swf|swp|psd|db|DS_Store)$'
			\ }
if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --color=never --ignore-file .svn --ignore-file .hg --ignore-file .DS_Store --ignore-file .git --glob ""'
  let g:ctrlp_use_caching = 0
endif
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript', 'mixed']

nnoremap <C-p> :CtrlP<Space>
" 用最近最多使用模式打开CtrlP
nnoremap <silent> <Leader>m :CtrlPMRU<CR>
" 用上一次使用的模式打开CtrlP
nnoremap <silent> <Leader>l :CtrlPLastMode<CR>
" 用缓冲区搜索模式打开CtrlP
nnoremap <silent> <Leader>b :CtrlPBuffer<CR>
" }}}
" LeaderF {{{
" Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" }}}
" 自动实例配对符号 delimitMate {{{
Plug 'Raimondi/delimitMate'
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1 " {|} => { | }
" }}}
" 树形的文件系统浏览器 {{{
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" 指定书签文件
let NERDTreeBookmarksFile = s:GetCacheDir("NERDTreeBookmarks")
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
Plug 'maksimr/vim-jsbeautify', { 'for': [ 'html', 'xml', 'javascript', 'json', 'css', 'less', 'scss'], 'do': 'npm install --registry=http://registry.npm.alibaba-inc.com' }
let g:editorconfig_Beautifier = resolve(expand($VIMFILES. '/jsbeautify.editorconfig'))
" Plug 'maksimr/vim-jsbeautify', { 'for': [ 'html', 'xml', 'javascript', 'css', 'less', 'scss'], 'do': 'npm install --registry=https://registry.npm.taobao.org' }
" Plug 'Chiel92/vim-autoformat' 可能更好
" }}}
" 光标选择功能 <C-{n,p,x}> {{{
Plug 'terryma/vim-multiple-cursors'
" <c-n> 选中下一个
" <c-p> 回退
" <C-x> 跳过
" <Esc> 退出
" }}}
" Quickfix切换 {{{
" Plug 'milkypostman/vim-togglelist'
" nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
" nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>
" }}}
" css中的颜色显示
Plug 'ap/vim-css-color'
" 自动创建目录
Plug 'travisjeffery/vim-auto-mkdir'

" Vim 中文文档计划
Plug 'asins/vimcdoc'
" 关键词字典 {{{
Plug 'asins/vim-dict'
" <ctrl-x>_<ctrl-k> 打开提示
" }}}

call plug#end() " Plugins initialization finished {{{
" }}}


" ========= 以下配置只设置一次 ========
if !exists('g:VimrcIsLoaded')
	" 设置文字编辑配置 {{{
	set nocompatible " be iMproved
	syntax on " 自动语法高亮
	set autochdir " 根目录自动更新
	set number " 显示行号
	set hidden " 允许在有未保存的修改时切换缓冲区
	set smartindent " 智能自动缩进
	set mouse=a " 允许在所有模式下使用鼠标
	set mousehide  " 键入时隐藏鼠标
	" set nowrap "不自动换行
	"set showtabline=0 " 不显示Tab栏
	set list " 显示隐藏字符
	set expandtab  "键入Tab时转换成空格
	set shiftwidth=2  " 设定 << 和 >> 命令移动时的宽度为 4
	set softtabstop=2  " 设置按BackSpace的时候可以一次删除掉4个空格
	set tabstop=2 "tab = 4 spaces
	set laststatus=2 " 显示状态栏 (默认值为 1, 无法显示状态栏)
    set listchars=tab:\|·,trail:·,extends:❯,precedes:❮,nbsp:×
	set wildmenu " Vim自身命令行模式智能补全
	set nobackup " 覆盖文件时不备份
	set nowritebackup "文件保存后取消备份
	set noswapfile  "取消交换区
	" set smarttab
	set scrolloff=3 " 设置光标之下的最少行数
	set viminfo=%,'1000,<50,s20,h,n$VIMFILES/cache/viminfo
	" 执行宏、寄存器和其它不通过输入的命令时屏幕不会重画(提高性能)
	set lazyredraw
	" 设置加密选项 {{{
	" (以下取自 https://github.com/lilydjwg/dotvim )
	try
		" Vim 7.4.399+
		set cryptmethod=blowfish2
	catch /.*/
		" Vim 7.3+
		try
			set cryptmethod=blowfish
		catch /.*/
			" Vim 7.2-, neovim
		endtry
	endtry
	" }}}
	" 设置语法折叠 {{{
	set foldenable
	set foldmethod=manual
	"  可组合 {} () <> []使用
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
	"       用语法高亮来定义折叠
	"     diff    对没有更改的文本进行折叠
	"     marker  对文中的标志折叠
	" }}}
	" {{{ 搜索
	set nowrapscan " 搜索到文件两端时不重新搜索
	set ignorecase " 搜索时忽略大小写
	set smartcase " 在有一个或以上大写字母时不使用ignorecase选项，仍大小写敏感
	set hlsearch  " 搜索时高亮显示被找到的文本
	" }}}
	" wildignore {{{
	set wildignore+=*/node_modules/** " Ignore Node.js modules
	set wildignore+=*.png,*.jpg,*.gif,*.xpm,*.tiff " Ignore image file
	set wildignore+=*.so,*.swp,*.lock,*.db,*.zip,*/.Trash/**,*.pdf,*.xz,*.DS_Store,*/.sass-cache/**
	" }}}
	" 将撤销树保存到文件 {{{
	if has('persistent_undo')
		set undofile
		let &undodir = s:GetCacheDir("undo")
		" 保证撤销缓存目录存在
		call EnsureExists(&undodir)
	endif
	" }}}
	" }}}
	" 设置图形界面选项 {{{
	if has("gui_running")
		set shortmess=atI  " 启动的时候不显示那个援助乌干达儿童的提示
		" 禁止显示滚动条
		set guioptions-=r
		set guioptions-=R
		set guioptions-=L
		set guioptions-=L
		" 禁止显示菜单和工具条
		set guioptions-=T "工具栏
		set guioptions-=m "菜单
		set guitablabel=%N\ \ %t\ %M   "标签页上显示序号
	endif
	" 设置显示字体和大小
	" set guifont=Monaco:h14
	colorscheme molokai
	" colorscheme jellybeans
	" }}}
	" 设置语言编码 {{{
	" 解决console输出乱码
	language messages zh_CN.UTF-8
	" set langmenu=zh_CN.UTF-8
	set helplang=cn " 显示中文帮助
	set termencoding=utf-8
	set fileencodings=utf-8,chinese,taiwan,ucs-2,ucs-2le,ucs-bom,latin1,gbk,gb18030,big5,utf-16le,cp1252,iso-8859-15
	set encoding=utf-8
	set fileencoding=utf-8
	" }}}
  " 设置grep搜索命令为rg(ripgrep) {{{
  if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
  endif
  " }}}
endif
" ========= 只设置一次结果 ========


" 特殊文件类型自动命令组 {{{
augroup Filetype_Specific
	autocmd!
	" * {{{
	" 保存时自动删除多余空格
	autocmd BufWritePre * call s:StripTrailingWhitespace()
	" }}}
	" CSS {{{
	autocmd FileType css setlocal smartindent noexpandtab foldmethod=indent
	autocmd BufNewFile,BufRead *.less,*.scss setlocal filetype=css
	" 删除一条CSS中无用空格 <Leader>co
	autocmd FileType css vnoremap <Leader>co J:s/\s*\([{:;,]\)\s*/\1/g<CR>:let @/=''<CR>
	autocmd FileType css nnoremap <Leader>co :s/\s*\([{:;,]\)\s*/\1/g<CR>:let @/=''<CR>
	" less文件保存时自动编译为css文件
    " autocmd BufWritePost,FileWritePost *.less,*.scss,*.sass call CompileToCss()
	" 美化代码(need vim-JsBeautify plugin)
	autocmd FileType css noremap <buffer> <silent> <Leader>ff :call CSSBeautify()<cr>
	" }}}
	" Java {{{
	" Java Velocity 模板使用html高亮
	autocmd BufNewFile,BufRead *.vm setlocal ft=vm =html
	" }}}
	" JavaScript {{{
	" Vue模板使用html高亮
	" autocmd BufNewFile,BufRead *.vue setlocal ft=html =html
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
	" NunJucks,jinja2
	autocmd BufNewFile,BufRead *.nj setlocal filetype=jinja
	" HTML {{{
	" 美化代码(need vim-JsBeautify plugin)
	autocmd FileType html noremap <buffer> <silent> <Leader>ff :call HtmlBeautify()<cr>
	" }}}
	" PHP {{{
	" PHP Twig 模板引擎语法
	autocmd BufNewFile,BufRead *.twig set =twig
	" }}}
	" Python {{{
	" Python 文件的一般设置，比如不要 tab 等
	autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab foldmethod=indent
	" }}}
	" VimFiles {{{
	" 在VimScript中快速查找帮助文档
	autocmd Filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
	" 保存vimrc文件时自动加载设置
	autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
	" }}}
	" 文本文件{{{
	" pangu.vim
	autocmd BufWritePre *.markdown,*.md,*.text,*.txt call PanGuSpacing()
	" }}}
	" 自动更新Last Modified {{{
	" autocmd BufWritePre,FileWritePre,FileAppendPre * call <SID>UpdateLastMod()
	" }}}
augroup END
" }}}

" 自定义令 {{{
if has('user_commands')
	" :Delete 删除当前文件 {{{
	command! -nargs=0 Delete
				\ if delete(expand('%'))
				\|    echohl WarningMsg
				\|    echo "删除当前文件失败!"
				\|    echohl None
				\|endif
	"   }}}
endif
" }}}

" 键盘绑定 {{{
" 保存/复制/剪切/粘贴 {{{
noremap <c-S> :update<CR>
vnoremap <c-S> <C-C>:update<CR>
inoremap <c-S> <C-O>:update<CR>

" CTRL-X 剪切
vnoremap <c-X> "+x

" CTRL-C 复制
vnoremap <c-C> "+y

" CTRL-V 粘贴
" map <c-V> "+gP
" 命令行模式
" cmap <c-V> <C-R>+
" }}}

" 开/关折叠 <Space> {{{
nnoremap <silent> <Space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR>
" }}}
" N: 快速编辑 vimrc 文件 <Leader>e {{{
nmap <silent> <Leader>e :edit $MYVIMRC<CR>
" }}}
" V: 全文搜索选中的文字 <Leader>{f,F} {{{
" 向上查找
vnoremap <silent> <Leader>f y/<c-r>=escape(@", "\\/.*$^~[]")<cr><cr>
" 向下查找
vnoremap <silent> <Leader>F y?<c-r>=escape(@", "\\/.*$^~[]")<cr><cr>
" }}}
" N: Buffers/Tab操作 <Shift+{h,l,j,k}> {{{
nnoremap <s-h> :bprevious<cr>
nnoremap <s-l> :bnext<cr>
nnoremap <s-j> :tabnext<cr>
nnoremap <s-k> :tabprev<cr>
"   }}}
" I: 移动光标 <Ctrl+{h,l,j,k}> {{{
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap <c-j> <c-o>gj
inoremap <c-k> <c-o>gk
" }}}
" N: Buffer切换 <Ctrl+{h,l,j,k}> {{{
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
" }}}
" N: 复制文件路径 <Ctrl+c> <Leader>c{f,F,t,h} {{{
" 相对路径 (src/foo.txt)
nnoremap <leader>cf :let @+=expand("%") \| echo 'cb> '.@+<CR>
" 绝对路径 (/something/src/foo.txt)
nnoremap <leader>cF :let @+=expand("%:p") \| echo 'cb> '.@+<CR>
nnoremap <C-c> :let @+ = expand('%:p') \| echo 'cb> '.@+<CR>
" 文件名 (foo.txt)
nnoremap <leader>ct :let @+=expand("%:t") \| echo 'cb> '.@+<CR>
" 目录地址 (/something/src)
nnoremap <leader>ch :let @+=expand("%:p:h") \| echo 'cb> '.@+<CR>
" }}}
" 全选文本
noremap vA ggVG
" N: 切换 Tab <leader>+1~10 {{{ 改用BufTabLine插件
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 10gt
" }}}
" N: 通用关闭行为 Q {{{
nnoremap <silent> Q :call CloseSplitOrDeleteBuffer()<CR>
function! CloseSplitOrDeleteBuffer()
	if winnr('$') > 1
		wincmd c
	else
		execute 'bdelete'
	endif
endfunction
" }}}
" N: 关闭删除所有隐藏缓冲区 <Leader>bd {{{
nnoremap <silent> <Leader>bd :call DeleteHiddenBuffers()<CR>
function! DeleteHiddenBuffers()
	let tpbl=[]
	call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
	for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
		silent execute 'bwipeout' buf
	endfor
	echo 'delete hidden buffers success.'
endfunction " }}}
" }}}

" 记录加载 Vim 配置文件的次数 {{{
if !exists("g:VimrcIsLoaded")
	let g:VimrcIsLoaded = 1
else
	let g:VimrcIsLoaded = g:VimrcIsLoaded + 1
endif
" }}}
" vim bugfix {{{
if has('python3')
  silent! python3 1
endif
" }}}
" vim:fdm=marker:fmr={{{,}}}
