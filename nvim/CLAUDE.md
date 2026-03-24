# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration written in Lua. It uses **lazy.nvim** as the plugin manager and **coc.nvim** as the LSP client.

## Plugin Management

Plugins are managed via lazy.nvim, which auto-bootstraps itself in `lua/config/lazy.lua`. Each plugin or plugin group has its own file under `lua/plugins/` and returns a lazy.nvim plugin spec table.

- Open the lazy UI: `:Lazy`
- Update plugins: `:Lazy update`
- Lock file: `lazy-lock.json` (tracks exact plugin versions)

## Architecture

```
init.lua                    # Entry point: sets leader keys, loads config modules, vim-plug (legacy/commented), vimscript autocmds
lua/
  config/
    lazy.lua                # Bootstraps lazy.nvim, imports lua/plugins/
    options.lua             # vim.opt settings (tabs, search, termguicolors, etc.)
    keymaps.lua             # General keymaps (window nav, buffers, netrw, etc.)
    autocmds.lua            # Autogroups: highlights, file types, format options, CoC tweaks
  plugins/
    init.lua                # Core plugins: colorscheme (monokai), git, UI, editor utilities, treesitter
    coc.lua                 # coc.nvim LSP client + all keymaps (gd, gr, K, <leader>rn, etc.)
    coding.lua              # codecompanion.nvim (AI chat via Anthropic/Claude)
    fzf.lua                 # fzf-lua (primary fuzzy finder) + junegunn/fzf.vim
    gitsigns.lua            # gitsigns.nvim with hunk navigation and staging keymaps
    snacks.lua              # folke/snacks.nvim (dashboard, indent, scroll, notifier, etc.)
    statusline.lua          # Status line plugin
```

**Note:** `init.lua` also contains legacy vimscript (vim-plug block, netrw config, rg search setup) that predates the lazy.nvim migration. New configuration should go in the `lua/` modules.

## Key Design Decisions

- **termguicolors** is only enabled when running inside tmux (detected via `$TERM`). The native macOS terminal does not support it.
- **CoC extensions** are declared in `lua/plugins/coc.lua` via `vim.g.coc_global_extensions`. CoC manages its own extension installs.
- **Anthropic API key** for codecompanion is retrieved from 1Password via `op read` — no hardcoded secrets.
- Trailing whitespace is stripped on every `BufWritePre` (in `lua/config/autocmds.lua`).

## Key Keymaps (non-obvious)

| Key | Action |
|-----|--------|
| `<C-p>` | FzfLua files |
| `<C-t>` | FzfLua buffers |
| `<C-\>` | FzfLua live grep |
| `\\` | Grep word under cursor |
| `<leader>gb/gc/gl/gs` | Git blame/commits/log/status (fzf-lua) |
| `gd / gr / gi / gy` | CoC go-to definition/references/implementation/type |
| `K` | CoC hover documentation |
| `<leader>rn` | CoC rename symbol |
| `<C-a>` | CodeCompanion actions |
| `<LocalLeader>a` | Toggle CodeCompanion chat |
| `]c / [c` | Next/prev git hunk (gitsigns) |
| `<leader>hs/hr` | Stage/reset hunk (gitsigns) |
