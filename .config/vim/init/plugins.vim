" plugins.vim - 插件
"
" Last Modified: 2018/06/10 23:11
"======================================================================
" vim:fdm=marker:fmr={{{,}}}

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
"
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
Plug 'vim-scripts/L9'
Plug 'othree/vim-autocomplpop'
" }}}
" ripgrep rg 文件查找
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
Plug 'maksimr/vim-jsbeautify', { 'for': [ 'html', 'xml', 'javascript', 'json', 'css', 'less', 'scss'], 'do': 'npm install --registry=http://registry.npm.alibaba-inc.com' }
let g:editorconfig_Beautifier = resolve(expand($VIMFILES. '/jsbeautify.editorconfig'))
" }}}

" 光标选择功能 <C-{n,p,x}> {{{
Plug 'terryma/vim-multiple-cursors'
" <c-n> 选中下一个
" <c-p> 回退
" <C-x> 跳过
" <Esc> 退出
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
