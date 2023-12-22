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

set t_Co=256
colorscheme iceberg
set bg=dark

syntax enable

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
set regexpengine=2
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
  autocmd BufNewFile,BufRead *.vue      set filetype=vue
  autocmd BufNewFile,BufRead *.njk      set filetype=jinja
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
nnoremap bc <C-w>c
nnoremap br <C-w>r
nnoremap b= <C-w>+
nnoremap b- <C-w>-
nnoremap bw <C-w>w
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

" 相対ファイルパスをクリップボードにリダイレクト
nnoremap ,xc :let @* = expand('%')<CR>

