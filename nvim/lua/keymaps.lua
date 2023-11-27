vim.g.mapleader = ' ' -- <leader> is spase key
local noremap = { noremap = true }
local silent = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- Normal mode --
--- curcorのwindow移動 ---
keymap('n', 'bh', '<C-w>h', noremap)
keymap('n', 'bj', '<C-w>j', noremap)
keymap('n', 'bk', '<C-w>k', noremap)
keymap('n', 'bl', '<C-w>l', noremap)

--- 現在のwindowの高さ・幅を最大化して最もその方向に移動 ---
keymap('n', 'bH', '<C-w>H', noremap)
keymap('n', 'bJ', '<C-w>J', noremap)
keymap('n', 'bK', '<C-w>K', noremap)
keymap('n', 'bL', '<C-w>L', noremap)

--- 現在のwindowの高さを変更 ---
keymap('n', 'b-', '<C-w>-', noremap) -- than lower
keymap('n', 'b=', '<C-w>+', noremap) -- than highter

--- 現在のwindowの幅を変更
keymap('n', 'bo', '<C-w><', noremap) -- than narrow
keymap('n', 'bO', '<C-w>>', noremap) -- than wider

--- tab操作 ---
keymap('n', 'nt', 'gt', noremap) -- move to next tab
keymap('n', 'pt', 'gT', noremap) -- move to previous tab
keymap('n', 'nnt', ':<C-u>tabnew<CR>', noremap) -- new tab view

--- 画面操作 ---
keymap('n', 'bs', ':<C-u>sp', noremap) -- split view
keymap('n', 'bv', ':<C-u>vs', noremap) -- split vartically view

--- バッファ操作 ---
keymap('n', 'bq', ':<C-u>bd', noremap) -- delete current buffer from buffers list

--- 相対ファイルパスをクリップボードにリダイレクト ---
keymap('n', ',xc', ':let @* = expand("%")<CR>', noremap)

-- Insert mode --
-- space + iでNormalモードに戻る
keymap('i', '<leader>j', '<ESC>', silent)
-- keymap('i', 'jj', '<ESC>', silent)
-- keymap('i', 'kk', '<ESC>', silent)