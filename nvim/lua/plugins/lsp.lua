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
                ---@type 'shortest'|'relative'|'non-relative'|'project-relative'
                importModuleSpecifier = 'shortest',
                ---@type 'auto'|'on'|'off'
                includePackageJsonAutoImports = 'on',
                -- Auto-import types as `import type { X }` instead of a value
                -- import. Pairs well with verbatimModuleSyntax / isolatedModules.
                preferTypeOnlyAutoImports = true,
                -- Extension on generated import paths. Set 'js' for
                -- NodeNext/ESM projects that require explicit .js extensions.
                ---@type 'auto'|'minimal'|'index'|'js'
                importModuleSpecifierEnding = 'auto',
                -- Steer auto-imports away from the wrong module, e.g. force
                -- 'lodash-es' over 'lodash', or hide barrel/internal paths.
                autoImportFileExcludePatterns = {},
              },
              updateImportsOnFileMove = {
                -- Rewrite imports when a file is moved/renamed. Depends on
                -- client-side file-operation support; verify it actually fires.
                ---@type 'always'|'prompt'|'never'
                enabled = 'always',
              },
            },
          },
        },
      },
    },
  },
}
