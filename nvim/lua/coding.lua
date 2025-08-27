require("codecompanion").setup({
  adapters = {
    anthropic = function()
      return require("codecompanion.adapters").extend("anthropic", {
        env = {
          api_key = "cmd:op read 'op://Private/Anthropic/api key' --no-newline",
        },
        schema = {
          extended_thinking = {
            default = true,
          },
          model = {
            default = "claude-sonnet-4-20250514",
          },
        },
      })
    end,
  },
  strategies = {
    chat = {
      adapter = "anthropic",
    },
    inline = {
      adapter = "anthropic",
    },
  },
})

-- Enable syntax highlighting in markdown code blocks for the following languages
vim.g.markdown_fenced_languages = {
  'bash=sh',
  'css',
  'html',
  'javascript',
  'json',
  'lua',
  'python',
  'scss',
  'typescript',
  'typescriptreact',
  'vim',
  'yaml',
}

-----------------
-- Key mappings
-- https://codecompanion.olimorris.dev/getting-started.html#suggested-plugin-workflow
-----------------
vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
