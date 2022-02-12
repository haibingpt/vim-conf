if empty(glob('~/.vim/autoload/plug.vim'))
  :exe '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs
              \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" add at 2019-07-24 for  vim-plug
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" Declare the list of plugins.
Plug 'dracula/vim', { 'name': 'dracula' }

" 高亮光标所在单词
Plug 'lfv89/vim-interestingwords'

Plug 'mtdl9/vim-log-highlighting' , { 'for': 'log' }

Plug 'vim-scripts/a.vim', { 'for': 'cpp' }
Plug 'jiangmiao/auto-pairs'

Plug 'scrooloose/nerdcommenter'

Plug 'fatih/vim-go' , { 'for': ['go', 'golang'] }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow' , { 'for':  ['cpp', 'golang' ]}
Plug 'ludovicchabant/vim-gutentags'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'rhysd/vim-clang-format' , { 'for': 'cpp' }
Plug 'airblade/vim-gitgutter'
Plug 'APZelos/blamer.nvim'
Plug 'easymotion/vim-easymotion'
Plug 'ap/vim-buftabline'
Plug 'hotoo/pangu.vim'
Plug 'folke/trouble.nvim'
Plug 'akinsho/toggleterm.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'mhinz/vim-startify'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
" {{{ 状态栏 status line & 图标 icons
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'bling/vim-airline'
Plug 'liuchengxu/vista.vim'
"
"Plug 'itchyny/vim-cursorword'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()
"}}}


syntax on
set t_Co=256
colorscheme dracula

" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber

" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

set fileencoding=utf-8
set fencs=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set history=1000

let g:python_host_skip_check=1
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_skip_check=1
let g:python3_host_prog = '/usr/bin/python3'
let python_highlight_all=1
set laststatus=2
set viminfo+=!
set noshowmode
set showmatch
set ignorecase
set hlsearch
set incsearch
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set autochdir
set autoread
set autoindent
set cindent
set smartindent
filetype plugin indent on

"========== code zhedie========
set foldmethod=expr
set foldlevel=99
set foldexpr=nvim_treesitter#foldexpr()
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<cr>

map <F6> :cn<cr>
map <F7> :cp<cr>
map <F8> :bnext<cr>
map <F9> :bprev<cr>
map <C-X> :cclose<cr>
map `` :wq<cr>

"2010-10-12 from http://stevelosh.com/blog/2010/09/coming-home-to-vim/
set modelines=0
let mapleader=","
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
map <tab> %
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk
nnoremap ; :
nnoremap <leader>q :xall<cr>
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<CR>
inoremap jj <ESC>
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set formatoptions=qrn1
set colorcolumn=120
set wrap
set pastetoggle=cv
set hidden
set backspace=indent,eol,start
"neovim
set clipboard+=unnamed
set clipboard+=unnamedplus
set showbreak=>>>>

set cursorline
nnoremap <leader>c :set cursorline! cursorcolumn!<cr>

nmap er   :r ~/.vimxfer<cr>
nmap ew   :'a,.w! ~/.vimxfer<cr>
vmap er   c<esc>:r ~/.vimxfer<cr>
vmap ew   :w! ~/.vimxfer<cr>

"let g:SuperTabDefaultCompletionType='context'
nmap    <tab> v>
nmap    <s-tab> v<
vmap    <tab>   >gv
vmap    <s-tab> <gv
map <c-]> g<c-]>

set updatetime=300
augroup all
    autocmd!
    " 光标自动定位到最后编辑的位置。
    autocmd BufReadPost * if &ft != 'gitcommit' && line("'\"") > 0 |
                    \   if line("'\"") <= line("$") |
                    \     exe("norm '\"") |
                    \   else |
                    \     exe "norm $" |
                    \   endif |
                    \ endif
augroup END


nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<left><left>
nnoremap <leader>e :%s/\<<C-r><C-w>\>/<C-r><C-w>/g<left><left>

inoremap <leader>;  <esc>$a;<esc>;


"
"{{{ gutentags  add at  2020-09-23
let $GTAGSLABEL='native'
let $GTAGSCONF='/usr/local/share/gtags/gtags.conf'
" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root=['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile='.tags'
" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules=[]
if executable('ctags')
	let g:gutentags_modules+=['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules+=['gtags_cscope']
endif
" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir=expand('~/.cache/tags')
" 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
let g:gutentags_ctags_extra_args=['--fields=+niazS', '--extras=+q', '--languages=C++']
let g:gutentags_ctags_extra_args+=['--output-format=e-ctags']
let g:gutentags_ctags_exclude=["*.js", "*.css", "build", "vendor", ".git", "*.json", "*.pb.h", "ad_test", "thirdparty", "3rd",  "mmocadpredictor", "mmocadmodelserving", "typhoon", "mmocadfeaturecache", "mmocadreranking", ".ccls-cache", "*.log", "*.pb.cc", "*dao.h", "*dao.cpp", "*testimpl_pb.h", "*testimpl_pb.cpp", "*client.cpp", "*client.h", "genfiles" ]
" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope=0
"let g:gutentags_define_advanced_commands=1
"let g:gutentags_trace=1
"}}}

"{{{ ctrlp
let g:ctrlp_map = '<leader>f'
let g:ctrlp_cmd = 'CtrlP'
noremap <leader>m :CtrlPMRU<cr>
let g:ctrlp_working_path_mode = 'ar'
set wildignore+=*/tmp/wildignore+*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_regexp = 1
let g:ctrlp_mruf_max = 500
let g:ctrlp_by_filename = 1
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:30,results:30'

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|build|ad_test|thirdparty|3rd|mmocadpredictor|mmocadmodelserving|typhoon|mmocadfeaturecache|mmocadreranking|mmadbroker|\.ccls-cache|wxlog)$',
  \ 'file': '\v\.(exe|so|dll|js|css|a|log|xml|php)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_user_command = 'rg %s --files --color=never -tcpp -tpy -tsql -tmd -tprotobuf -tsh -Tlog '
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
"}}}


" {{{ ack add at 2020-09-24  for ack.vim
if executable('rg')
  let g:ackprg = 'rg --vimgrep  -w -p --no-messages '
endif
let g:ackhighlight = 1
noremap <Leader>g :Ack! <cword> -tcpp -tprotobuf -tgo -tsql -tpy -tsh ~/QQMail/mmad <cr>  :wincmd p <cr>
noremap <Leader>p :Ack! <cword> -tprotobuf ~/QQMail/mmad <cr>  :wincmd p <cr>

noremap <Leader>a :call AckProject() <cr> :wincmd p <cr>
function AckProject()
    let dir = expand('%:p:h')
    let pat = '\(mmocad[^/]*\)'
    let project_dir = dir[0:matchend(dir, pat)]
    exe ":Ack! ".expand("<cword>")."  -tcpp -tprotobuf -tgo -tsql -tpy -tsh ".project_dir

endfunction
noremap <Leader>s :call AckAll() <cr>
function! AckAll()
  let curline = getline('.')
  call inputsave()
  let code = input('Enter code: ')
  call inputrestore()
  exe ":Ack! " .code . " -tcpp -tprotobuf -tgo -tsql -tpy -tsh ~/QQMail/mmad"
endfunction
"}}}


"{{{  clang_format代码格式化
let g:clang_format#code_style = 'google'
let g:clang_format#style_options = {
            \ "ColumnLimit" : 100,
            \ "DerivePointerAlignment" : "true",
            \ "PointerAlignment" : "Left",
            \ "IncludeBlocks" : "Preserve",
            \ "SortIncludes" : "true", }
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
"}}}


"{{{ gitgutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
"}}}

"{{{ blamer
let g:blamer_enabled = 1
let g:blamer_date_format = '%Y/%m/%d'
let g:blamer_show_in_insert_modes = 0
let g:blamer_show_in_visual_modes = 0
"}}}

"{{{ easymotion
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)
let g:EasyMotion_smartcase = 1
"}}}

"{{{
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "cpp", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
   indent = {
    enable = true
  },
  rainbow = {
    enable = true,
    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
}
EOF

"}}}

"{{{ vista tag bar
let g:vista_sidebar_position  = 'vertical topleft'
let g:vista_sidebar_width = 25
let g:vista#renderer#enable_icon = 1
let g:vista_echo_cursor_strategy = "scroll"
let g:vista_close_on_jump=1
nmap <leader>t :Vista!!<cr>
let g:vista_cpp_executive = 'nvim_lsp'
let g:vista_default_executive = "nvim_lsp"
nmap <F2> :A<cr>
"}}}

"{{{ buftabline
"nnoremap <C-N> :bnext<CR>
"nnoremap <C-P> :bprev<CR>
let g:buftabline_show = 1
let g:buftabline_numbers = 2
nnoremap gb :ls<CR>:b<Space>
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
"}}}


"{{{ tabnine
lua << EOF
local tabnine = require('cmp_tabnine.config')
tabnine:setup({
	max_lines = 10000;
	max_num_results = 10;
	sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
	ignored_file_types = { -- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	};
})
EOF
"}}}

"{{{ lsp
" cmp
lua << EOF
local on_my_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#E06C75
      hi LspReferenceText cterm=bold ctermbg=red guibg=#E06C75
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#E06C75
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')
lspconfig["ccls"].setup {
    on_attach = on_my_attach,
    capabilities = capabilities,
    init_options = {
        index = {
            threads = 1;
        };
    }
}
lspconfig["gopls"].setup {
    on_attach = on_my_attach,
    capabilities = capabilities,
}

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'
-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
        else
          fallback()
        end
      end,
  },
 sources = cmp.config.sources({
      { name = 'cmp_tabnine' , priority = 5, max_item_count = 5},
      { name = 'luasnip', priority = 3, max_item_count = 3},
      { name = 'nvim_lsp', max_item_count = 10 },
    } )
}
EOF
"}}}


"{{{ startify
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ ]
let g:startify_files_number = 15
let g:startify_enable_special = 0
let g:startify_custom_header = []
let g:startify_skiplist = ['\.log$','\.h$', '\.txt', '\.sql', '\.vim' , 'BUILD']
nnoremap <leader>h :Startify<cr>
"let g:startify_padding_left = 10
" }}}

"{{{ indent_blankline
lua << EOF
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]

require("indent_blankline").setup {
    space_char_blankline = " ",
    use_treesitter  = true,
    show_current_context = true,
    show_current_context_start = true,
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
    },
}
EOF
let g:indent_blankline_char_list = [ '|', '¦', '┆', '┊']
" }}}


"{{{ toggleterm
lua << EOF
require("toggleterm").setup {
  -- size can be a number or function which is passed the current terminal
  size = 80,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction =  'float', -- 'vertical', -- | 'horizontal' | 'window' | 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
    float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'double', -- | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    width = 150,
    height = 90,
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
}
EOF
"}}}

"{{{ 错误提示
lua << EOF
  require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 40, -- width of the list when position is left or right
    auto_open = false,
    auto_close = false,
    mode = "document_diagnostics",
  }
EOF

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>
"}}}


"{{{ 自动格式化：盘古之白
let g:pangu_rule_date = 1
autocmd BufWritePre *.markdown,*.md,*.text,*.txt,*.wiki,*.cnx call PanGuSpacing("ALL")
"}}}
"
let g:airline_powerline_fonts = 1

"{{{ webdevicons_enable
let g:webdevicons_enable = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_ctrlp = 1
let g:webdevicons_enable_startify = 1
"}}}
"
"
" {{{ 代码注释助手。
let g:NERDSpaceDelims = 1
let g:NERDRemoveExtraSpaces = 1
let g:NERDTreeShowLineNumbers=1
" }}}
"
"
"
" Remove trailing whitespace when writing a buffer, but not for diff files.
" From: Vigil
" @see http://blog.bs2.to/post/EdwardLee/17961
function! RemoveTrailingWhitespace()
  if &ft != "diff"
    let b:curcol = col(".")
    let b:curline = line(".")
    silent! %s/\s\+$//
    silent! %s/\(\s*\n\)\+\%$//
    call cursor(b:curline, b:curcol)
  endif
endfunction
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.cpp,*.h :call RemoveTrailingWhitespace()
endif


" 选中一段文字并全文搜索这段文字
vnoremap  *  y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap  #  y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>


" [fanyi](https://github.com/afc163/fanyi)
nnoremap <leader>d :!fanyi <cword><CR>
vnoremap <leader>d y:!fanyi <c-r>"<CR>


" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" select ALL
map <C-A> ggVG
noremap <CR> :nohlsearch<CR>
nnoremap / /\v
vnoremap / /\v
au FocusLost * :wa
set signcolumn=number
let g:gitgutter_diff_args = '-w'
