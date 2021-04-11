let g:python3_host_prog = $PYENV_ROOT.'/versions/neovim3/bin/python'

" dein Scripts ===================================================
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')
let s:toml_dir = expand('~/.config/vim')

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml = s:toml_dir . '/dein.toml'
  let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  
  call dein#end()
  call dein#save_state()

endif

if dein#check_install()
  call dein#install()
endif
call map(dein#check_clean(), "delete(v:val, 'rf')")
" End dein Scripts ================================================



" Default setting ================================================
filetype on
set nobackup
set noswapfile
set noundofile
set autoindent
set clipboard+=unnamed
" ChangeLog ++++++++++++++++++++++++++++++++++++++++++++++++++++++
let g:changelog_timeformat = "%Y-%m-%d" 
let g:changelog_username = "ksm"

" Visual setting =================================================
set noshowmode
set nowrap
set incsearch
set showmatch
set number
" set cursorline
set list
set hlsearch
set ts=2 sw=2 expandtab
set backspace=indent,eol,start
set regexpengine=1
set diffopt=vertical

" Filetype setting++++++++++++++++++++++++++++++++++++++++++++++++
set fileformats=unix,dos,mac
if has("autocmd")
  " 改行時にコメントしない
  " 改行時に勝手にインデントしない
"  autocmd FileType * setlocal formatoptions-=ro noautoindent nosmartindent
  " ファイル種別による個別設定(初期設定ではexpandtabなのでその設定はいれない)
  " ts = tabstop, sts = softtabstop, sw = shiftwidth, tw = textwidth
  " ft = filetype
  autocmd FileType html,xhtml,css,javascript,yaml,ruby,coffee,haml,slim,scss setlocal ts=2 sts=2 sw=2
  " autocmd FileType python     setlocal ts=4 sts=4 sw=4

  " ファイルを開いた時、読み込んだ時にファイルタイプを設定する
  autocmd BufNewFile,BufRead *.js setlocal ft=javascript
  autocmd BufNewFile,BufRead *.ejs setlocal ft=html
  autocmd BufNewFile,BufRead *.py setlocal ft=python
  autocmd BufNewFile,BufRead *.rb setlocal ft=ruby
  autocmd BufNewFile,BufRead Gemfile setlocal ft=ruby
  autocmd BufNewFile,BufRead *.coffee setlocal ft=coffee
  autocmd BufNewFile,BufRead *.slim setlocal ft=slim
  autocmd BufNewFile,BufRead *.haml setlocal ft=haml
  autocmd BufNewFile,BufRead *.ts setlocal ft=typescript
  autocmd BufNewFile,BufReadPost *.md set ft=markdown
  " autocmd BufNewFile,BufRead *.md setlocal ft=markdown
  autocmd BufNewFile,BufRead *.toml setlocal ft=toml
  autocmd BufNewFile,BufRead *.vim setlocal ft=vim
  autocmd BufNewFile,BufRead *.jade setlocal ft=markdown
  autocmd BufNewFile,BufRead *.gyp setlocal ft=json
  autocmd BufNewFile,BufRead *.cson setlocal ft=json
  autocmd BufNewFile,BufRead *.yml setlocal ft=yaml
  autocmd BufNewFile,BufRead *.yaml setlocal ft=yaml
  autocmd BufNewFile,BufRead *.html.erb set filetype=html
  autocmd BufNewFile,BufRead *.js.erb set filetype=javascript
  autocmd BufNewFile,BufRead *.es6.erb set filetype=javascript
  autocmd BufNewFile,BufRead *.css.erb set filetype=css
  autocmd BufNewFile,BufRead *.scss.erb set filetype=scss
  " ctagsファイルの設定ファイル
  " autocmd BufNewFile,BufRead *.rb set tags+=;$HOME/.ruby.ctags;
  " autocmd BufNewFile,BufRead *.js set tags+=;$HOME/.javascript.ctags;
endif

" Keymap setting =================================================
inoremap <silent> jj <ESC>
inoremap <silent> kk <ESC>
nmap <Esc><Esc> :nohlsearch<CR><Esc>
nmap <Space><Space> V
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
inoremap {<Enter> {<CR><CR>}<ESC>ki<TAB>
inoremap [<Enter> [<CR><CR>]<ESC>ki<TAB>
inoremap (<Enter> (<CR><CR>)<ESC>ki<TAB>

augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype javascript inoremap <buffer> </ </<C-x><C-o>
augroup END
