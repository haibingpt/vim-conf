filetype off
call pathogen#infect()
"call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set nocompatible

"set nu
set relativenumber

set fileencoding=utf-8
set fencs=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

au BufWinLeave *.* silent! mkview
au BufWinEnter *.* silent! loadview
set history=500
set clipboard+=unnamed
syntax on
set  t_Co=256
color  molokai

au InsertEnter * hi StatusLine  ctermbg=201
au InsertLeave * hi StatusLine ctermbg=4
set ruler
set laststatus=2
set statusline=\ [%n]\ \ %F%m%r\ \ %h%y%w\ \ [%l,%c]\ \ [%L]\ \ [%P]

set guifont=Bitstream_Vera_Sans_Mono:h12:cANSI
set viminfo+=!

"set backup
"set backupext=.bak
"set autowrite
set showmatch
set matchtime=5
set ignorecase
set hlsearch
set incsearch
nnoremap <leader><space> :noh<cr>

set autoindent
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

set autochdir

"==========code zhedie========
set foldenable
set foldcolumn=2
set foldmethod=syntax
set foldlevel=10
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<cr>

set path+=../include/
set path+=../../include/
set tags+=~/.vim/tag/cpp

set tags+=./tags
set tags+=../tags

let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_width = 30
let g:tagbar_autoclose = 0
let g:tagbar_compact = 1
nmap <silent> <F3> :TagbarToggle<cr>

let NERDTreeWinSize=20
nmap <silent> <F2> :NERDTreeToggle<cr>

map <F5> :w<cr>:make -j4<cr>
map <F6> :cn<cr>
map <F7> :cp<cr>
map <C-x> :cclose<cr>

"autocmd BufRead *.cpp TagbarToggle | NERDTreeToggle

let Grep_Default_Filelist = '*.cpp *.c *.h *.hpp' 
let Grep_Default_Options = '-w'
let Grep_Skip_Files = '*.bak *~ *.orig tags GTAGS GRTAGS GPATH' 
nnoremap <silent> <F8>   :Grep <cr>
"nnoremap <silent> <F10>   :!locate <cword> <cr>
nnoremap <silent> <F10>   :!find /usr/local/include/ -name <cword>*  -type f <cr>
nnoremap <silent> <F12>  :w<cr> :A<cr>

"gtags
nmap <C-p> :Gtags<cr><cr>
nmap <C-\> :GtagsCursor<cr>

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne=0

let g:BASH_AuthorName   = 'haibinkuang'
let g:BASH_Email        = 'haibinkuang@tencent.com'

let g:NeoComplCache_DisableAutoComplete = 1
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:SuperTabDefaultCompletionType ='<C-X><C-U>'


"add highlighting for function definition in C++
function! EnhanceCppSyntax()
    syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
    hi def link cppFuncDef Special
endfunction
autocmd Syntax cpp call EnhanceCppSyntax()


"2010-10-12 from http://stevelosh.com/blog/2010/09/coming-home-to-vim/
set modelines=0
let mapleader = ","
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk
nnoremap ; :
au FocusLost * :wa
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
inoremap jj <ESC>
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>a :Ack -i --type=cpp -w <cword> ../ <cr>
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

set cursorline
nnoremap <leader>c :set cursorline! cursorcolumn!<cr>


set gdefault
set hidden
set backspace=indent,eol,start
set nobackup
set noswapfile

autocmd BufNewFile,BufRead *.cpp set formatprg=astyle

"au InsertLeave * write

nmap er   :r ~/.vimxfer<cr>
nmap ew   :'a,.w! ~/.vimxfer<cr>
vmap er   c<esc>:r ~/.vimxfer<cr>
vmap ew   :w! ~/.vimxfer<cr>

" display indentation guides
"set list listchars=tab:>-,trail:-
"set list listchars=tab:>.,trail:.,extends:#,nbsp:.
set list listchars=tab:\|\ 
" " convert spaces to tabs when reading file
autocmd! bufreadpost  *.c,*.cpp,*.h set noexpandtab | retab! 4
" " convert tabs to spaces before writing file
autocmd! bufwritepre  *.c,*.cpp,*.h set expandtab | retab! 4
" " convert spaces to tabs after writing file (to show guides again)
autocmd! bufwritepost *.c,*.cpp,*.h set noexpandtab | retab! 4

"set tw=80
"set columns=80

nnoremap <leader>l :call<SID>LongLineHLToggle()<cr>
hi OverLength ctermbg=none cterm=none
match OverLength /\%>80v/
fun! s:LongLineHLToggle()
	if !exists('w:longlinehl')
		let w:longlinehl = matchadd('ErrorMsg', '.\%>80v', 0)
		echo "Long lines highlighted"
	else
		call matchdelete(w:longlinehl)
		unl w:longlinehl
		echo "Long lines unhighlighted"
	endif
endfunction


" mru config
let MRU_Max_Entries = 1000
let MRU_Include_Files = '\.cpp$\|\.h$|\.c$'
let MRU_Window_Height = 10
let MRU_Add_Menu = 0
nmap <leader>u :MRU<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=1
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
	endif
	set csverb
endif

nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>



"vimwiki
let g:vimwiki_use_mouse = 1
let g:vimwiki_camel_case = 0
let g:vimwiki_CJK_length = 1
let g:vimwiki_html_header_numbering = 1
map <leader>hl <ESC>:Vimwiki2HTML<CR>
map <leader>2h <ESC>:source $VIMRUNTIME/syntax/2html.vim  <CR>


"""""""""""""""""""""""""""""configuration for neocomplcache""""""""""""""""""""""""""""
"Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 1
" set the max list in the popup menu. increase the speed
let g:neocomplcache_max_list=20
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
let g:neocomplcache_auto_completion_start_length=1
" ignore letter case
let g:neocomplcache_enable_ignore_case=1

let g:Powerline_symbols = 'unicode'

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
