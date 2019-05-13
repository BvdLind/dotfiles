" My Vimrc

nnoremap <Space> <Nop>
let mapleader=" "
let maplocalleader=","

" Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'prettier/vim-prettier', { 'do': 'yarn install' }
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/gv.vim'
Plugin 'ervandew/supertab'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-vinegar'
Plugin 'EinfachToll/DidYouMean'
Plugin 'w0rp/ale'
Plugin 'airblade/vim-gitgutter'
Plugin 'mhinz/vim-startify'
Plugin 'matze/vim-move'
Plugin 'junegunn/vim-easy-align'
Plugin 'itmammoth/doorboy.vim'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'airblade/vim-accent'
Plugin 'machakann/vim-highlightedyank'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'junegunn/fzf.vim'
Plugin 'romainl/vim-devdocs'
"Plugin 'junegunn/goyo.vim'

" Language related
Plugin 'leafgarland/typescript-vim'
Plugin 'mxw/vim-jsx'
Plugin 'nelsyeung/twig.vim'
Plugin 'pangloss/vim-javascript'

" Color Themes
Plugin 'dylanaraps/wal.vim'
Plugin 'joshdick/onedark.vim'
"Plugin 'morhetz/gruvbox'
"Plugin 'ayu-theme/ayu-vim'
"Plugin 'ajh17/spacegray.vim'
"Plugin 'dracula/vim'
"Plugin 'tomasr/molokai'
"Plugin 'jacoborus/tender.vim'
"Plugin 'arcticicestudio/nord-vim'
"Plugin 'yuttie/hydrangea-vim'
"Plugin 'tyrannicaltoucan/vim-deep-space'

call vundle#end()
filetype plugin on

colorscheme wal

" Basic stuff
syntax on
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab
set autoindent
set textwidth=80
set smartindent
set number
set relativenumber
set nocompatible
set encoding=utf-8
set laststatus=2
set showmode
set showcmd
set showmatch
set nowrap
set pastetoggle=<f2>
set history=1000
set ttyfast
set mouse=a
set mousehide
set magic
set noshowmode
set completeopt-=preview
set confirm
set cursorline
set background=dark
hi cursorWinLeaveline cterm=none term=none
autocmd InsertLeave * setlocal cursorline
autocmd InsertEnter * setlocal nocursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine cterm=none guibg=#303000 ctermbg=blue
highlight CursorLineNr guibg=#303000 ctermbg=blue

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
   au!
   au BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \     execute 'normal! g`"zvzz' |
       \ endif
augroup END

" Spelling
map <F6> :setlocal spell! spelllang=en<CR>
map <F7> :set spelllang=nl<CR>
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

autocmd BufWritePre * %s/\s\+$//e " Automatically deletes trailing whitespace

func! CurrentFileDir(cmd)
   return a:cmd . " " . expand("%:p:h") . "/"
endfunc

" Split sizing and -location
set splitbelow splitright
nnoremap <silent> <leader>> :5winc <<CR>
nnoremap <silent> <leader>< :5winc ><CR>
nnoremap <silent> <leader>+ :5winc +<CR>
nnoremap <silent> <leader>_ :5winc -<CR>
nnoremap <silent> <leader>= <C-W>=<CR>

" Copy selected text to system clipboard
vnoremap <C-c> "+y
map <C-v> "+P

" Toggle wrap
nnoremap <leader>WT :set wrap!<CR>

" Fix missing syntax highlighting ts files
au BufRead,BufNewFile *.ts setfiletype typescript

" Format prettier
let g:prettier#autoformat = 1
let g:prettier#config#single_quote = 'true'
nnoremap <leader>p :Prettier<CR>

let g:livepreview_previewer = 'zathura'

" Latex
let g:tex_flavor = "latex"
map <leader>co :!pdflatex % && zathura %:r.pdf<CR>
map <leader>xe :!xelatex % && zathura %:r.pdf<CR>
map <leader>bi :!bibtex8 %:r<CR>

" Markdown
map <leader>mc :!pandoc % -t beamer -o %:r.pdf<CR>

" Open current file in chrome
map <leader>fr :!firefox %<CR>

" Run live-server for current file
map <leader>L :!live-server %<CR>

" Netrw
let g:netrw_banner = 0 " Disable banner
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+,\(^\|\s\s\)ntuser\.\S\+'
autocmd FileType netrw set nolist
let g:netrw_liststyle = 3 "Open in prior window
let g:netrw_browse_split = 4 "Open splits to the right
let g:netrw_altv = 1
let g:netrw_winsize = 20

" FZF
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>- :Files <C-r>=expand("%:h")<CR>/<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>]  :Tags<CR>
nnoremap <silent> <leader>b] :BTags<CR>
let g:fzf_commits_log_options = '--graph --color=always
  \ --format="%C(yellow)%h%C(red)%d%C(reset)
  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'
nnoremap <silent> <leader>c  :Commits<CR>
nnoremap <silent> <leader>bc :BCommits<CR>
"let g:fzf_action = {
  "\ 'ctrl-t': 'tab split',
  "\ 'ctrl-i': 'split',
  "\ 'ctrl-s': 'vsplit' }
let g:fzf_layout = { 'down': '~25%' }

let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
set grepprg=rg\ --vimgrep

" Access my vimrc mappings
nnoremap <leader>sev :vsplit $MYVIMRC<CR>
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :w<CR> :so $MYVIMRC<CR>

" Abbreviations
iab @@ bvanderlinden1@gmail.com
iab ccopy copyright 2018 Bas van der Linden, all rights reserved.
iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit
iab llorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi
iab lllorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.  Integer hendrerit lacus sagittis erat fermentum tincidunt.  Cras vel dui neque.  In sagittis commodo luctus.  Mauris non metus dolor, ut suscipit dui.  Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum.  Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor

nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel " Surround with double quotes

" File path completion
imap <localleader><localleader> <C-X><C-F>

set directory^=/tmp/ " Swap files are stored here

set statusline=%f\ -\ FileType:\ %y

"set termguicolors     " enable true colors support
"let ayucolor="dark" " for mirage version of theme

"if !has("gui_running")
"  if !has("nvim")
"    set term=xterm
"  endif
"  set t_Co=256
"  let &t_AB="\e[48;5;%dm"
"  let &t_AF="\e[38;5;%dm"
"endif

" Remapping backaspace behavior because of xterm
inoremap <Char-0x07F> <BS>
nnoremap <Char-0x07F> <BS>

" Kill window
nnoremap K :q<cr>

" Man
nnoremap M K

" Toggle line numbers and relative line numbers
nnoremap <leader>n :setlocal number!<cr> :setlocal relativenumber!<cr>

" Yank to end of line
nnoremap Y y$

" Select entire buffer
nnoremap vaa ggvGg_
nnoremap Vaa ggVG

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Substitute
nnoremap <c-s> :%s/
vnoremap <c-s> :s/

" Open current directory in Finder
nnoremap <leader>O :!nnn .<cr>

" Easy way to open file
nnoremap <leader>e :e<Space>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Easier to type motions
noremap H ^
noremap L $
noremap L g_

" Map ; to : for fewer keystrokes
nnoremap ; :
vmap ; :

" Remap repeat motion
nnoremap <localleader>; ;

inoremap <C-Space> <C-x><C-o>

nmap <silent> <leader>/ :nohlsearch<CR>

" Easier saving
map F :w!<CR>
imap  <esc>:w!<CR>i

" Fugitive mappings
set diffopt=vertical
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Git add %<cr>
nnoremap <leader>gaa :Git add .<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Git checkout<Space>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gmv :Gmove<Space>
nnoremap <leader>gr :Gremove<cr>

" vim surround
map <leader>S ySiw
map <leader>s ysiw

" qq to record, Q to replay
nnoremap Q @q

noremap <leader>u :w<Home>silent <End> !urlview<CR>

" Vim tabs shortcuts
nnoremap <F8> :tabprev<CR>
nnoremap <F9> :tabnext<CR>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Clear search registry
nnoremap <silent> <leader>/ :nohlsearch<CR>"

" Pull word under cursor into LHS of a substitute (for quick search and replace)
nnoremap <Localleader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#

" Indent lines with a single '<' or '>'
nnoremap > >>_
nnoremap < <<_

" Shell inside vim
noremap <silent> Z :suspend<CR>

"set shell=C:\tools\Cmder\vendor\git-for-windows\bin\bash.exe
nmap <C-W>h <C-w>h
nmap <C-W>j <C-w>j
nmap <C-W>k <C-w>k
nmap <C-W>l <C-w>l

" Redraw screen mapping
nnoremap <leader>r :redraw!<CR>

" Ale
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\   'php': ['php'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'json': ['prettier'],
\   'css': ['prettier'],
\   'scss': ['prettier'],
\   'typescript': ['tslint'],
\}
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_format = '%linter% says %s %code%[%severity%]'
let g:ale_completion_enabled = 0
let g:ale_lint_on_enter = 1
let g:ale_sign_column_always = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_lint_delay = 100   " millisecs
nmap <silent> <C-K> <Plug>(ale_previous_wrap)
nmap <silent> <C-J> <Plug>(ale_next_wrap)
nmap <Localleader>f <Plug>(ale_fix)
map <leader>at :ALEToggle<CR>

let g:doorboy_additional_brackets = {
  \ 'html': ['<>']
  \ }

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Goyo mapping
" nnoremap <leader>G :Goyo<CR>

" Ctags & Gutentags
let g:gutentags_cache_dir = '~/.vim/gutentags'
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*']
nnoremap <localleader>m <C-]>
nnoremap <localleader>. <C-T>
map <leader>gct :!ctags<CR>

" Lightline config
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [
\       ['mode', 'paste'], ['readonly', 'relativepath', 'modified']
\   ],
\   'right': [
\       ['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype'],
\       ['gitbranch']
\   ]
\ },
\ 'component_function': {
\   'gitbranch': 'fugitive#head',
\ }
\ }

" vim-move modifier key
let g:move_key_modifier = 'C'

" Function to get list of commits to be used in startify list
function! s:list_commits()
  let git = 'git -C C:'
  let commits = systemlist(git .' log --oneline | head -n10')
  let git = 'G'. git[1:]
  return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
endfunction

" Nerdcommenter
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDSpaceDelims = 1
let NERD_html_alt_style=1
let g:NERDCustomDelimiters={
  \ 'javascript': { 'left': '//', 'right': '', 'leftAlt': '{/*', 'rightAlt': '*/}' },
\}

" Vim Accent
inoremap ;ac <C-x><C-u>

nmap <F1> <Nop>

" Startify
let g:startify_bookmarks=[
\ '~/.vimrc',
\ '~/.vim/plugins.vim',
\]
" A list of Vim regular expressions that filters recently used files
let g:startify_skiplist=[
\ 'COMMIT_EDITMSG',
\ $VIMRUNTIME .'/doc',
\ 'plugged/.*/doc',
\ 'bundle/.*/doc',
\]
let g:startify_custom_header = ""
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   Recent files']            },
      \ { 'type': 'dir',       'header': ['   Recent files in working directory '. getcwd()] },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']       },
      \ { 'type': function('s:list_commits'), 'header': ['   Commits']      },
\ ]
