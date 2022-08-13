"=========== vimconfig ==============
"设置行号
set number
set relativenumber
"基本设置
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set ignorecase
set smartcase
set notimeout
set mouse=a
"设置键t
imap jk <Esc>
nmap <space> :
"安装插件
call plug#begin('~/.vim/plugged')
"资源浏览器
Plug 'scrooloose/nerdtree'
call plug#end()
map <silent> <C-e> :NERDTreeToggle<CR>





"括号自动补全
"
"
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
""inoremap < <><Esc>i
inoremap { {}<Esc>i
inoremap ' ''<Esc>i
""inoremap " ""<Esc>i
inoremap { {<CR>}<Esc>O 
" 按退格键时判断当前光标前一个字符，如果是左括号，则删除对应的右括号以及括号中间的内容
function! RemovePairs()
let l:line = getline(".")
let l:previous_char = l:line[col(".")-1] " 取得当前光标前一个字符
 
if index(["(","{"], l:previous_char) != -1
let l:original_pos = getpos(".")
execute "normal %"
let l:new_pos = getpos(".")
 
" 如果没有匹配的右括号
if l:original_pos == l:new_pos
execute "normal! a\<BS>"
return
end
 
let l:line2 = getline(".")
if len(l:line2) == col(".")
" 如果右括号是当前行最后一个字符
execute "normal! v%xa"
else
" 如果右括号不是当前行最后一个字符
execute "normal! v%xi"
end
 
else
execute "normal! a\<BS>"
end
endfunction
" 用退格键删除一个左括号时同时删除对应的右括号
inoremap <BS> <ESC>:call RemovePairs()<CR>a
" 输入一个字符时，如果下一个字符也是括号，则删除它，避免出现重复字符
function! RemoveNextDoubleChar(char)
let l:line = getline(".")
let l:next_char = l:line[col(".")] " 取得当前光标后一个字符
 
if a:char == l:next_char
execute "normal! l"
else
execute "normal! i" . a:char . ""
end
endfunction
inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a




"文件重命名
:command! -nargs=1 Rename let tpname = expand('%:t') | saveas <args> | edit <args> | call delete(expand(tpname))


"复制到系统剪切板
set clipboard=unnamedplus
