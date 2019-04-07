set nocompatible              " be iMproved, required
filetype plugin indent on

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" <============================================>
" Specify the plugins you want to install here.
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
"Plugin 'vim-syntastic/syntastic' 
Plugin 'nvie/vim-flake8'
"Plugin 'tmhedberg/SimpylFold'
Plugin 'kalekundert/vim-coiled-snake'
Plugin 'Konfekt/FastFold'
Plugin 'scrooloose/nerdcommenter'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'christoomey/vim-tmux-navigator'
"Plugin 'Shougo/echodoc'
"Plugin 'klen/python-mode'

" Markdown
Plugin 'shime/vim-livedown'
Plugin 'tpope/vim-markdown'

"Others
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

"Color Schemes
Plugin 'liuchengxu/space-vim-dark'
Plugin 'cormacrelf/vim-colors-github'
" <============================================>
" All of your Plugins must be added before the following line

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line" 
" Put the rest of your .vimrc file here

" === Folding
nnoremap <space> za
nnoremap za zM
nnoremap zj ]z
nnoremap zk [z

set foldmethod=indent
"set foldlevel=1
"set foldnestmax=2
" folding display
function! NeatFoldText()
	let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
	let lines_count = v:foldend - v:foldstart + 1
	let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
	let foldchar = matchstr(&fillchars, 'fold:\zs.')
	let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
	let foldtextend = lines_count_text . repeat(foldchar, 8)
	let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
	return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

set foldtext=NeatFoldText()

" === Commenting
" Shortcut for commenting
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

let g:NERDDefaultAlign = 'left'

" === Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 0
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" === Python PEP8
au BufNewFile,BufRead *.py
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set textwidth=79 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix |
	\ set cinwords=if,elif,else,for,while,try,except,finally,def,class,with 
au BufNewFile,BufRead *.md
	\ set softtabstop=2 |
	\ set shiftwidth=2 |
	\ set autoindent |
	\ set fileformat=unix |
	\ colorscheme space-vim-dark

" === NERDTree
" Shortcut to open NERDTree (Ctrl-n)
map <C-n> :NERDTreeToggle<CR>
" Symbols
let g:NERDTreeDirArrowExpandable='>'
let g:NERDTreeDirArrowCollapsible='v'
" Close vim if only nerdtree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" === YouCompleteMe
" python semantic completion
"
let g:ycm_seed_identifiers_with_syntax = 1 "for builtin functions
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 0
set splitbelow
let g:ycm_python_binary_path='python'
let g:ycm_semantic_triggers = {
						\ 'python': ['re!\w{4}', 're!from\s+\S+\s+import\s']
						\} "autocomplete for from x import y type of imports
nnoremap " :YcmCompleter GetDoc<CR>
"
" === Syntax Checking/Highlighting
"let python_highlight_all=1
syntax on

" === Snippets
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger = "<nop>"
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-tab>'
let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
	let snippet = UltiSnips#ExpandSnippetOrJump()
	if g:ulti_expand_or_jump_res > 0
	return snippet
	else
	return "\<CR>"
	endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" === Relative Numbering
:set relativenumber!

" === General Mappings
" Panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" Save
noremap <C-w>w <Esc>:w<CR>
" Exit (same as tmux)
noremap <C-d> <Esc>:q<CR>
" View command line
nnoremap ~ :!echo<CR>
" Cut, Copy and Paste from + register
:inoremap <C-v> <ESC>"+pa
:vnoremap <C-c> "+y
:vnoremap <C-x> "+d

" === Python Autopep8
let g:autopep8_on_save = 1
autocmd FileType python noremap <buffer> <C-P> :call Autopep8()<CR>
" === Python Write and Run File
au FileType python map <C-e> <Esc>:w<CR>:!clear;python %<CR>

" === Python Flake8
autocmd FileType python map <buffer> <C-F> :call Flake8()<CR>

" === Other configs
set nu
set noswapfile
set formatoptions-=tc
set background=dark
set tabstop=4 |

" highlight when text length exceed 80 char
highlight OverLength ctermbg=red ctermfg=white guibg=#111111 
match OverLength /\%81v.\+/ 

" toggle highlight when text length exceed 80 char
let s:activatedh = 1 
function! ToggleH()
	highlight OverLength ctermbg=red ctermfg=white guibg=#111111
    if s:activatedh == 0
        let s:activatedh = 1 
		highlight OverLength ctermbg=red ctermfg=white guibg=#111111
        match OverLength '\%>80v.\+'
    else
        let s:activatedh = 0 
        match none
    endif
endfunction

nnoremap <leader>1 :call ToggleH()<CR>

hi Folded ctermbg=0

let g:markdown_folding = 1
