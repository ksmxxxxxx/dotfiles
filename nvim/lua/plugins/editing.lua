return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        copilot_node_command = vim.fn.expand('~/.nodenv/versions/22.14.0/bin/node'),
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = '<C-l>',
            dismiss = '<C-]>',
            next = '<C-j>',
            prev = '<C-k>',
          },
        },
        panel = { enabled = false },
      })
    end,
  },

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

  {
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false,
  },
}
