return {
  { 'junegunn/fzf', build = { 'fzf#install()' } },

  {
    'neoclide/coc.nvim',
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
      -- format
      { '<leader>f', '<Plug>(coc-format)' },

      -- 補完候補をTabで選択
      { mode = "i", "<TAB>", [[coc#pum#visible() ? coc#pum#next(1) : "<TAB>"]], expr = true, replace_keycodes = false },
      { mode = "i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], expr = true, replace_keycodes = false },
      -- Enterキーで決定
      { '<CR>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], mode = "i", expr = true, replace_keycodes = false },

      -- coc-fzf-preview
      { ';f', ':<C-u>CocCommand fzf-preview.ProjectFiles<CR>' },
      { ';b', ':<C-u>CocCommand fzf-preview.Buffers<CR>' },
      { ';g', ':<C-u>CocCommand fzf-preview.ProjectGrep<Space>' },
      { ';qf', ':<C-u>CocCommand fzf-preview.QuickFix<CR>' },
    },
    config = function()
      vim.g.coc_global_extensions = {
        "coc-json",
        "coc-solargraph",
        "coc-tsserver",
        "coc-html",
        "coc-css",
        "coc-yaml",
        "coc-eslint",
        "coc-prettier",
        "coc-stylelintplus",
        "@yaegassy/coc-volar",
        "coc-fzf-preview",
      }
    end
  },
}
