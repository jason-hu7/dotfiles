" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" enable file type detection
filetype plugin indent on

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" vim can autodetect this based on $TERM (e.g. 'xterm-256color')
" but it can be set to force 256 colors
" set t_Co=256
if has('gui_running')
    colorscheme gruvbox
    let g:lightline = {'colorscheme': 'gruvbox'}
elseif &t_Co < 256
    colorscheme default
    set nocursorline " looks bad in this mode
else
    set background=dark
    colorscheme gruvbox
    " customized colors
    let g:lightline = {'colorscheme': 'gruvbox'}
    highlight SpellBad cterm=underline
    " patches
    highlight CursorLineNr cterm=NONE
endif

"----------------------------
" Basic editing configuration
"----------------------------
set number " Show line numbers
set relativenumber " This enables relative line numbering mode
set laststatus=2 " Always show the status line at the bottom
set mouse+=a " Enable mouse support
set incsearch " Enable searching as you type, rather than waiting till you press enter
set hidden " Allow hidding unsaved buffer
set ignorecase " search case-insensitive when all characters in the string being searched at lowercase
set smartcase  "case-sensitive if contain capital letters
set lbr " line break
set wildmode=longest,list "" tab completion for files/bufferss
set wildmenu
set showmatch " highlight matching [{()}]
set scrolloff=5 " show lines above and below cursor (when possible)
" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
set autoindent " automatic indentation
set cursorline " highlight current line
set tabstop=4 " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set expandtab " tabs are spaces, mainly because of python
set autochdir " automatically set current directory to directory of last opened file

"---------------------
" Plugin configuration
"---------------------

" nerdtree
"""""""""""""""""""""""""""""""""""""
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>
let NERDTreeShowHidden=0

" buffergator
"""""""""""""""""""""""""""""""""""""
let g:buffergator_suppress_keymaps = 1
nnoremap <Leader>b :BuffergatorToggle<CR>

" ctrlp
"""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_show_hidden = 1 " show hidden files

" easymotion
"""""""""""""""""""""""""""""""""""""
map <Space> <Plug>(easymotion-prefix)

" Vim Markdown
"""""""""""""""""""""""""""""""""""""
let g:markdown_fenced_languages = [
    \ 'bash=sh',
    \ 'c',
    \ 'coffee',
    \ 'erb=eruby',
    \ 'javascript',
    \ 'json',
    \ 'perl',
    \ 'python',
    \ 'ruby',
    \ 'yaml',
    \ 'go',
\]
let g:vim_markdown_conceal = 2

" syntastic
"""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
nnoremap <Leader>s :SyntasticCheck<CR>
nnoremap <Leader>r :SyntasticReset<CR>
nnoremap <Leader>i :SyntasticInfo<CR>
nnoremap <Leader>m :SyntasticToggleMode<CR>

" incsearch
"""""""""""""""""""""""""""""""""""""
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" jedi-vim
"""""""""""""""""""""""""""""""""""""
let g:jedi#force_py_version = 3
let g:jedi#popup_on_dot = 0
let g:jedi#goto_stubs_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#usages_command = ""
let g:jedi#show_call_signatures = "2"

"" vim-mucomplete
set completeopt-=preview
set completeopt+=noselect,menuone
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 1

" gundo
""""""""""""""""""""""""""""""""""""
nnoremap <Leader>u :GundoToggle<CR>
if has('python3')
    let g:gundo_prefer_python3 = 1
endif

" argwrap
""""""""""""""""""""""""""""""""""""
nnoremap <Leader>w :ArgWrap<CR>
