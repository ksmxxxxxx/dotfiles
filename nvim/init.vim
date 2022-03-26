" python provide setting =========================================
let g:python_host_prog  = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:ruby_host_prog = '/usr/local/bin/neovim-ruby-host'

" dein Scripts ===================================================
let s:dein_dir = expand('~/.cache/nvim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" If not installed dein.vim, download from github
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" Start dein.vim settings
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand("~/.config/nvim")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " toml cache
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " End dein.vim setting
  call dein#end()
  call dein#save_state()
endif
" If not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" End dein Scripts ================================================

" Read rc file ===================================================

" Scrapbox script
if filereadable(expand('~/.config/nvim/rc/scrapbox.rc.vim'))
  source ~/.config/nvim/rc/scrapbox.rc.vim
endif

" ================================================================

" Default setting ================================================
filetype on
set nobackup
set noswapfile
set autoindent
set clipboard+=unnamed

if has('persistent_undo')
	let undo_path = expand('~/.cache/nvim/undo')
	exe 'set undodir=' .. undo_path
	set undofile

endif
" ChangeLog ++++++++++++++++++++++++++++++++++++++++++++++++++++++
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

" Filetype setting++++++++++++++++++++++++++++++++++++++++++++++++
set fileencoding=utf-8
" set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8
set fileformats=unix,dos,mac
if has("autocmd")
  " 改行時にコメントしない
  " 改行時に勝手にインデントしない
"  autocmd FileType * setlocal formatoptions-=ro noautoindent nosmartindent
  " ファイル種別による個別設定(初期設定ではexpandtabなのでその設定はいれない)
  " ts = tabstop, sts = softtabstop, sw = shiftwidth, tw = textwidth
  " ft = filetype
  autocmd FileType html,xhtml,css,javascript,yaml,ruby,coffee,haml,slim,scss,pug setlocal ts=2 sts=2 sw=2
  " autocmd FileType python     setlocal ts=4 sts=4 sw=4

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
  autocmd BufNewFile,BufRead *.toml setlocal ft=toml
  autocmd BufNewFile,BufRead *.vim setlocal ft=vim
  autocmd BufNewFile,BufRead *.jade setlocal ft=markdown
  autocmd BufNewFile,BufRead *.gyp setlocal ft=json
  autocmd BufNewFile,BufRead *.cson setlocal ft=json
  autocmd BufNewFile,BufRead *.yml setlocal ft=yaml
  autocmd BufNewFile,BufRead *.yaml setlocal ft=yaml
  autocmd BufNewFile,BufRead *.erb set ft=html
  autocmd BufNewFile,BufRead *.html.erb set ft=html
  autocmd BufNewFile,BufRead *.js.erb set ft=javascript
  autocmd BufNewFile,BufRead *.es6.erb set ft=javascript
  autocmd BufNewFile,BufRead *.css.erb set ft=css
  autocmd BufNewFile,BufRead *.scss.erb set ft=scss
  autocmd BufNewFile,BufRead *.pug set ft=pug
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
nnoremap bn :<C-u>bn<CR>
nnoremap bp :<C-u>bp<CR>
nnoremap bq :<C-u>bd<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
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
