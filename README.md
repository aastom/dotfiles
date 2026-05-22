# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).  
Every top-level directory is a **stow package** — symlinking its subtree into `$HOME`.

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Package Overview](#package-overview)
  - [ai](#ai--github-cli--copilot-cli)
  - [alacritty](#alacritty)
  - [bat](#bat)
  - [beets](#beets)
  - [espanso](#espanso)
  - [fontconfig](#fontconfig)
  - [git](#git)
  - [mpv](#mpv)
  - [nvim](#nvim)
  - [tmux](#tmux)
  - [zsh](#zsh)
- [Zsh Plugins & CLI Tools](#zsh-plugins--cli-tools)
- [Local Overrides](#local-overrides)

---

## Prerequisites

| Tool | Purpose | Install |
|------|---------|---------|
| [GNU Stow](https://www.gnu.org/software/stow/) | Symlink manager | `brew install stow` |
| [Homebrew](https://brew.sh) | Package manager | `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` |
| [Zinit](https://github.com/zdharma-continuum/zinit) | Zsh plugin manager | auto-installed by `zsh/modules/zinit.zsh` on first shell load |
| [gh CLI](https://cli.github.com) | GitHub CLI — also powers Copilot CLI | managed by Zinit (`cli/cli`) |
| [Neovim](https://neovim.io) 0.10+ | Text editor | `brew install neovim` |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Neovim fuzzy search | `brew install ripgrep` |
| [lazygit](https://github.com/jesseduffield/lazygit) | Git TUI for Neovim | `brew install lazygit` |
| A [Nerd Font](https://www.nerdfonts.com) v3+ | Icons in Neovim / terminal | download & set in terminal |

---

## Getting Started

```sh
# 1. Clone
git clone https://github.com/aastom/dotfiles ~/.dotfiles
cd ~/.dotfiles

# 2. Stow all packages at once
stow --no-folding */

# Or stow individual packages
stow --no-folding zsh git ai

# 3. Authenticate GitHub CLI (required for gh & Copilot CLI)
gh auth login

# 4. Authenticate Copilot CLI
#    Copilot CLI picks up the token from gh automatically once you run gh auth login.
#    If you need a standalone token:
gh copilot -- login

# 5. Reload your shell
exec zsh
```

> **Note:** `.stowrc` targets `~` by default, so you don't need to pass `--target`.  
> Use `--no-folding` to create individual file symlinks rather than symlinking entire directories (safer with existing dirs).

---

## Package Overview

### `ai` — GitHub CLI & Copilot CLI

| Symlinked file | Source |
|----------------|--------|
| `~/.config/gh/config.yml` | `ai/.config/gh/config.yml` |
| `~/.copilot/config.yml` | `ai/.copilot/config.yml` |
| `~/.copilot/mcp-config.json` | `ai/.copilot/mcp-config.json` |

**gh CLI** (`~/.config/gh/config.yml`)  
Configures protocol (`https`), editor, pager, and disables telemetry.  
Docs: <https://cli.github.com/manual/gh_config_set>

**GitHub Copilot CLI** (`~/.copilot/config.yml`)  
Full configuration for the AI coding assistant:
- Default model: `claude-sonnet-4.6` (overridable with `/model` or `--model`)
- IDE auto-connect enabled for VS Code
- Streaming + markdown rendering enabled

**MCP servers** (`~/.copilot/mcp-config.json`)  
Add custom [Model Context Protocol](https://modelcontextprotocol.io) servers here.  
The built-in GitHub MCP server is enabled by default.

**Authentication flow:**
```sh
# Via gh (recommended — shared credential)
gh auth login                    # browser OAuth or token
# Copilot CLI picks up GH_TOKEN / gh keychain automatically

# Or standalone Copilot login
gh copilot -- login

# Check status
gh auth status
gh copilot -- version
```

**Aliases added to zsh** (from `zsh/modules/aliases.zsh`):

| Alias | Expands to | Description |
|-------|-----------|-------------|
| `cop` | `gh copilot` | Interactive Copilot session |
| `copp <prompt>` | `gh copilot -- -p <prompt>` | Non-interactive prompt mode |
| `copi <prompt>` | `gh copilot -- -i <prompt>` | Interactive session with opening prompt |
| `cop-yolo` | `gh copilot -- --allow-all` | All permissions, no confirmations |

**Environment variable** set in `zsh/modules/env.zsh`:
```sh
COPILOT_MODEL=claude-sonnet-4.6   # default model (can be overridden per-session)
```

---

### `alacritty`

| Symlinked file | Source |
|----------------|--------|
| `~/.config/alacritty/alacritty.yml` | `alacritty/.config/alacritty/alacritty.yml` |

GPU-accelerated terminal emulator config.  
Sets window dimensions (150×40), padding, and appearance.  
Docs: <https://alacritty.org/config-alacritty.html>

---

### `bat`

| Symlinked file | Source |
|----------------|--------|
| `~/.config/bat/config` | `bat/.config/bat/config` |

`cat` replacement with syntax highlighting.  
Configures syntax mappings for non-standard extensions (`.h`, `.ino`, `.ignore`, etc.).  
Aliased as `cat='bat'` in zsh.  
Docs: <https://github.com/sharkdp/bat>

---

### `beets`

| Symlinked file | Source |
|----------------|--------|
| `~/.config/beets/config.yaml` | `beets/.config/beets/config.yaml` |

Music library manager configuration.  
Docs: <https://beets.readthedocs.io>

---

### `espanso`

| Symlinked files | Source |
|----------------|--------|
| `~/.config/espanso/user/*.yml` | `espanso/.config/espanso/user/` |

Text expander with per-topic snippet files:

| File | Purpose |
|------|---------|
| `global.yml` | Cross-app global snippets |
| `git.yml` | Git commit / branch snippets |
| `generic.yml` | General-purpose expansions |
| `article.yml`, `book.yml`, `course.yml` | Content reference snippets |
| `logseq.yml` | Logseq note-taking shortcuts |
| `media.yml`, `youtube.yml`, `tiktok.yml`, `twitter.yml`, `reddit.yml`, `stackoverflow.yml` | URL / media snippets |
| `misc.yml` | Miscellaneous |

Docs: <https://espanso.org/docs>

---

### `fontconfig`

| Symlinked file | Source |
|----------------|--------|
| `~/.config/fontconfig/fonts.conf` | `fontconfig/.config/fontconfig/fonts.conf` |

System font rendering configuration (antialiasing, hinting, preferred families).

---

### `git`

| Symlinked file | Source |
|----------------|--------|
| `~/.config/git/config` | `git/.config/git/config` |
| `~/.config/git/ignore` | `git/.config/git/ignore` |
| `~/.config/git/attributes` | `git/.config/git/attributes` |
| `~/.config/git/template` | `git/.config/git/template` |
| `~/.config/git/local.example` | `git/.config/git/local.example` |

Key settings:
- **Diff/merge tool:** [Meld](https://meldmerge.org) (`/Applications/Meld.app`)
- **Pager:** `diff-so-fancy | less`
- **Signing:** SSH key signing with `id_ed25519.pub`
- **Default branch:** `main`
- **LFS:** enabled
- **ghq root:** `~/Code`

Local machine overrides go in `~/.config/git/local` (not tracked — copy from `local.example`).

---

### `mpv`

| Symlinked file | Source |
|----------------|--------|
| `~/.config/mpv/mpv.conf` | `mpv/.config/mpv/mpv.conf` |

Video player configuration.  
Docs: <https://mpv.io/manual/master>

---

### `nvim`

| Symlinked path | Source |
|----------------|--------|
| `~/.config/nvim/` | `nvim/.config/nvim/` |

Full Neovim IDE configuration built on [LazyVim](https://lazyvim.org).  
See [`nvim/.config/nvim/README.md`](nvim/.config/nvim/README.md) for comprehensive documentation.

**Quick summary:**

| Feature | Detail |
|---------|--------|
| Plugin manager | [lazy.nvim](https://github.com/folke/lazy.nvim) |
| LSP installer | [Mason](https://github.com/williamboman/mason.nvim) |
| Completion | [blink.cmp](https://github.com/saghen/blink.cmp) |
| Fuzzy finder | [fzf-lua](https://github.com/ibhagwan/fzf-lua) |
| File explorer | [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) |
| AI completions | [copilot.lua](https://github.com/zbirenbaum/copilot.lua) ghost-text |
| AI chat | [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) — **Claude Opus 4.6** |

**Languages with full LSP support:**

`Python` · `Go` · `Terraform/HCL` · `C` · `C++` · `C#` · `Java` · `TypeScript/JS` · `Rust` · `Lua` · `YAML` · `JSON` · `TOML` · `Markdown` · `Docker` · `SQL` · `Nix` · `Svelte` · `Vue`

**First-time setup:**

```sh
stow --no-folding nvim
nvim                  # lazy.nvim bootstraps plugins on first launch
# Inside neovim:
# :Copilot auth       ← authenticate GitHub Copilot
```

---

| Symlinked file | Source |
|----------------|--------|
| `~/.config/tmux/tmux.conf` | `tmux/.config/tmux/tmux.conf` |

Terminal multiplexer configuration.  
Docs: <https://github.com/tmux/tmux/wiki>

---

### `zsh`

| Symlinked path | Source |
|----------------|--------|
| `~/.zshenv` | `zsh/.zshenv` |
| `~/.config/zsh/.zshrc` | `zsh/.config/zsh/.zshrc` |
| `~/.config/zsh/.p10k.zsh` | `zsh/.config/zsh/.p10k.zsh` |
| `~/.config/zsh/modules/` | `zsh/.config/zsh/modules/` |
| `~/.config/zsh/functions/` | `zsh/.config/zsh/functions/` |
| `~/.config/zsh/widgets/` | `zsh/.config/zsh/widgets/` |
| `~/.config/zsh/completions/` | `zsh/.config/zsh/completions/` |

**Shell startup order:**
1. `.zshenv` — sets `XDG_*` dirs, `ZDOTDIR`, `PATH`
2. `.zshrc` → sources each module in order

**Modules** (`zsh/modules/`):

| Module | Purpose |
|--------|---------|
| `paths.zsh` | `PATH` configuration |
| `term.zsh` | Terminal environment setup |
| `theme.zsh` | Theme selection logic |
| `keymap.zsh` | Vi-style key bindings |
| `widgets.zsh` | Custom ZLE widgets |
| `env.zsh` | Environment variables (editors, pager, fzf, languages, **Copilot**) |
| `options.zsh` | Zsh `setopt` flags |
| `completion.zsh` | Completion system config |
| `history.zsh` | History settings |
| `window.zsh` | Terminal window/title management |
| `zinit.zsh` | Plugin manager + all plugins |
| `aliases.zsh` | Shell aliases |

---

## Zsh Plugins & CLI Tools

Managed via [Zinit](https://github.com/zdharma-continuum/zinit) in `zinit.zsh`:

| Tool | Description |
|------|-------------|
| [gh](https://cli.github.com) | GitHub CLI — issues, PRs, releases, Copilot |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder — `Ctrl+R`, `Ctrl+T`, `Alt+C` |
| [fd](https://github.com/sharkdp/fd) | Fast `find` replacement |
| [bat](https://github.com/sharkdp/bat) | Syntax-highlighted `cat` |
| [exa](https://github.com/ogham/exa) | Modern `ls` with git info |
| [jq](https://github.com/jqlang/jq) | JSON processor |
| [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy) | Better git diffs |
| [pastel](https://github.com/sharkdp/pastel) | Color tool |
| [ghq](https://github.com/x-motemen/ghq) | Repository manager (root: `~/Code`) |
| [direnv](https://direnv.net) | Per-directory `.envrc` |
| [rupa/z](https://github.com/rupa/z) | Directory frecency jumper |
| [anyenv](https://github.com/anyenv/anyenv) | Language version manager |
| [sdkman](https://sdkman.io) | JVM SDK version manager |
| [forgit](https://github.com/wfxr/forgit) | Fzf-powered git helpers |
| [git-extras](https://github.com/tj/git-extras) | Extra git subcommands |
| emoji-cli | Emoji picker with fzf |
| zsh-you-should-use | Reminds you of existing aliases |
| Powerlevel10k | Prompt theme |

---

## Local Overrides

| File | Purpose |
|------|---------|
| `~/.config/zsh/.local` (tracked as `$LOCALRC`) | Local zsh config — aliases, secrets, machine-specific settings |
| `~/.config/git/local` | Local git config — user identity, credentials |

Copy the template: `cp ~/.config/git/local.example ~/.config/git/local`

These files are **not tracked** by git (listed in `.gitignore`/`.stow-global-ignore`).
