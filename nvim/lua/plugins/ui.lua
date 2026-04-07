return {
  {
    'lunarvim/horizon.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme horizon]])
    end
  },

  'nvim-tree/nvim-web-devicons',

  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-web-devicons', opt = true },
    event = { 'BufEnter' },
    config = function()
      require("lualine").setup({
        theme = 'horizon',
        tabline = {
          lualine_a = { 'buffers' },
          lualine_z = { 'tabs' }
        }
      })
    end
  },
}
