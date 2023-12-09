local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- print('lazy.lua')
require("lazy").setup({
  'nvim-tree/nvim-web-devicons', -- display dev icons
  {
    'nvim-lualine/lualine.nvim', -- Status line
    dependencies = { 'nvim-web-devicons', opt = true },
    event = {'BufNewFile', 'BufRead'},
    options = { theme = 'iceberg_dark' },
    config = 'require("lualine").setup()'
  },
  {
    'neoclide/coc.nvim', -- coc.nvim Like the vscode
    branch = 'release',
    event = "InsertEnter",
    keys = {
      -- 定義に移動
      { '<C-]>', '<Plug>(coc-definition)' },
      -- 呼び出し元に移動
      { '<C-j>h', '<Plug>(coc-references)' },
      -- 実装に移動
      { '<C-j>i', '<Plug>(coc-implementation)' },
      -- 配下の定義を表示
      { '<M-s>', ':call CocActionAsync(\'doHover\')<CR>' },
      { '<C-P>', '<C-\\><C-O>:call CocActionAsync(\'showSignatureHelp\')<CR>', mode = "i" },
      -- 前後のエラーや警告に移動
      { '<M-k>', '<Plug>(coc-diagnostic-prev)' },
      { '<M-j>', '<Plug>(coc-diagnostic-next)' },
      -- Enterキーで決定
      { "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], mode = "i", expr = true, replace_keycodes = false },
      -- code action
      { '<M-CR>', '<Plug>(coc-codeaction-cursor)' },
      -- Find symbol of current document
      { '<C-j>o', ':<C-u>CocList outline<cr>' },
      -- Search workspace symbols
      { '<C-j>s', ':<C-u>CocList -I symbols<cr>' },
      -- Rename
      { '<S-M-r>', '<Plug>(coc-rename)' },
      -- Auto complete
      { "<F5>", "coc#refresh()" },
    },
    config = function()
      vim.g.coc_global_extensions = {
        "coc-json",
        "coc-solargraph",
        "coc-tsserver",
        "coc-html",
        "coc-css",
        "coc-yaml",
        "coc-stylelint",
        "coc-eslint",
        "coc-prettier",
        "@yaegassy/coc-volar"
        -- VueのプロジェクトではTakeOverModeをtrueにする
        --- https://github.com/yaegassy/coc-volar#if-you-are-using-takeover-mode-for-the-first-time-in-your-project
      }
    end
  },
})