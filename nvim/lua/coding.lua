vim.g.markdown_fenced_languages = { 'html', 'javascript', 'typescript', 'typescriptreact', 'css', 'scss', 'bash=sh',
  'json', 'yaml', 'python', 'lua', 'vim' }

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
