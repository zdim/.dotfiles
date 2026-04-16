# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles repo for macOS/Linux, managed by [dotbot](https://github.com/anishathalye/dotbot) for symlinking. Configs included: zsh, neovim, kitty terminal.

## Commands

- **Install symlinks:** `./install` (runs dotbot with `install.conf.yaml`)
- **Install Homebrew packages:** `brew bundle install --file $DOTFILES/macos/Brewfile`
- **Neovim plugin sync:** `:PackerSync` inside neovim (uses packer.nvim)

## Architecture

### Symlink mapping (`install.conf.yaml`)

Dotbot symlinks these paths into `~/.config/` and `~/`:
- `~/.zshenv` → `.config/zsh/.zshenv`
- `~/.config/zsh` → `.config/zsh`
- `~/.config/nvim` → `.config/nvim`
- `~/.config/kitty` → `.config/kitty`
- `~/.Brewfile` → `macos/Brewfile` (macOS only)
- `~/.claude/CLAUDE.md` → `.config/claude/CLAUDE.md`
- `~/.claude/statusline.sh` → `.config/claude/statusline.sh`

### Zsh (`.config/zsh/`)

- `.zshenv` — sets XDG dirs, `ZDOTDIR`, `DOTFILES`, `GOPATH`, `EDITOR`
- `.zshrc` — sources plugins, configures completions, prompt, vcs_info, then sources all files in `scripts/`
- `scripts/` — sourced alphabetically; `alias.zsh` for shared aliases, `alias.local.zsh` for machine-local aliases (gitignored via `*.local.*` pattern)
- `functions/` — autoloaded zsh functions (`zsh_add_plugin`, `last_working_dir`)
- `plugins/` — git submodules (zsh-autosuggestions, zsh-syntax-highlighting, zsh-completions, alias-tips, gradle-completion)

### Neovim (`.config/nvim/`)

- `init.lua` → requires `conf` module
- `lua/conf/` — core config: `init.lua` (loads keymaps + settings + lazy), `keymaps.lua`, `settings.lua`, `lazy.lua` (plugin declarations)
- `after/plugin/` — per-plugin configuration files (lsp, telescope, treesitter, gitsigns, lualine, neotree, etc.)
- Plugin manager: **lazy.nvim**
- LSP: mason.nvim + mason-lspconfig + nvim-lspconfig + nvim-cmp

### Claude Code (`.config/claude/`)

- `CLAUDE.md` — global instructions (symlinked to `~/.claude/CLAUDE.md`)
- `statusline.sh` — custom status line script (symlinked to `~/.claude/statusline.sh`)
- `settings.json` — NOT tracked; Claude Code manages `~/.claude/settings.json` directly (atomic writes break symlinks)

### Kitty (`.config/kitty/`)

- `kitty.conf` — main config
- `current-theme.conf` / `theme.conf` — theme configuration

## Commit messages

Format: `<scope>: <lowercase description>`

- Scope is the config area being changed: `zsh`, `nvim`, `kitty`, `mac`, `tidy` (for repo housekeeping)
- Description is short, lowercase, no period
- Examples: `zsh: add GOPATH/bin to path`, `nvim: add CopilotChat`, `tidy: add .local files to .gitignore`

## Conventions

- Machine-local overrides use `*.local.*` suffix (gitignored)
- Zsh plugins are vendored as git submodules under `.config/zsh/plugins/`
- The `*.hide.*` pattern is also gitignored for sensitive files
