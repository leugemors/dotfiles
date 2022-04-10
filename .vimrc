"        _    _
"   _ __| | _| |
"  | '__| |/ / |   Richard Klein Leugemors
"  | |  |   <| |   https://www.github.com/leugemors/
"  |_|  |_|\_\_|
"
"  Type  :so %  to refresh .vimrc after making changes.

" ---------------------------------------------------------------------------
"  no need to be compatible with the original vi (required)
" ---------------------------------------------------------------------------

set nocompatible
filetype off

" ---------------------------------------------------------------------------
"  manage plugins, install them with :PlugInstall (:PlugClean)
" ---------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

    " basic plugins
    Plug 'gmarik/Vundle.vim'                           " vim bundle pluin manager
    Plug 'itchyny/lightline.vim'                       " lightline statusbar
    Plug 'suan/vim-instant-markdown', {'rtp': 'after'} " markdown preview
    Plug 'frazrepo/vim-rainbow'                        " rainbow brackets for vim
    "Plug 'vim-airline/vim-airline'                    " airline statusbar
    "Plug 'vim-airline/vim-airline-themes'

    " file management
    Plug 'vifm/vifm.vim'                               " vifm
    Plug 'scrooloose/nerdtree'                         " nerdtree
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'     " highlighting nerdtree
    Plug 'ryanoasis/vim-devicons'                      " icons for nerdtree
    Plug 'Xuyuanp/nerdtree-git-plugin'

    " productivity
    Plug 'vimwiki/vimwiki'                             " my personal wiki
    Plug 'jreybert/vimagit'                            " magit-like plugin for vim
    Plug 'tpope/vim-surround'                          " change surrounding marks
    Plug 'airblade/vim-gitgutter'                      " show git diff per line
    Plug 'alvan/vim-closetag'                          " auto close (x)html tags
    Plug 'dense-analysis/ale'                          " some syntax checking
    Plug 'jiangmiao/auto-pairs'                        " auto pair brackets etc.
    Plug 'majutsushi/tagbar'                           " use ctags in vim

    " colours and syntax highlighting
    Plug 'joshdick/onedark.vim'                        " onedark colour theme
    Plug 'sheerun/vim-polyglot'                        " support for many languages
    Plug 'ap/vim-css-color'                            " show hex colours
    Plug 'Yggdroot/indentLine'                         " visuallize indenations
    Plug 'pedrohdz/vim-yaml-folds'
 
call plug#end()

" ---------------------------------------------------------------------------
"  basic settings
" ---------------------------------------------------------------------------

set autoread                  " auto read when a file has changed from outside
set clipboard=unnamedplus     " copy/paste between vim and other programs
set colorcolumn=80            " show a line at column 80
set cursorline                " underline the current line
set hidden                    " needed to keep multiple buffers open
set history=2000              " how many lines of history should vim remember
set lazyredraw                " don't redraw while executing macros
set magic                     " turn magic on for regular expressions
set number                    " display line numbers
"set number relativenumber    " display line numbers
set numberwidth=5             " set width for numbers to 5
set so=3                      " show 3 lines to the cursor
let g:rehash256 = 1

" ---------------------------------------------------------------------------
"  enable filetype plugins
" ---------------------------------------------------------------------------

filetype plugin indent on

" ---------------------------------------------------------------------------
"  no annoying sounds or errors
" ---------------------------------------------------------------------------

set noerrorbells
set novisualbell
set t_vb=
set tm=500

" ---------------------------------------------------------------------------
"  sane text files and unix file type as default
" ---------------------------------------------------------------------------

set encoding=utf-8
set fileencoding=utf-8
set fileformat=unix
set fileformats=unix,dos,mac

" ---------------------------------------------------------------------------
"  turn backups off
" ---------------------------------------------------------------------------

set nobackup                  " no auto backups
set nowritebackup             " no backup before overwriting files
set noswapfile                " no swap

" ---------------------------------------------------------------------------
"  search settings
" ---------------------------------------------------------------------------

set incsearch                 " incremental search
set ignorecase                " ignore case when searching
set hlsearch                  " highlight search results
set path+=**                  " searches current directory recursively
set smartcase                 " try to be smart about cases
set wildmenu                  " display all matches when tab complete
set wildignore=*.o,*~,*.pyc   " ignore these file extensions

" ---------------------------------------------------------------------------
"  status line
" ---------------------------------------------------------------------------
"
let g:lightline={ 'colorscheme': 'onedark', }
let g:airline_powerline_fonts = 1
let g:airline_theme = 'onedark'
set laststatus=2              " always show the status line
set noshowmode                " don't show non-normal modes in powerline

" ---------------------------------------------------------------------------
"  set tabs and indents
" ---------------------------------------------------------------------------

set expandtab                 " use spaces instead of tabs
set smarttab                  " be smart using tabs
set shiftwidth=4              " set tab to four spaces
set softtabstop=4
set tabstop=4

" set tab stops to only 2 spaces for specific file types
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2

set autoindent
set smartindent
set wrap

" indent/unindent with tab/shift-tab
nmap <Tab> >>
nmap <S-tab> <<
imap <S-Tab> <Esc><<i
vmap <Tab> >gv
vmap <S-Tab> <gv

" disable autoindent when pasting text
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" code folding
set foldmethod=indent
set foldlevel=99

" ---------------------------------------------------------------------------
"  configure nerdtree
" ---------------------------------------------------------------------------

"autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '__pycache__']
let g:NERDTreeDirArrowExpandable='►'
let g:NERDTreeDirArrowCollapsible='▼'
let NERDTreeShowLineNumbers=0
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let g:NERDTreeWinSize=42

" ---------------------------------------------------------------------------
"  move through split windows
" ---------------------------------------------------------------------------

nmap <leader><Up> :wincmd k<CR>
nmap <leader><Down> :wincmd j<CR>
nmap <leader><Left> :wincmd h<CR>
nmap <leader><Right> :wincmd l<CR>

" ---------------------------------------------------------------------------
"  move through buffers
" ---------------------------------------------------------------------------

nmap <leader>[ :bp!<CR>
nmap <leader>] :bn!<CR>
nmap <leader>x :bp<bar>bd#<CR>

" ---------------------------------------------------------------------------
"  colours and theming
" ---------------------------------------------------------------------------

syntax on                     " enable syntax highlighting

set t_Co=256                  " set if term supports 256 colours
set t_ut=                     " clearing uses the current backgroupd colour

set termguicolors
set background=dark

" the onedark colour theme
let g:onedark_color_overrides={"background":{"gui":"#111111","cterm":"235","cterm16":"0"}}
let g:onedark_hide_endofbuffer=1
let g:onedark_termcolors=256
let g:onedark_terminal_italics=1
colorscheme onedark

" colour schemes
"colorscheme blue
"colorscheme darkblue
"colorscheme default
"colorscheme delek
"colorscheme desert
"colorscheme elflord
"colorscheme evening
"colorscheme industry
"colorscheme koehler
"colorscheme morning
"colorscheme murphy
"colorscheme pablo
"colorscheme peachpuff
"colorscheme ron
"colorscheme shine
"colorscheme slate
"colorscheme torte
"colorscheme zellner

" ---------------------------------------------------------------------------
"  configure indentline
" ---------------------------------------------------------------------------
 
let g:indentLine_setColors=1
let g:indentLine_char='⦙'

" vim
let g:indentLine_color_term=239

" gvim
let g:indentLine_color_gui='#444444'

" none x terminal
let g:indentLine_color_tty_light=7 " (default: 4)
let g:indentLine_color_dark=1 " (default: 2)

" background (vim, gvim)
"let g:indentLine_bgcolor_term=202
"let g:indentLine_bgcolor_gui='#ff5f00'

" ---------------------------------------------------------------------------
"  autopair brackets
" ---------------------------------------------------------------------------

au FileType python let b:AutoPairs = AutoPairsDefine({"f'" : "'", "r'" : "'", "b'" : "'"})

set showmatch      " show matching brackets
set mat=2          " blink 0.2 seconds when matching brackets

" ---------------------------------------------------------------------------
"  settings for tags
" ---------------------------------------------------------------------------

map <C-t> :TagbarToggle<CR>

" ---------------------------------------------------------------------------
"  settings for vifm
" ---------------------------------------------------------------------------

map <Leader>vv :Vifm<CR>
map <Leader>vs :VsplitVifm<CR>
map <Leader>sp :SplitVifm<CR>
map <Leader>dv :DiffVifm<CR>
map <Leader>tv :TabVifm<CR>

" ---------------------------------------------------------------------------
"  settings for vimwiki
" ---------------------------------------------------------------------------

let g:vimwiki_list=[{'path':'~/vimwiki/','syntax':'markdown','ext':'.md'}]

" ---------------------------------------------------------------------------
"  instant markdown
" ---------------------------------------------------------------------------

let g:instant_markdown_autostart=0           " Turns off auto preview
let g:instant_markdown_browser="surf"        " Uses surf for preview
map <Leader>md :InstantMarkdownPreview<CR>   " Previews .md file
map <Leader>ms :InstantMarkdownStop<CR>      " Kills the preview

" ---------------------------------------------------------------------------
"  open a terminal inside vim
" ---------------------------------------------------------------------------

map <Leader>tt :vnew term://zsh<CR>

" ---------------------------------------------------------------------------
"  splits and tabbed files
" ---------------------------------------------------------------------------

set splitbelow splitright

" remap splits navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" change 2 split windows from vert to horiz or horiz to vert
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K

" set split seperators
"set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:-,diff:-

" ---------------------------------------------------------------------------
"  syntax checking with ale
" ---------------------------------------------------------------------------

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set foldlevelstart=20

let g:ale_echo_msg_format='[%linter%] %s [%severity%]'
let g:ale_sign_error='✘'
let g:ale_sign_warning='⚠'
let g:ale_lint_on_text_changed='never'

map <C-e> <Plug>(ale_next_wrap)
map <C-r> <Plug>(ale_previous_wrap)

" ---------------------------------------------------------------------------
"  some handy abriviations
" ---------------------------------------------------------------------------

ab mvg Met vriendelijke groet,
ab rkl Richard Klein Leugemors

" ---------------------------------------------------------------------------
"  miscelaneous stuff
" ---------------------------------------------------------------------------

let g:python_highlight_all = 1

au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
au BufEnter *.org call org#SetOrgFileType()

" some gui stuff
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
