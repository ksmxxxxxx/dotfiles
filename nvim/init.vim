" provider setting =========================================
let g:python3_host_prog = '/usr/local/bin/python3'
let g:ruby_host_prog = '$HOME/.rbenv/versions/3.1.2/bin/neovim-ruby-host'
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0

" Default setting ================================================
filetype on
filetype plugin on
filetype indent on

set termguicolors
set nobackup
set noswapfile
set autoindent
set clipboard+=unnamed

autocmd colorscheme * highlight Normal      ctermbg=NONE guibg=NONE
autocmd colorscheme * highlight NonText     ctermbg=NONE guibg=NONE
autocmd colorscheme * highlight Folded      ctermbg=NONE guibg=NONE
autocmd colorscheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE

if has('persistent_undo')
  let undo_path = expand('~/.cache/nvim/undo')
  exe 'set undodir=' .. undo_path
  set undofile
endif

" dein Scripts ===================================================
let s:config_dir = expand('$XDG_CONFIG_HOME/nvim')
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#load_toml(s:config_dir . '/dein.toml',      {'lazy': 0})
  call dein#load_toml(s:config_dir . '/dein_lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

syntax enable
colorscheme iceberg


" Read rc file ===================================================
" Scrapbox script
let s:scrapbox_rc = expand(s:config_dir . '/rc/scrapbox.rc.vim')
if filereadable('~/.config/nvim/rc/scrapbox.rc.vim')
  source ~/.config/nvim/rc/scrapbox.rc.vim
endif

" ChangeLog ======================================================
let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_username = "ksm"

" Visual setting =================================================
set noshowmode
set incsearch
set showmatch
set nowrap
set number
set list
set hlsearch
set ts=2 sw=2 expandtab
set backspace=indent,eol,start
set regexpengine=1
set diffopt=vertical
set nofoldenable
if has('conceal')
  set conceallevel=0 concealcursor=
endif
set cursorline
set encoding=utf-8
set guifont=:h

" Filetype setting ==============================================
set fileencoding=utf-8
set fileformats=unix,dos,mac
if has("autocmd")
  autocmd FileType html,xhtml,css,javascript,yaml,ruby,coffee,haml,slim,scss,sass,pug setlocal ts=2 sts=2 sw=2

  autocmd BufNewFile,BufRead *.js       set filetype=javascript
  autocmd BufNewFile,BufRead *.ejs      set filetype=html
  autocmd BufNewFile,BufRead *.py       set filetype=python
  autocmd BufNewFile,BufRead *.rb       set filetype=ruby
  autocmd BufNewFile,BufRead Gemfile    set filetype=ruby
  autocmd BufNewFile,BufRead *.coffee   set filetype=coffee
  autocmd BufNewFile,BufRead *.slim     set filetype=slim
  autocmd BufNewFile,BufRead *.haml     set filetype=haml
  autocmd BufNewFile,BufRead *.ts       set filetype=typescript
  autocmd BufNewFile,BufRead *.md       set filetype=markdown
  autocmd BufNewFile,BufRead *.toml     set filetype=toml
  autocmd BufNewFile,BufRead *.vim      set filetype=vim
  autocmd BufNewFile,BufRead *.jade     set filetype=markdown
  autocmd BufNewFile,BufRead *.gyp      set filetype=json
  autocmd BufNewFile,BufRead *.cson     set filetype=json
  autocmd BufNewFile,BufRead *.yml      set filetype=yaml
  autocmd BufNewFile,BufRead *.yaml     set filetype=yaml
  autocmd BufNewFile,BufRead *.erb      set filetype=html
  autocmd BufNewFile,BufRead *.html.erb set filetype=html
  autocmd BufNewFile,BufRead *.js.erb   set filetype=javascript
  autocmd BufNewFile,BufRead *.es6.erb  set filetype=javascript
  autocmd BufNewFile,BufRead *.css.erb  set filetype=css
  autocmd BufNewFile,BufRead *.scss.erb set filetype=scss
  autocmd BufNewFile,BufRead *.sass     set filetype=sass
  autocmd BufNewFile,BufRead *.pug      set filetype=pug
endif

" Keymap setting =================================================
inoremap <silent> jj <ESC>
inoremap <silent> kk <ESC>
nmap <Esc><Esc> :nohlsearch<CR><Esc>
nmap <Space><Space> V
"nnoremap s <Nop>
nnoremap bj <C-w>j
nnoremap bk <C-w>k
nnoremap bl <C-w>l
nnoremap bh <C-w>h
nnoremap bJ <C-w>J
nnoremap bK <C-w>K
nnoremap bL <C-w>L
nnoremap bH <C-w>H
nnoremap bn gt
nnoremap bp gT
nnoremap br <C-w>r
nnoremap b= <C-w>+
nnoremap b- <C-w>-
"nnoremap sw <C-w>w
nnoremap bo <C-w>>
nnoremap bO <C-w><
nnoremap bn :<C-u>bn<CR>
nnoremap bp :<C-u>bp<CR>
nnoremap bq :<C-u>bd<CR>
nnoremap bt :<C-u>tabnew<CR>
nnoremap bs :<C-u>sp<CR>
nnoremap bv :<C-u>vs<CR>
" nnoremap sq :<C-u>q<CR>
inoremap {<Enter> {<CR><CR>}<ESC>ki<TAB>
inoremap [<Enter> [<CR><CR>]<ESC>ki<TAB>
inoremap (<Enter> (<CR><CR>)<ESC>ki<TAB>

augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype javascript inoremap <buffer> </ </<C-x><C-o>
augroup END
