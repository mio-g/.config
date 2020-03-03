".vimrc / init.vim
"We try to use the same configuration for both vim and nvim


" vim-plug
call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')

"General {{{

set autoread " Detect when file is changed

set history=1000
set textwidth=120

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

if (has('nvim'))
    let g:python3_host_prog = '~/.Envs/nvim/bin/python'
    "nvim will show substitution results as they written
    "but with no split
    set inccommand=nosplit
endif

set backspace=indent,eol,start "backspace should behave in the same manner
set clipboard^=unnamed,unnamedplus

if has('mouse')
    set mouse=a
endif

"search options
set ignorecase "case insensitive
set smartcase "if search expression contain capital letter, be case-sensitive
set hlsearch "default to highlight results
set incsearch "incremental search like modern browsers
set nolazyredraw "don't redraw while executing macros

set magic "set magic on, for regex

"error bells
set noerrorbells
set visualbell
set t_vb=
set tm=500

"}}} General
"
"Appearance {{{
set relativenumber
set number
set wrap
set wrapmargin=8 "wrap when 8 chars from end of line
set linebreak " 'soft' wrapping
set showbreak=┄ "show ellipsis at breaking
set autoindent
set ttyfast
set diffopt+=vertical
set laststatus=2 "show status line all the time
set scrolloff=3 "context line when vertically close to edge
set wildmenu "enhanced completion
"set hidden "current buffer can be put to background
set showcmd
set shell=$SHELL
set cmdheight=1
set title "terminal title
set showmatch "matching braces
set matchtime=2 "tens of second to show the match
"}}} Appearance

"Tabs {{{
set noexpandtab "use tabs for <tab>
set smarttab " tab respect 'tabstop','shiftwidth','softtabstop'
set tabstop=4 "tab looks like 4 spaces
set softtabstop=4 " edit tab as 4 chars
set shiftwidth=4 " auto indent and '>>','<<' use 4 spaces
set shiftround " round indent to 'shiftwidth
"}}} Tabs

"Folding {{{
set foldmethod=syntax " fold based on indent
set foldlevelstart=99
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " don't fold by default
set foldlevel=1
"}}} Folding

"Invisible Characters {{{
set list
"digraphs are ->, NO, M., >1 and <1 the mapping you are trying to recall is
"c-k
set listchars=tab:→\ ,eol:¬,trail:·,extends:›,precedes:‹
"}}} Invisible Characters

"Colors and cursor {{{
set t_Co=256 "terminal support 256 colors (:h xterm-color)
"switch to line cursor on insert mode
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
\,sm:block-blinkwait175-blinkoff150-blinkon175
"}}}
"
" Airline {{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts=1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='term'
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#whitespace#enabled = 0
" enable airline tabline
let g:airline#extensions#tabline#enabled = 1
" only show tabline if tabs are being used (more than 1 tab open)
let g:airline#extensions#tabline#tab_min_count = 2
" do not show open buffers in tabline
let g:airline#extensions#tabline#show_buffers = 1
" }}}

"Mapping {{{
let mapleader = '\'
"map esc to:
inoremap jk <esc>
inoremap jj <esc>
inoremap kk <esc>

" wipout buffer
nmap <silent> <leader>b :bw<cr>

" shortcut to save
nmap <leader>\ :w<cr>

" shortcut to vsplit
nmap <leader>v :vsplit<cr>

" Clear the search
nmap <F5> :silent noh<cr>

" edit ~/.config/nvim/init.vim
map <leader>ev :e! ~/.config/nvim/init.vim<cr>
" edit gitconfig
map <leader>eg :e! ~/.gitconfig<cr>
" edit .zshrc
map <leader>ez :e! ~/.zshrc<cr>

" activate spell-checking alternatives
nmap ;s :set invspell spelllang=en<cr>

" markdown to html
nmap <leader>md :%!markdown --html4tags <cr>

" remove extra whitespace
nmap <leader>W :%s/\s\+$<cr>
nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

" Toggle unprintable characters visibility
nmap <F6> :set invlist<cr>

" enable . command in visual mode
vnoremap . :normal .<cr>

map <silent> <C-h> :call functions#WinMove('h')<cr>
map <silent> <C-j> :call functions#WinMove('j')<cr>
map <silent> <C-k> :call functions#WinMove('k')<cr>
map <silent> <C-l> :call functions#WinMove('l')<cr>

" move line mappings
" ∆ is <A-j> on macOS
" ˚ is <A-k> on macOS
nnoremap <A-j> :m .+1<cr>==
nnoremap <A-k> :m .-2<cr>==
inoremap <A-j> <Esc>:m .+1<cr>==gi
inoremap <A-k> <Esc>:m .-2<cr>==gi
vnoremap <A-j> :m '>+1<cr>gv=gv
vnoremap <A-k> :m '<-2<cr>gv=gv

" toggle cursor line
nnoremap <leader>i :set cursorline!<cr>

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" search for word under the cursor
nnoremap <leader>/ "fyiw :/<c-r>f<cr>

inoremap <tab> <c-r>=Smart_TabComplete()<CR>


" Plugins {{{
Plug 'christoomey/vim-tmux-navigator'

Plug 'nanotech/jellybeans.vim'

" Wiki
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Indent lines
Plug 'Yggdroot/indentLine'

" search inside files using ack. Same as command line ack utility, but use :Ack
Plug 'mileszs/ack.vim'

" insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" easy commenting motions
Plug 'tpope/vim-commentary'

" Running tests
Plug 'janko-m/vim-test'

" tmux integration for vim
Plug 'benmills/vimux'

" .editorconfig support
Plug 'editorconfig/editorconfig-vim'

" asynchronous build and test dispatcher
Plug 'tpope/vim-dispatch'

" netrw helper
Plug 'tpope/vim-vinegar'

" extended % matching
Plug 'vim-scripts/matchit.zip'

" detect indent style (tabs vs. spaces)
Plug 'tpope/vim-sleuth'

" Writing in vim {{{{
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
let g:limelight_conceal_ctermfg = 240
" }}}

" context-aware pasting
Plug 'sickill/vim-pasta'

" vim-fugitive {{{
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " hub extension for fugitive
nmap <silent> <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <silent><leader>gr :Gread<cr>
nmap <silent><leader>gb :Gblame<cr>
" }}}

" NERDTree {{{
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

" Toggle NERDTree
function! ToggleNerdTree()
    if @% != "" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
        :NERDTreeFind
    else 
        :NERDTreeToggle
    endif
endfunction
" toggle nerd tree
nmap <silent> <leader>p :call ToggleNerdTree()<cr>

let NERDTreeShowHidden=1
" let NERDTreeDirArrowExpandable = '▷'
" let NERDTreeDirArrowCollapsible = '▼'
let g:NERDTreeIndicatorMapCustom = {
\ "Modified"  : "✹",
\ "Staged"    : "✚",
\ "Untracked" : "✭",
\ "Renamed"   : "➜",
\ "Unmerged"  : "═",
\ "Deleted"   : "✖",
\ "Dirty"     : "✗",
\ "Clean"     : "✔︎",
\ 'Ignored'   : '☒',
\ "Unknown"   : "?"
\ }
" }}}

" FZF {{{
	" Plug '/usr/share/doc/fzf/examples/fzf.vim'
	" source /usr/share/doc/fzf/examples/fzf.vim
	Plug '/usr/local/opt/fzf'
	Plug 'junegunn/fzf.vim'
	let g:fzf_layout = { 'down': '~25%' }

	if isdirectory(".git")
		" if in a git project, use :GFiles
		nmap <silent> <leader>. :GFiles --cached --others --exclude-standard<cr>
	else
		" otherwise, use :FZF
		nmap <silent> <leader>. :FZF<cr>
	endif

	nmap <silent> <leader>r :Buffers<cr>
	nmap <silent> <leader>e :FZF<cr>
	nmap <leader><tab> <plug>(fzf-maps-n)
	xmap <leader><tab> <plug>(fzf-maps-x)
	omap <leader><tab> <plug>(fzf-maps-o)

	" Insert mode completion
	imap <c-x><c-k> <plug>(fzf-complete-word)
	imap <c-x><c-f> <plug>(fzf-complete-path)
	imap <c-x><c-j> <plug>(fzf-complete-file-ag)
	imap <c-x><c-l> <plug>(fzf-complete-line)

	nnoremap <silent> <Leader>C :call fzf#run({
	\    'source':
	\      map(split(globpath(&rtp, "colors/*.vim"), "\n"),
	\          "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
	\    'sink':    'colo',
	\    'options': '+m',
	\    'left':    30
	\ })<CR>

	command! FZFMru call fzf#run({
	\  'source':  v:oldfiles,
	\  'sink':      'e',
	\  'options': '-m -x +s',
	\  'down':      '40%'})

	command! -bang -nargs=* Find call fzf#vim#grep(
		\ 'rg --column --line-number --no-heading --follow --color=always '.<q-args>, 1,
		\ <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
" }}}

" signify {{{
Plug 'mhinz/vim-signify'
let g:signify_vcs_list = [ 'git' ]
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change = '!'
" }}}

" ALE {{{
Plug 'w0rp/ale' " Asynchonous linting engine
let g:ale_change_sign_column_color = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
" }}}

" a simple tool for presenting slides in vim based on text files
Plug 'sotte/presenting.vim', { 'for': 'markdown' }


Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'hashivim/vim-hashicorp-tools'


Plug 'sonph/onehalf', {'rtp': 'vim/'}

Plug 'heavenshell/vim-pydocstring'
nmap <silent> <C-r> <Plug>(pydocstring)

Plug 'joshdick/onedark'

Plug 'sjl/splice.vim'
call plug#end()
" highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
" This call must happen after the plug#end() call to ensure
"
" that the colorschemes have been loaded
" IndentLine {{
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0
" }}


syntax on
" colorscheme onedark

Plug 'vim-scripts/YankRing.vim'

" yankring
let g:yankring_replace_n_pkey = '<leader>['
let g:yankring_replace_n_nkey = '<leader>]'

" ,y to show the yankring
nmap <leader>y :YRShow<cr>



" put the yankring_history file in ~/.backup
let g:yankring_history_dir = '~/.backup'

" make comments 
highlight Comment cterm=italic

filetype plugin indent on
" make the highlighting of tabs and other non-text less annoying
highlight SpecialKey ctermfg=236
highlight NonText ctermfg=236


" Threesome.vim
"
