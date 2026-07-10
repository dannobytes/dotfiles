return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        javascript = { 'biome-check', 'prettier', 'oxfmt', stop_after_first = true },
        typescript = { 'biome-check', 'prettier', 'oxfmt', stop_after_first = true },
        javascriptreact = { 'biome-check', 'prettier', 'oxfmt', stop_after_first = true },
        typescriptreact = { 'biome-check', 'prettier', 'oxfmt', stop_after_first = true },
        scss = { 'prettier', 'oxfmt', stop_after_first = true },
        sass = { 'prettier', 'oxfmt', stop_after_first = true },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      diagnostics = {
        float = { border = 'rounded' }, -- Add rounded border
        virtual_text = false,
      },
      inlay_hints = {
        enabled = false,
      },
      servers = {
        ['*'] = {
          keys = {
            {
              '<leader>ca',
              function()
                vim.lsp.buf.code_action({
                  context = {
                    diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
                    only = { 'quickfix' },
                  },
                })
              end,
              desc = 'Code Action (quickfix)',
              mode = { 'n', 'x' },
              has = 'codeAction',
            },
          },
        },
        oxlint = {
          settings = {
            fixKind = 'all',
          },
        },
        tsgo = {
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = 'shortest',
                includePackageJsonAutoImports = 'on',
              },
            },
          },
        },
      },
    },
  },
}
