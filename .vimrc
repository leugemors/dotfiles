"############################################################################
"##        _    _
"##   _ __| | _| |
"##  | '__| |/ / |   Richard Klein Leugemors
"##  | |  |   <| |   https://www.github.com/leugemors/
"##  |_|  |_|\_\_|
"##
"##  Type  :so ~/.vimrc  to refresh after making changes.
"##
"############################################################################

" ---------------------------------------------------------------------------
"  some required settings for the plugins
" ---------------------------------------------------------------------------

set nocompatible      " no need to be compatible with the original vi
filetype off          " needs to be switched off while loading plugins

" ---------------------------------------------------------------------------
"  manage plugins (:PlugInstall :PlugClean :PlugUpdate, etc.)
" ---------------------------------------------------------------------------

let need_to_install_plugins = 0

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let need_to_install_plugins = 1
endif

call plug#begin('~/.vim/plugged')

    " a nice statusbar
    Plug 'vim-airline/vim-airline'                     " airline statusbar
    Plug 'vim-airline/vim-airline-themes'              " themes for airline statusbar

    " nerdtree file management
    Plug 'scrooloose/nerdtree'                         " nerdtree
    Plug 'ryanoasis/vim-devicons'                      " icons for nerdtree
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'     " highlighting nerdtree
    Plug 'Xuyuanp/nerdtree-git-plugin'                 " git support for nerdtree

    " productivity
    Plug 'airblade/vim-gitgutter'                      " show git diff per line
    Plug 'alvan/vim-closetag'                          " auto close (x)html tags
    Plug 'dense-analysis/ale'                          " some syntax checking
    Plug 'jiangmiao/auto-pairs'                        " auto pair brackets
    Plug 'majutsushi/tagbar'                           " use ctags in vim
    Plug 'neoclide/coc.nvim', {'branch': 'release'}    " completion for c and c++
    Plug 'suan/vim-instant-markdown', {'rtp': 'after'} " markdown preview

    " colours and syntax highlighting
    Plug 'ap/vim-css-color'                            " show hex colours
    Plug 'frazrepo/vim-rainbow'                        " rainbow brackets for vim
    Plug 'joshdick/onedark.vim'                        " onedark colour theme
    Plug 'sheerun/vim-polyglot'                        " support for many languages
    Plug 'Yggdroot/indentLine'                         " visualize indentions

    " integrate some external tools
    Plug 'vifm/vifm.vim'                               " vi file manager
    Plug 'vimwiki/vimwiki'                             " taking notes from within vim

    Plug 'kshenoy/vim-signature'                       " show marks before the line number

call plug#end()

if need_to_install_plugins == 1
    echo "Installing plugins..."
    silent! PlugInstall
    echo "Done!"
    q
endif

" ---------------------------------------------------------------------------
"  basic settings
" ---------------------------------------------------------------------------

set autoread                   " auto read when a file has changed from outside
set backspace=start,eol,indent " better use of backspace
set clipboard=unnamedplus      " copy/paste between vim and other programs
set colorcolumn=96             " show a line at column 80
set cursorline                 " underline the current line
set hidden                     " needed to keep multiple buffers open
set history=2000               " how many lines of history should vim remember
set lazyredraw                 " don't redraw while executing macros
set magic                      " turn magic on for regular expressions
set number                     " display line numbers
"set number relativenumber     " display relative line numbers
set numberwidth=5              " set width for numbers to 5
set scrolloff=3                " show 3 lines to the cursor
syntax on                      " enable syntax highlighting

" ---------------------------------------------------------------------------
"  use line cursor within insert mode and block cursor everywhere else
" ---------------------------------------------------------------------------

" Reference chart of values: (default: 6,2)
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).

let &t_EI = "\e[2 q"   " normal mode
let &t_SI = "\e[1 q"   " insert mode

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
set noswapfile                " no swap
set nowritebackup             " no backup before overwriting files

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
"  setup code folding
" ---------------------------------------------------------------------------

set foldmethod=indent
set foldlevel=99

nnoremap <space> za

" ---------------------------------------------------------------------------
"  status line
" ---------------------------------------------------------------------------

let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1

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

" ---------------------------------------------------------------------------
"  mouse support
" ---------------------------------------------------------------------------

set mouse=a

" ---------------------------------------------------------------------------
"  configure nerdtree
" ---------------------------------------------------------------------------

"autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '__pycache__']
let NERDTreeShowLineNumbers=0
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable='►'
let g:NERDTreeDirArrowCollapsible='▼'
let g:NERDTreeWinPos="left"
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
"  remove trailing white spaces
" ---------------------------------------------------------------------------

map <F12> :call TrimWhiteSpaces()<CR>

func! TrimWhiteSpaces()
    %s/\s*$//
    ''
:endfunction

" ---------------------------------------------------------------------------
"  colours and theming
" ---------------------------------------------------------------------------

set t_Co=256            " set if term supports 256 colours
set t_ut=               " clearing uses the current backgroupd colour

set termguicolors
set background=dark

let g:rehash256 = 1     " molokai mode to match dark gui version

" onedark colour theme
let g:onedark_color_overrides={"background":{"gui":"#111111","cterm":"235","cterm16":"0"}}
let g:onedark_termcolors=256
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=0
colorscheme onedark

" default colour schemes
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
"  make background transparent (set this *after* colorscheme)
" ---------------------------------------------------------------------------

hi Normal guibg=NONE ctermbg=NONE

" ---------------------------------------------------------------------------
"  configure indentline
" ---------------------------------------------------------------------------

let g:indentLine_setColors=1
let g:indentLine_char='⦙'

let g:indentLine_color_term=239
let g:indentLine_color_gui='#444444'

" none x terminal
let g:indentLine_color_tty_light=7 " (default: 4)
let g:indentLine_color_dark=1 " (default: 2)

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

let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

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
"  split and tabbed files
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

" ---------------------------------------------------------------------------
"  syntax checking with ale
" ---------------------------------------------------------------------------

let g:ale_echo_msg_format='[%linter%] %s [%severity%]'
let g:ale_sign_error='✘'
let g:ale_sign_warning='⚠'
let g:ale_lint_on_text_changed='never'

map <C-e> <Plug>(ale_next_wrap)
map <C-r> <Plug>(ale_previous_wrap)

" ---------------------------------------------------------------------------
"  some gui stuff
" ---------------------------------------------------------------------------

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" ---------------------------------------------------------------------------
"  playing around with abriviations
" ---------------------------------------------------------------------------

ab mvg Met vriendelijke groet,<cr>Richard Klein Leugemors<esc><x>

ab html <html><cr><head><cr><tab><title>Title of your page</title><cr><s-tab></head><cr><body><cr></body><cr></html><up><up><cr><tab>

" some handy abbriviations for c
"iab com /*<cr><cr>*/<up>
iab #i #include
iab #d #define

ab forl for (int i = 0; i < ; i++) {<esc>8hi
ab tryb try {<cr>} catch (exception ex) {<cr> ex.printstacktrace();<cr>}<esc>hx3ko
ab const public static final int

ab ctm system.currenttimemillis()
ab slept try {<cr> thread.sleep();<cr>}<esc>hxa catch(exception ex) {<cr> ex.printstacktrace();<cr>}<esc>hx3k$hi

autocmd FileType c iab start #include <stdio.h><cr>
    \#include <stdlib.h><cr>
    \#include <stdbool.h><cr><cr>
    \int main() {<cr>
    \printf("Hello World!\n");<cr><cr>
    \return 0;
    \}<up><up><cr>

"### eof ####################################################################
