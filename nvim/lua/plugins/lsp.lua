return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'mason-org/mason-lspconfig.nvim',
    enabled = false,
    opts = {
      automatic_enable = {
        -- Temporarily disable eslint
        exclude = { 'eslint' },
      },
    },
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'neovim/nvim-lspconfig',
    },
  },

  {
    'neovim/nvim-lspconfig',
    enabled = false,
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp_keymaps', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, silent = true, desc = desc })
          end

          -- Diagnostics
          map('[g', function() vim.diagnostic.jump({ count = -1 }) end, 'Previous diagnostic')
          map(']g', function() vim.diagnostic.jump({ count = 1 }) end, 'Next diagnostic')
          map('<leader>d', vim.diagnostic.setloclist, 'Show all diagnostics')

          -- Navigation
          map('gd', vim.lsp.buf.definition, 'Go to definition')
          map('gy', vim.lsp.buf.type_definition, 'Go to type definition')
          map('gi', vim.lsp.buf.implementation, 'Go to implementation')
          map('gr', vim.lsp.buf.references, 'Go to references')

          -- Hover / docs
          map('K', vim.lsp.buf.hover, 'Show documentation')

          -- Refactoring
          map('<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
          map('<leader>ac', vim.lsp.buf.code_action, 'Code action')
          map('<leader>qf', function() vim.lsp.buf.code_action({ apply = true }) end, 'Quick fix current line')

          -- Symbols
          map('<leader>o', vim.lsp.buf.document_symbol, 'Document outline')
          map('<leader>s', vim.lsp.buf.workspace_symbol, 'Search workspace symbols')
        end,
      })
    end,
  },
}
