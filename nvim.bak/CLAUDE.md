# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration written in Lua. It uses **lazy.nvim** as the plugin manager. LSP is handled by **nvim-lspconfig** (via mason) — `coc.lua` still exists but is legacy/unused.

## Plugin Management

Plugins are managed via lazy.nvim, which auto-bootstraps itself in `lua/config/lazy.lua`. Each plugin or plugin group has its own file under `lua/plugins/` and returns a lazy.nvim plugin spec table.

- Open the lazy UI: `:Lazy`
- Update plugins: `:Lazy update`
- Lock file: `lazy-lock.json` (tracks exact plugin versions)
- Install LSP servers/formatters: `:Mason`

## Architecture

```
init.lua                    # Entry point: sets leader keys, loads config modules
lua/
  config/
    lazy.lua                # Bootstraps lazy.nvim, imports lua/plugins/
    options.lua             # vim.opt settings (tabs, search, termguicolors, etc.)
    keymaps.lua             # General keymaps (window nav, buffers, netrw, etc.)
    autocmds.lua            # Autogroups: highlights, file types, format options, yank highlight
  plugins/
    init.lua                # Core plugins: colorscheme (monokai), git, UI, treesitter
    coc.lua                 # LEGACY: coc.nvim (kept but superseded by lsp.lua)
    coding.lua              # codecompanion.nvim (AI chat via Anthropic/Claude)
    fzf.lua                 # fzf-lua (primary fuzzy finder)
    gitsigns.lua            # gitsigns.nvim with hunk navigation and staging keymaps
    lsp.lua                 # Active LSP setup: mason, conform formatter, nvim-lspconfig keymaps
    snacks.lua              # folke/snacks.nvim (dashboard, indent, scroll, notifier, etc.)
    statusline.lua          # Status line plugin
stylua.toml                 # Stylua formatter config (2-space indent, collapse_simple_statement)
```

## Key Design Decisions

- **LSP** is handled by `nvim-lspconfig` + `mason-org/mason-lspconfig.nvim`. Servers are installed via `:Mason`.
- **Formatting on save** uses `conform.nvim`: tries `oxfmt` first (only if `oxfmt.toml` is found in the project), then falls back to `prettierd`/`prettier`. Lua uses `stylua`. Sass/SCSS use prettier only.
- **Linter autofix on save** for JS/TS: tries `LspOxlintFixAll` first, falls back to `LspEslintFixAll`.
- **termguicolors** is only enabled when running inside tmux (detected via `$TERM`). The native macOS terminal does not support it.
- **Anthropic API key** for codecompanion is retrieved from 1Password via `op read` — no hardcoded secrets.
- **lazydev.nvim** provides Lua LSP type awareness for `vim.*`, `Snacks`, and `FzfLua` globals.

## Key Keymaps (non-obvious)

| Key | Action |
|-----|--------|
| `<C-p>` | FzfLua files |
| `<C-t>` | FzfLua buffers |
| `<C-\>` | FzfLua live grep |
| `\\` | Grep word under cursor |
| `<leader>gb/gc/gl/gs` | Git blame/commits/log/status (fzf-lua) |
| `K` | LSP hover documentation |
| `<leader>rn` | LSP rename symbol |
| `<leader>ac` | LSP code action (apply) |
| `[g / ]g` | Previous/next diagnostic |
| `<C-a>` | CodeCompanion actions |
| `<LocalLeader>a` | Toggle CodeCompanion chat |
| `]c / [c` | Next/prev git hunk (gitsigns) |
| `<leader>hs/hr` | Stage/reset hunk (gitsigns) |
