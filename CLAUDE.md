# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

Personal dotfiles for a macOS dev environment. There is no build system, package manager, or test suite — each top-level directory holds the config for one tool, and files keep their canonical names (`.zshrc`, `init.lua`, `.tmux.conf`, `.gitconfig`, etc.) so they can be symlinked into `$HOME` by hand. There is no install script that does the symlinking for you.

Active configs live in `bash/`, `bat/`, `cron/`, `ghostty/`, `git/`, `gmail/`, `nvim/`, `p10k/`, `terminal/`, `tmux/`, `zsh/`. `nvim.bak/` is a preserved legacy Neovim config — leave it alone unless explicitly asked.

## Conventions

- **EditorConfig** (`.editorconfig`) governs everything: 2-space indent, UTF-8, trim trailing whitespace, final newline. Match this in any new file.
- **Lua (Neovim)** is formatted by **stylua** (`nvim/stylua.toml`): single quotes, 2-space indent, column width 120, `collapse_simple_statement = "FunctionOnly"`. Run `stylua nvim/` after editing Lua.
- **Commits are GPG-signed** (`git/.gitconfig` sets `commit.gpgSign = true`). Don't bypass signing.
- **`.gitignore`** ignores `.claude` only — nothing else is auto-excluded.
- **Keep configs company-agnostic.** Never reference a current/past employer, their repos, monorepos, internal app or service names, or proprietary tooling in config files or comments. When a tooling choice is motivated by a work project, describe the technical reason (e.g. "match a pnpm + prettier monorepo") without naming the company.

## Path wart to watch for

The committed shell configs reference the dotfiles repo at paths that don't match this checkout:

- `zsh/.zshrc` → `BAT_CONFIG_PATH="$HOME/Code/dotfiles/bat/bat.conf"`
- `bash/.bashrc` → `BAT_CONFIG_PATH="$HOME/projects/dotfiles/bat/bat.conf"`
- Repo actually lives at `~/Developer/dotfiles`.

When touching path references in these files, ask which one is canonical before normalizing — the inconsistency is pre-existing.

## Neovim config (`nvim/`)

LazyVim distribution on top of **lazy.nvim**. Entry point `init.lua` → `lua/config/lazy.lua` bootstraps lazy and imports `lua/plugins/`. Each file in `lua/plugins/` returns a lazy plugin spec.

- Open lazy UI: `:Lazy` · update plugins: `:Lazy update` · plugin lock file: `nvim/lazy-lock.json`.
- Install LSP servers / formatters: `:Mason`.
- LazyVim extras enabled in `nvim/lazyvim.json` (copilot, mini-comment/surround, typescript with biome+oxc, eslint linting, etc.).
- Custom plugin glue in `lua/plugins/`:
  - `init.lua` — disables `flash.nvim` and `bufferline.nvim`, loads monokai colorscheme, fugitive (with custom `:Browse` so `:GBrowse` works), fzf.vim for `:Commits`/`:BCommits`.
  - `lsp.lua` — `conform.nvim` formatter chain per filetype (biome-check → prettier → oxfmt, `stop_after_first = true`); oxlint with `fixKind = 'all'`; rounded diagnostic float borders; virtual_text disabled; inlay hints off.
  - `snacks.lua` — picker config including a custom `claude_add` action bound to `<leader>a` that runs `:ClaudeCodeAdd` on selected files; remaps `<c-p>`/`<c-n>` to picker history; floors non-integer dims via a runtime patch to `Snacks.win:dim` (workaround for narrow-window code-action picker).
- `lua/config/options.lua` — `termguicolors` is enabled **only inside tmux** (detected via `$TERM`), and a custom `window/showMessageRequest` handler suppresses LSP "crashed" popups.
- `lua/config/autocmds.lua` — strips trailing whitespace on save, highlights yanked text, sets a large set of custom highlights on every `ColorScheme` event.

## Zsh (`zsh/.zshrc`)

oh-my-zsh + **antigen** plugin manager + powerlevel10k theme (config in `p10k/.p10k.zsh`). Auto-attaches tmux only inside real terminal emulators (`ghostty`, `Apple_Terminal`, `iTerm.app`) — explicitly skips agent wrappers like Claude Code so spawning a shell from inside Claude doesn't try to grab a tmux session. NVM, pyenv, and ngrok integrations all run at startup.
