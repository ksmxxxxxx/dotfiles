return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
      -- プロジェクト内ファイル検索（旧 ;f coc-fzf-preview.ProjectFiles）
      { ';f', '<cmd>Telescope find_files<CR>' },
      -- バッファ一覧（旧 ;b coc-fzf-preview.Buffers）
      { ';b', '<cmd>Telescope buffers<CR>' },
      -- プロジェクト内 grep（旧 ;g coc-fzf-preview.ProjectGrep）
      { ';g', '<cmd>Telescope live_grep<CR>' },
      -- quickfix（旧 ;qf coc-fzf-preview.QuickFix）
      { ';qf', '<cmd>Telescope quickfix<CR>' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
          }
        }
      })
      telescope.load_extension('fzf')
    end
  },
}
