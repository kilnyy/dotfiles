" ===============================
" Xu Mingzhao's .vimrc
" for vim8 only currently
" ===============================


" ===============================
" Plugins
" ===============================

if empty(glob('~/.vim/autoload/plug.vim'))
    !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')

Plug 'ap/vim-css-color', { 'for': 'css' }
Plug 'veloce/vim-aldmeris'

Plug 'Glench/Vim-Jinja2-Syntax', { 'for': 'jinja' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'toyamarinyon/vim-swift', { 'for': 'swift' }

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeTabsToggle' }
Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeTabsToggle' }
Plug 'vim-scripts/taglist.vim', { 'on': 'TlistToggle' }
Plug 'vim-scripts/matchit.zip'

Plug 'Raimondi/delimitMate'
Plug 'mattn/emmet-vim'
Plug 'godlygeek/tabular'

Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'

Plug 'tpope/vim-fugitive'

Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

Plug 'easymotion/vim-easymotion'

if executable("ctags")
    Plug 'ludovicchabant/vim-gutentags'
endif
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/echodoc.vim'
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'neomake/neomake'
Plug 'sbdchd/neoformat'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neomru.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all', 'on': 'FZF' }

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'

function! BuildYCM(info)
    let l:args = " --clang-completer"
    if executable("go")
        let l:args = l:args . " --go-completer"
    endif
    if executable("node") && executable("nmp")
        let l:args = l:args . " --js-completer"
    endif
    if executable("javac")
        let l:args = l:args . " --java-completer"
    endif
    if a:info.status == 'installed' || a:info.force
        exec "!./install.py" . l:args
    endif
endfunction

Plug 'kilnyy/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

if has('mac')
    Plug 'zerowidth/vim-copy-as-rtf', { 'on': 'CopyRTF' }
    Plug 'rizzatti/dash.vim'
endif

call plug#end()

" ===============================
" Basic Configs
" ===============================

set number
set incsearch
set statusline=%<%f\ %{fugitive#statusline()}\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2
set mouse=a
set backspace=indent,eol,start
set noshowmode

syntax on

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wildmode=longest,list
set wildmenu

augroup file_type_tabs
    au FileType tex setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
    au FileType erlang setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
    au FileType go setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
    au FileType java setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
    au FileType cpp setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
    au FileType c setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
    au FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
    au FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120

    au FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
    au FileType coffee,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
    au FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
    au FileType scss setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
    au FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
    au FileType jinja setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
augroup end

set magic
set smartindent
set whichwrap=h,l,b,s,<,>,[,]

color aldmeris
set nohlsearch
set nobackup
set autochdir

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,chinese,cp936

set statusline+=%#warningmsg#
set statusline+=%*

hi Cursorline ctermbg=236
hi ColorColumn ctermbg=black

set completeopt=longest,menuone

filetype plugin on

if has('gui_running')
    set guifont=Monaco:h14
    set columns=170
    set lines=40
else
    set mouse=a
    set clipboard+=unnamed
endif

" ===============================
" Functions
" ===============================

function! Compile()
    if &filetype ==? 'cpp'
        exec '!g++ % -g -o %< -Wall -O2'
    endif
    if &filetype ==? 'c'
        exec '!gcc % -g -o %< -Wall'
    endif
    if &filetype ==? 'tex'
        exec '!xelatex %'
    endif
    if &filetype ==? 'java'
        exec '!javac %'
    endif
    echo 
    if &filetype ==? 'nasm'
        exec '!nasm -f macho % ; ld -macosx_version_min 10.7.0 -o %< %<.o'
    endif
endfunc

function! Run()
	if &filetype ==? 'html'
		exec '!chrome %'
	endif
	if &filetype ==? 'python'
		exec '!python %'
	endif
	if &filetype ==? 'erlang'
		exec '!escript %'
	endif
	if &filetype ==? 'go'
		exec '!go run %'
	endif
    if &filetype ==? 'cpp' || &filetype ==? 'c' || &filetype ==? 'nasm'
        exec '!./%<'
    endif
    if &filetype ==? 'java'
        exec '!java %<'
    endif
    if &filetype ==? 'sh'
        exec '!sh %'
    endif
endfunc

function! MaximizeToggle()
    if exists('s:maximize_session')
        exec 'source ' . s:maximize_session
        call delete(s:maximize_session)
        unlet s:maximize_session
        let &hidden=s:maximize_hidden_save
        unlet s:maximize_hidden_save
    else
        let s:maximize_hidden_save = &hidden
        let s:maximize_session = tempname()
        set hidden
        exec 'mksession! ' . s:maximize_session
        only
    endif
endfunction

" ===============================
" Key Bindings
" ===============================

imap <F5> <esc>:call Run()<cr>
map <F5> <esc>:call Run()<cr>
vmap <F5> <esc>:call Run()<cr>

imap <F7> <esc>:call Compile()<cr>
map <F7> <esc>:call Compile()<cr>
vmap <F7> <esc>:call Compile()<cr>

imap <F6> <esc>:call Debug()<cr>
map <F6> <esc>:call Debug()<cr>
vmap <F6> <esc>:call Debug()<cr>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

map <silent><F10> <esc>:tabnew<cr>:e ~/.vimrc<cr>
map <silent><F9> <esc>:TlistToggle<cr>
map <silent><F8> <esc>:NERDTreeTabsToggle<cr>

"Mapping Alt keys for old terminal
function! BindAlt(c)
    exec "set <A-".a:c.">=\e".a:c
    exec "imap \e".a:c." <A-".a:c.">"
endfunc
set ttimeout ttimeoutlen=50
set timeout ttimeoutlen=50

for g:c in ['%','\"','{','}','1','2','3','4','5','6','z','s','t','f','/', 'H', "J", "K", "L"]
    call BindAlt(g:c)
endfor

nmap <C-h> <C-w><C-h>
nmap <C-j> <C-w><C-j>
nmap <C-k> <C-w><C-k>
nmap <C-l> <C-w><C-l>

nmap <M-s> <Plug>(easymotion-overwin-f2)
nmap <silent><M-z> :call MaximizeToggle()<cr>
nmap <silent><M-f> :Denite file_mru file_rec buffer<cr>
nmap <silent><M-/> :Denite line<cr>

noremap <silent><M-%> :vsplit<cr><C-w><C-l>
noremap <silent><M-"> :split<cr><C-w><C-j>
noremap <silent><M-{> :tabp<cr>
noremap <silent><M-}> :tabn<cr>
noremap <silent><M-t> :tabnew<cr>
noremap <silent><M-1> :tabn 1<cr>
noremap <silent><M-2> :tabn 2<cr>
noremap <silent><M-3> :tabn 3<cr>
noremap <silent><M-4> :tabn 4<cr>
noremap <silent><M-5> :tabn 5<cr>
noremap <silent><M-6> :tabn 6<cr>

augroup go_shortcuts
    au FileType go nmap <Leader>i <Plug>(go-implements)
    au FileType go nmap <Leader>gd <Plug>(go-doc)
    au FileType go nmap <leader>r <Plug>(go-run)
    au FileType go nmap <leader>b <Plug>(go-build)
    au FileType go nmap <leader>t <Plug>(go-test)
    au FileType go nmap <leader>c <Plug>(go-coverage)
    au FileType go nmap gd <Plug>(go-def)
augroup end

" ===============================
" Plugins Configs
" ===============================

let g:Tlist_Use_Right_Window = 1


let g:NERDTreeWinPos = 'left'
let g:NERDTreeWinSize = 20
let g:nerdtree_tabs_smart_startup_focus = 2
let g:nerdtree_tabs_autofind = 1

let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1

let g:vim_markdown_folding_disabled=1

let g:go_fmt_command = 'goimports'

if empty(glob('~/.vim/.ycm_extra_conf.py'))
    !curl -fLo ~/.vim/.ycm_extra_conf.py --create-dirs
        \ https://raw.githubusercontent.com/JDevlieghere/dotfiles/master/.vim/.ycm_extra_conf.py
endif
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
let g:ycm_auto_trigger=0
noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
\ 'cs,lua,javascript': ['re!\w{2}'],
\ }

let g:echodoc_enable_at_startup = 1

let g:gutentags_project_root = ['.git']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
if !isdirectory(s:vim_tags)
  silent! call mkdir(s:vim_tags, 'p')
endif

if executable('ag')
    call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
    call denite#custom#var('grep', 'command', ['ag'])
endif

call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<Up>', '<denite:move_to_previous_line>')

call denite#custom#option('default', 'highlight_mode_insert', 'WildMenu')

let g:neomake_python_pylint_args = [
    \ '--disable=W0621,C0103,R0902,R0903',
    \ '--output-format=text',
    \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg} [{msg_id}]"',
    \ '--reports=no'
\ ]

call neomake#configure#automake('nw', 750)

let g:columns=join(range(81,400),",")

let &colorcolumn=g:columns
set cursorline
augroup activate_window_highlight
    autocmd!
    autocmd WinEnter * let &colorcolumn=g:columns
    autocmd WinLeave * set colorcolumn=0
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
augroup END

autocmd InsertEnter * imap <expr> <tab> <SID>tab_map()

function! <SID>tab_map()
    if pumvisible()
        return "\<C-n>"
    end
    " If previous character is space then <Tab> insert a tab.
    let column = col('.')
    if column == 1 || match( getline('.')[column-2], '\s' ) == 0
        return "\<Tab>"
    end

    return "\<C-z>"
endf
