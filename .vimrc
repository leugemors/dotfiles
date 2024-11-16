"############################################################################
"##         _    _
"##    _ __| | _| |
"##   | '__| |/ / |   Richard Klein Leugemors
"##   | |  |   <| |   https://www.github.com/leugemors/
"##   |_|  |_|\_\_|
"##
"##   Type  :so ~/.vimrc  to refresh after making changes.
"##
"############################################################################

" ---------------------------------------------------------------------------
"  some required settings for the plugins
" ---------------------------------------------------------------------------

set nocompatible      " no need to be compatible with the original vi
filetype off          " needs to be switched off while loading plugins

" ---------------------------------------------------------------------------
"  manage plugins (use :PlugInstall :PlugClean :PlugUpdate, etc.)
" ---------------------------------------------------------------------------

" check if we need to install the plugins first
let need_to_install_plugins = 0

" install the plugin manager when needed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let need_to_install_plugins = 1
endif

" list of all the plugins I like to use
call plug#begin('~/.vim/plugged')

  " a nice statusbar
  Plug 'vim-airline/vim-airline'                 " airline statusbar
  Plug 'vim-airline/vim-airline-themes'          " themes for statusbar

  " nerdtree file management
  Plug 'preservim/nerdtree'                      " nerdtree
  Plug 'ryanoasis/vim-devicons'                  " icons for nerdtree
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " highlighting nerdtree
  Plug 'Xuyuanp/nerdtree-git-plugin'             " git support for nerdtree

  " productivity
  Plug 'airblade/vim-gitgutter'                  " show git diff per line
  Plug 'alvan/vim-closetag'                      " auto close (x)html tags
  Plug 'chrisbra/csv.vim'                        " work with csv files
  Plug 'dense-analysis/ale'                      " some syntax checking
  " Plug 'jiangmiao/auto-pairs'                    " auto pair brackets
  Plug 'majutsushi/tagbar'                       " use ctags in vim
  Plug 'suan/vim-instant-markdown'               " markdown support
  Plug 'stylelint/stylelint'                     " css linter
  Plug 'tpope/vim-commentary'                    " bulk (un)command lines

  " colours and syntax highlighting
  Plug 'ap/vim-css-color'                        " show hex colours
  Plug 'frazrepo/vim-rainbow'                    " rainbow brackets for vim
  Plug 'kshenoy/vim-signature'                   " show marks before the line number
  Plug 'sheerun/vim-polyglot'                    " support for many languages
  Plug 'Yggdroot/indentLine'                     " visualize indentions

  " colour themes
  Plug 'dracula/vim', { 'as': 'dracula' }        " dracula colour theme
  Plug 'morhetz/gruvbox'                         " gruvbox colour theme
  Plug 'joshdick/onedark.vim'                    " onedark colour theme

  " integrate some external tools
  Plug 'vifm/vifm.vim'                           " vi file manager
  Plug 'vimwiki/vimwiki'                         " taking notes within vim

call plug#end()

" install all the plugins when needed
if need_to_install_plugins == 1
  echo "Installing plugins..."
  silent! PlugInstall
  echo "Done!"
  q
endif

" ---------------------------------------------------------------------------
"  enable filetype plugins
" ---------------------------------------------------------------------------

filetype plugin indent on

" ---------------------------------------------------------------------------
"  basic settings
" ---------------------------------------------------------------------------

set autoread                   " auto read when a file has changed from outside
set backspace=start,eol,indent " better use of backspace
set clipboard=unnamedplus      " copy/paste between vim and other programs
set colorcolumn=80             " show a line at column 80
set cursorline                 " underline the current line
set hidden                     " needed to keep multiple buffers open
set history=2000               " how many lines of history should vim remember
set lazyredraw                 " don't redraw while executing macros
set magic                      " turn magic on for regular expressions
set numberwidth=5              " set width for numbers to 5
set scrolloff=3                " show 3 lines to the cursor
syntax on                      " enable syntax highlighting

" ---------------------------------------------------------------------------
"  no annoying sounds or errors
" ---------------------------------------------------------------------------

set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=500

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
"  move through split windows
" ---------------------------------------------------------------------------

nmap <leader><Up> :wincmd k<cr>
nmap <leader><Down> :wincmd j<cr>
nmap <leader><Left> :wincmd h<cr>
nmap <leader><Right> :wincmd l<cr>

" ---------------------------------------------------------------------------
"  move through buffers
" ---------------------------------------------------------------------------

nmap <leader>[ :bp!<cr>
nmap <leader>] :bn!<cr>
nmap <leader>x :bp<bar>bd#<cr>

" ---------------------------------------------------------------------------
"  toggle line numbers and wrapping for easier copying
" ---------------------------------------------------------------------------

"set relativenumber
set number
set nowrap

map <F3> :set number!<cr>
map <F4> :set relativenumber!<cr>
map <F5> :set wrap!<cr>

" ---------------------------------------------------------------------------
"  remove trailing white spaces
" ---------------------------------------------------------------------------

map <F12> :call TrimWhiteSpaces()<cr>

func! TrimWhiteSpaces()
  %s/\s*$//
  ''
:endfunction

" ---------------------------------------------------------------------------
"  use line cursor in insert mode and block cursor everywhere else
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
"  setup code folding
" ---------------------------------------------------------------------------

set foldmethod=indent
set foldlevel=99

nnoremap <space> za

" ---------------------------------------------------------------------------
"  status line (set colour with colour themes)
" ---------------------------------------------------------------------------

let g:airline_powerline_fonts = 1
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

" mouse support breaks the copy/past functionality
" set mouse=a

" ---------------------------------------------------------------------------
"  configure nerdtree
" ---------------------------------------------------------------------------

nnoremap <leader>n :NERDTreeFocus<cr>
nnoremap <leader>f :NERDTreeFind<cr>
nnoremap <C-n> :NERDTreeToggle<cr>

let NERDTreeIgnore=['\.pyc$', '__pycache__']
let NERDTreeMinimalUI=0
let NERDTreeShowLineNumbers=0
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable=''
let g:NERDTreeDirArrowCollapsible='▼'
let g:NERDTreeWinPos="left"
let g:NERDTreeWinSize=42

" start nerdtree and put the cursor back in the other window
" autocmd vimenter * NERDTree | wincmd p

" exit vim if nerdtree is the only window remaining in the only tab
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" clsoe tab if nerdtree is the only window remaining on it
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" open existing nerdtree on each new tab
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" ---------------------------------------------------------------------------
"  settings for tags
" ---------------------------------------------------------------------------

map <C-t> :TagbarToggle<cr>

" show the tagbar
" autocmd vimenter * TagbarToggle

" unfold all tags to one level
" autocmd vimenter * TagbarSetFoldlevel! 1

" ---------------------------------------------------------------------------
"  settings for markdown support
" ---------------------------------------------------------------------------

let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
let g:instant_markdown_open_to_the_world = 1
let g:instant_markdown_allow_unsafe_content = 1
let g:instant_markdown_allow_external_content = 0
let g:instant_markdown_mathjax = 1
let g:instant_markdown_mermaid = 1
let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
let g:instant_markdown_autoscroll = 0
let g:instant_markdown_port = 8888
let g:instant_markdown_python = 1
let g:instant_markdown_theme = 'dark'

" ---------------------------------------------------------------------------
"  colours and theming
" ---------------------------------------------------------------------------

set t_Co=256            " set if term supports 256 colours
set t_ut=               " clearing uses the current backgroupd colour

set termguicolors
set background=dark

let g:rehash256 = 1     " molokai mode to match dark gui version

set fillchars+=vert:│   " <Ctrl><K> <v><v>

" onedark colour theme
" let g:airline_theme='onedark'
" let g:onedark_color_overrides={"background":{"gui":"#222222","cterm":"235","cterm16":"0"}}
" let g:onedark_termcolors=256
" let g:onedark_hide_endofbuffer=1
" let g:onedark_terminal_italics=1
" colorscheme onedark

" dracula colour theme
let g:airline_theme='dracula'
let g:dracula_bold = 1                        " include bold attributes in highlighting
let g:dracula_italic = 1                      " include italic attributes in highlighting
let g:dracula_underline = 1                   " include underline attributes in highlighting
let g:dracula_undercurl = 1                   " include undercurl attributes in highlighting
let g:dracula_full_special_attrs_support = 1  " declare full support for special attributes
let g:dracula_high_contrast_diff = 1          " use high-contrast color when in diff mode
let g:dracula_inverse = 1                     " include inverse attributes in highlighting
let g:dracula_colorterm = 0                   " include background fill colors (0 for transp bg)
colorscheme dracula

" grubbox colour theme
" let g:airline_theme='gruvbox'
" let g:gruvbox_termcolors=256
" colorscheme gruvbox

" default colour schemes
" colorscheme blue
" colorscheme darkblue
" colorscheme default
" colorscheme delek
" colorscheme desert
" colorscheme elflord
" colorscheme evening
" colorscheme industry
" colorscheme koehler
" colorscheme morning
" colorscheme murphy
" colorscheme pablo
" colorscheme peachpuff
" colorscheme ron
" colorscheme shine
" colorscheme slate
" colorscheme torte
" colorscheme zellner

" ---------------------------------------------------------------------------
"  configure indentline
" ---------------------------------------------------------------------------

let g:indentLine_setColors=1
let g:indentLine_char='|'

let g:indentLine_color_term=239
let g:indentLine_color_gui='#333333'

" none x terminal
let g:indentLine_color_tty_light=7 " (default: 4)
let g:indentLine_color_dark=1 " (default: 2)

" ---------------------------------------------------------------------------
"  autopair brackets
" ---------------------------------------------------------------------------

" au FileType python let b:AutoPairs = AutoPairsDefine({"f'" : "'", "r'" : "'", "b'" : "'"})

" set showmatch      " show matching brackets
" set mat=2          " blink 0.2 seconds when matching brackets

" ---------------------------------------------------------------------------
"  settings for vifm
" ---------------------------------------------------------------------------

map <Leader>vv :Vifm<cr>
map <Leader>vs :VsplitVifm<cr>
map <Leader>sp :SplitVifm<cr>
map <Leader>dv :DiffVifm<cr>
map <Leader>tv :TabVifm<cr>

" ---------------------------------------------------------------------------
"  settings for vimwiki (use \ww)
" ---------------------------------------------------------------------------

let g:vimwiki_list = [{'path': '~/.local/share/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" ---------------------------------------------------------------------------
"  open a terminal inside vim
" ---------------------------------------------------------------------------

set termwinsize=16*0

" vim-powered terminal in split window
map <Leader>t :term ++close<cr>
tmap <Leader>t <c-w>:term ++close<cr>

" vim-powered terminal in new tab
map <Leader>T :tab term ++close<cr>
tmap <Leader>T <c-w>:tab term ++close<cr>

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
noremap <silent> <C-Left> :vertical resize +3<cr>
noremap <silent> <C-Right> :vertical resize -3<cr>
noremap <silent> <C-Up> :resize +3<cr>
noremap <silent> <C-Down> :resize -3<cr>

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

let g:ale_completion_enabled=1

map <C-e> <Plug>(ale_next_wrap)
map <C-r> <Plug>(ale_previous_wrap)

nmap gd :ALEGoToDefinition<cr>
nmap gr :ALEFindReferences<cr>

nmap K :ALEHover<cr>

" nmap gd :ALEGoToDefinitionInSplit<cr>
" nmap gd :ALEGoToDefinitionInVSplit<cr>
" nmap gd :ALEGoToDefinitionInTab<cr>

" ---------------------------------------------------------------------------
"  playing around with abriviations
" ---------------------------------------------------------------------------

ab mvg Met vriendelijke groet,<cr>Richard Klein Leugemors<esc><x>

" ab html <html><cr><head><cr><tab><title>Title of your page</title><cr><s-tab></head><cr><body><cr></body><cr></html><up><up><cr><tab>

" some handy abbriviations for c
" iab com /*<cr><cr>*/<up>
" iab #i #include
" iab #d #define

" ab forl for (int i = 0; i < ; i++) {<esc>8hi
" ab tryb try {<cr>} catch (exception ex) {<cr> ex.printstacktrace();<cr>}<esc>hx3ko
" ab const public static final int

" ab ctm system.currenttimemillis()
" ab slept try {<cr> thread.sleep();<cr>}<esc>hxa catch(exception ex) {<cr> ex.printstacktrace();<cr>}<esc>hx3k$hi

" autocmd FileType c iab start #include <stdio.h><cr>
    " \#include <stdlib.h><cr>
    " \#include <stdbool.h><cr><cr>
    " \int main() {<cr>
    " \printf("Hello World!\n");<cr><cr>
    " \return 0;
    " \}<up><up><cr>

"### eof ####################################################################
