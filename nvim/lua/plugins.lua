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
  -- iceberg.vim
  -- auto save
  {
    'Pocco81/auto-save.nvim',
    config = function()
      require("auto-save").setup({
        enabled = true,
        trigger_events = {"InsertLeave", "TextChanged"},
      })
    end
  },
  -- brackets completion
  {
    'm4xshen/autoclose.nvim',
    config = function()
      require("autoclose").setup({
        options = {
          pair_spaces = true
        }
      })
    end
  },
  -- quick fix
  'nvim-tree/nvim-web-devicons', -- display dev icons
  -- Status line (lualine.nvim)
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-web-devicons', opt = true },
    event = {'BufNewFile', 'BufRead'},
    config = function()
      require("lualine").setup({
        theme = 'iceberg_dark',
        tabline = {
          lualine_a = {'filename'},
          lualine_z = {'tabs'}
        }
      })
    end
  },
  -- coc.nvim
  {
    'junegunn/fzf',
    build = {'fzf#install()'}
  },
  {
    'neoclide/coc.nvim', -- coc.nvim Like the vscode
    branch = 'release',
    event = "BufEnter",
    keys = {
      -- 定義に移動
      { ';d', '<Plug>(coc-definition)' },
      -- 呼び出し元に移動
      { ';r', '<Plug>(coc-references)' },
      -- 実装に移動
      { ';i', '<Plug>(coc-implementation)' },
      -- Rename
      { '<leader>rn', '<Plug>(coc-rename)' },
      -- Enterキーで決定
      { '<CR>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], mode = "i", expr = true, replace_keycodes = false },

      -- coc-fzf-preview
      ---- project files grep
      {';f', ':<C-u>CocCommand fzf-preview.ProjectFiles<CR>'},
      ---- buffers grep
      {';b', ':<C-u>CocCommand fzf-preview.Buffers<CR>'},
      ---- quickfix
      {';qf', ':<C-u>CocCommand fzf-preview.QuickFix<CR>'},
      -- 配下の定義を表示
      -- { '<M-s>', ':call CocActionAsync(\'doHover\')<CR>' },
      -- { '<C-P>', '<C-\\><C-O>:call CocActionAsync(\'showSignatureHelp\')<CR>', mode = "i" },
      -- 前後のエラーや警告に移動
      -- { '<M-k>', '<Plug>(coc-diagnostic-prev)' },
      -- { '<M-j>', '<Plug>(coc-diagnostic-next)' },
      -- code action
      -- { '<M-CR>', '<Plug>(coc-codeaction-cursor)' },
      -- Find symbol of current document
      -- { '<C-j>o', ':<C-u>CocList outline<cr>' },
      -- Search workspace symbols
      -- { '<C-j>s', ':<C-u>CocList -I symbols<cr>' },
      -- Auto complete
      -- { "<F5>", "coc#refresh()" },
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
        "@yaegassy/coc-volar",
        -- VueのプロジェクトではTakeOverModeをtrueにする
        --- https://github.com/yaegassy/coc-volar#if-you-are-using-takeover-mode-for-the-first-time-in-your-project
        "coc-dot-complete",
        "coc-dash-complete",
        -- fuzzy finder
        "coc-fzf-preview"
      }
    end
  },
  -- nvim-treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = {':TSUpdate'},
    event = {'BufNewFile', 'BufRead'},
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = {
          enable = true,
          disable = {},
        },
        indent = {
          enable = true,
          disable = {},
        },
        ensure_installed = {
          "markdown",
          "markdown_inline",
          "toml",
          "json",
          "yaml",
          "ruby",
          "javascript",
          "typescript",
          "tsx",
          "pug",
          "vue",
          "scss",
          "css",
          "html",
          "lua",
          "sql",
        },
        autotag = {
          enable = true,
        },
      })
    end
  },
  -- treesitter extarnal module & plugin
  'windwp/nvim-ts-autotag',
  -- telescope.nvim
})