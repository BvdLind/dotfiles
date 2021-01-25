
" Make sure spacebar doesn't have any mapping beforehand:
nnoremap <Space> <Nop>
let mapleader=" "
let maplocalleader=","

" Bundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'mhinz/vim-startify'

" Color Themes
Plugin 'dylanaraps/wal.vim'

" Code Formatting & Completion
Plugin 'prettier/vim-prettier', { 'do': 'yarn install' }
Plugin 'w0rp/ale'

" Search
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'

" Language related
Plugin 'leafgarland/typescript-vim'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'

call vundle#end()
filetype plugin indent on

colorscheme wal

" Basic stuff
syntax on
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab
set autoindent
set textwidth=80
set smartindent
set nu rnu
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
set hlsearch
set incsearch
set ignorecase
set smartcase
set ttimeoutlen=500
set background=light
set updatetime=100
set lazyredraw
hi cursorWinLeaveline cterm=none term=none
autocmd InsertLeave * setlocal cursorline
autocmd InsertEnter * setlocal nocursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine term=bold cterm=bold
highlight CursorLineNr ctermbg=blue guibg=Grey40
highlight CursorLine cterm=none guibg=#303000 ctermbg=blue
highlight CursorLineNr guibg=#303000 ctermbg=blue

" Vim tabs shortcuts
nnoremap <F8> :tabprev<CR>
nnoremap <F9> :tabnext<CR>

" Split sizing and -location
set splitbelow splitright
nnoremap <silent> <leader>> :5winc <<CR>
nnoremap <silent> <leader>< :5winc ><CR>
nnoremap <silent> <leader>+ :5winc +<CR>
nnoremap <silent> <leader>_ :5winc -<CR>
nnoremap <silent> <leader>= <C-W>=<CR>

" Stay on the line where you left off
augroup line_return
  au!
  au BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line("$") |
         \     execute 'normal! g`"zvzz' |
         \ endif
augroup END

" Spelling
map <F5> :setlocal spell!<CR>
map <F6> :set spelllang=en<CR>
map <F7> :set spelllang=nl<CR>
inoremap <c-f> <c-g>u<Esc>[s1z=`]a<c-g>u
nnoremap <c-f> [s1z=<c-o>

" Latex
let g:tex_flavor = "latex"
map <leader>co :!pdflatex % && zathura %:r.pdf<CR>
map <leader>xe :!xelatex % && zathura %:r.pdf<CR>
map <leader>bi :!bibtex8 %:r<CR>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Select entire buffer
nnoremap vaa ggvGg_
nnoremap Vaa ggVG

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Format prettier
let g:prettier#config#bracket_spacing = 'true'
" Prettier for PHP
function! PrettierPhpCursor()
  let save_pos = getpos(".")
  %! prettier --stdin --parser=php
  call setpos('.', save_pos)
endfunction
" define custom command
command! PrettierPhp call PrettierPhpCursor()
nnoremap <leader>p :Prettier<CR>
autocmd FileType php nnoremap <buffer> <leader>p :PrettierPhp<CR>

" Ale
let g:ale_linters = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'php': ['prettier'],
\   'python': ['flake8'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'json': ['prettier'],
\   'css': ['prettier'],
\   'scss': ['prettier'],
\   'php': ['prettier'],
\   'typescript': ['prettier'],
\   'python': ['black'],
\}
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_format = '%linter% says %s %code%[%severity%]'
let g:ale_lint_on_enter = 1
let g:ale_sign_column_always = 1
let g:ale_completion_enabled = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_lint_delay = 100   " millisecs
nmap <silent> <C-K> <Plug>(ale_previous_wrap)
nmap <silent> <C-J> <Plug>(ale_next_wrap)
nmap <Localleader>f <Plug>(ale_fix)
map <leader>at :ALEToggle<CR>

" Stratify
let g:startify_bookmarks=[
\ '~/.vimrc',
\ '~/.vim/plugins.vim',
\]

" Function to get list of commits to be used in startify list
function! s:list_commits()
  let git = 'git -C C:'
  let commits = systemlist(git .' log --oneline | head -n10')
  let git = 'G'. git[1:]
  return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
endfunction

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

" FZF
"search project files
silent! nmap <leader>g :GFiles<CR>
"search project files by lines of code
nnoremap <leader>l :Lines<cr>
"start a search query by pressing \
nnoremap \  :Ag<space>
"search for word under cursor by pressing |
nnoremap \| :Ag <C-R><C-W><cr>:cw<cr>
nnoremap <silent> <leader>f :Files <CR>
nnoremap <silent> <leader>- :Files <C-r>=expand("%:h")<CR>/<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>] :Tags<CR><CR>
nnoremap <silent> <leader>b] :BTags<CR>
let g:fzf_commits_log_options = '--graph --color=always
  \ --format="%C(yellow)%h%C(red)%d%C(reset)
  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'
nnoremap <silent> <leader>c  :Commits<CR>
nnoremap <silent> <leader>bc :BCommits<CR>
set grepprg=rg\ --vimgrep
command! -bang -nargs=* F call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!{.git,backend/node_modules}/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
let g:fzf_layout = { 'down': '~25%' }
let g:rg_command = "rg --files --no-ignore --hidden --follow -g '!{.git,backend/node_modules}/*'"
let g:dym_use_fzf = 1
