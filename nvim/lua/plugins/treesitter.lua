return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = { ':TSUpdate' },
    event = { 'BufNewFile', 'BufRead' },
    config = function()
      require("nvim-treesitter").setup({
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
          "jsonc",
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
      })
    end
  },

  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
}
