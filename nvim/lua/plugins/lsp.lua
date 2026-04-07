return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },

  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'ruby_lsp',
          'ts_ls',
          'vue_ls',
          'html',
          'cssls',
          'jsonls',
          'yamlls',
          'eslint',
        },
        automatic_installation = true,
      })
    end
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- キーマップは LSP がバッファにアタッチされたタイミングで設定
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local opts = { noremap = true, silent = true, buffer = args.buf }
          vim.keymap.set('n', ';d', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', ';r', '<cmd>Telescope lsp_references<CR>', opts)
          vim.keymap.set('n', ';i', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end
      })

      local servers = {
        'ruby_lsp', 'ts_ls', 'vue_ls',
        'html', 'cssls', 'jsonls', 'yamlls', 'eslint',
      }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
      end

      vim.lsp.enable(servers)
    end
  },
}
