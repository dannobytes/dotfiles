return {
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      -- A file's package has migrated its FORMATTING to oxfmt iff that package
      -- owns an oxfmt.config.ts. Search upward from the file and take the
      -- nearest match, but exclude the repo-root oxfmt.config.ts: it exists
      -- repo-wide, so counting it would make every file look migrated. Only a
      -- package-local config counts. Mirrors the monorepo's own marker +
      -- lint-staged `pnpm -F <pkg> fix` routing.
      local function in_oxfmt_pkg(_, ctx)
        local root = vim.fs.root(ctx.filename, '.git') or vim.fs.dirname(ctx.filename)
        local found = vim.fs.find('oxfmt.config.ts', {
          path = ctx.dirname,
          upward = true,
          stop = vim.fs.dirname(root),
        })[1]
        return found ~= nil and vim.fs.dirname(found) ~= root
      end

      opts.formatters = opts.formatters or {}
      opts.formatters.oxfmt = { condition = in_oxfmt_pkg }
      opts.formatters.prettier = {
        condition = function(_, ctx) return not in_oxfmt_pkg(_, ctx) end,
      }

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs({ 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }) do
        opts.formatters_by_ft[ft] = { 'oxfmt', 'prettier', stop_after_first = true }
      end
      -- oxfmt formats JS/TS(/JSON) only, not CSS-family — keep these on prettier.
      opts.formatters_by_ft.scss = { 'prettier' }
      opts.formatters_by_ft.sass = { 'prettier' }
    end,
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      diagnostics = {
        float = { border = 'rounded' }, -- Add rounded border
        virtual_text = true,
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
        -- Prose linting via Vale's official language server (wraps the `vale`
        -- CLI). Only activates when a `.vale.ini` exists at the project root.
        -- `mdx` is added to the default filetypes so MDX prose is covered too.
        vale_ls = {
          filetypes = { 'asciidoc', 'markdown', 'mdx', 'text', 'tex', 'rst', 'html', 'xml' },
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
