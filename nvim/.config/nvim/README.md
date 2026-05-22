# Neovim Configuration

Personal Neovim config built on [LazyVim](https://lazyvim.org). Uses **lazy.nvim** as the plugin manager and **Mason** to auto-install LSP servers, formatters and linters.

---

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Directory Structure](#directory-structure)
- [Plugin Overview](#plugin-overview)
- [Languages & LSPs](#languages--lsps)
- [GitHub Copilot](#github-copilot)
- [Keymaps Reference](#keymaps-reference)
  - [General](#general)
  - [Motion & Navigation](#motion--navigation)
  - [Windows & Splits](#windows--splits)
  - [Buffers & Tabs](#buffers--tabs)
  - [File Explorer (neo-tree)](#file-explorer-neo-tree)
  - [Fuzzy Finder (fzf-lua)](#fuzzy-finder-fzf-lua)
  - [LSP](#lsp)
  - [Code Editing](#code-editing)
  - [Git (gitsigns + fugitive)](#git-gitsigns--fugitive)
  - [Diagnostics](#diagnostics)
  - [Debug (DAP)](#debug-dap)
  - [GitHub Copilot](#github-copilot-keymaps)
  - [Copilot Ghost-text](#copilot-ghost-text)
  - [Terminal](#terminal)
  - [Aerial (Symbol Outline)](#aerial-symbol-outline)
- [LazyVim Extras Enabled](#lazyvim-extras-enabled)
- [Mason Tools](#mason-tools)
- [Customising](#customising)

---

## Requirements

| Tool | Minimum version | Install |
|------|----------------|---------|
| [Neovim](https://neovim.io) | **0.10+** | `brew install neovim` |
| [Git](https://git-scm.com) | 2.40+ | usually pre-installed |
| [Node.js](https://nodejs.org) | 18+ | `brew install node` |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | any | `brew install ripgrep` |
| [fd](https://github.com/sharkdp/fd) | any | `brew install fd` |
| [lazygit](https://github.com/jesseduffield/lazygit) | any | `brew install lazygit` |
| A [Nerd Font](https://www.nerdfonts.com) | v3+ | Required for icons |
| [.NET SDK](https://dotnet.microsoft.com) | 7+ | For C# / OmniSharp |
| [JDK](https://adoptium.net) | 17+ | For Java (jdtls) |

---

## Installation

```sh
# 1. Clone the dotfiles (if not already done)
git clone https://github.com/aastom/dotfiles ~/.dotfiles
cd ~/.dotfiles

# 2. Stow the nvim package
stow --no-folding nvim

# 3. Open Neovim — lazy.nvim bootstraps itself and installs everything
nvim

# 4. Inside Neovim, trigger Mason to install all language servers
:MasonInstallAll   # (or wait; they auto-install on first open)

# 5. Authenticate Copilot
:Copilot auth
```

On first launch lazy.nvim will clone all plugins; Mason will then auto-install LSP servers in the background. Expect ~2 minutes on first boot.

---

## Directory Structure

```
nvim/.config/nvim/
├── init.lua                    # Entry point — bootstraps lazy.nvim
├── lazyvim.json                # LazyVim extras toggle (source of truth)
├── stylua.toml                 # Lua formatter config
├── .neoconf.json               # Per-project LSP config (neoconf/neodev)
├── lazy-lock.json              # Plugin lockfile (pinned commits)
└── lua/
    ├── config/
    │   ├── autocmds.lua        # Custom autocommands
    │   ├── keymaps.lua         # Custom keymaps (on top of LazyVim defaults)
    │   ├── lazy.lua            # lazy.nvim setup & performance opts
    │   └── options.lua         # vim.opt settings
    └── plugins/
        ├── copilot.lua         # GitHub Copilot + CopilotChat (claude-opus-4.6)
        ├── lsp.lua             # LSP servers, Mason tools, Treesitter, formatters
        └── example.lua         # LazyVim example spec (not loaded)
```

---

## Plugin Overview

LazyVim ships with a curated set of plugins. Below are the most important ones:

| Category | Plugin | Description |
|----------|--------|-------------|
| **Plugin manager** | [lazy.nvim](https://github.com/folke/lazy.nvim) | Fast, declarative plugin manager |
| **LSP** | [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configurations |
| **LSP installer** | [mason.nvim](https://github.com/williamboman/mason.nvim) | Manage LSP/DAP/linter/formatter binaries |
| **Completion** | [blink.cmp](https://github.com/saghen/blink.cmp) | Fast completion engine |
| **Snippets** | [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Snippet collection |
| **Formatter** | [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatter dispatcher |
| **Linter** | [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Async linting |
| **Syntax** | [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | AST-based syntax highlighting |
| **File explorer** | [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | Sidebar file tree |
| **Fuzzy finder** | [fzf-lua](https://github.com/ibhagwan/fzf-lua) | Files, grep, buffers, LSP, git |
| **Git** | [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | In-buffer git hunks |
| **Git UI** | [lazygit](https://github.com/jesseduffield/lazygit) | Full git TUI via `<leader>gg` |
| **Statusline** | [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Configurable status bar |
| **Bufferline** | [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Tabline for buffers |
| **Notifications** | [noice.nvim](https://github.com/folke/noice.nvim) | Command line / notification UI |
| **Which-key** | [which-key.nvim](https://github.com/folke/which-key.nvim) | Keymap popup guide |
| **Flash** | [flash.nvim](https://github.com/folke/flash.nvim) | Fast motion — `s` to leap |
| **DAP** | [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol |
| **Symbol outline** | [aerial.nvim](https://github.com/stevearc/aerial.nvim) | LSP symbol sidebar |
| **Copilot** | [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | Ghost-text AI completions |
| **Copilot Chat** | [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) | Chat with claude-opus-4.6 |
| **Colorscheme** | [catppuccin](https://github.com/catppuccin/nvim) | Default theme |

---

## Languages & LSPs

All servers are auto-installed by Mason.

| Language | LSP Server | Formatter | Linter / Extra |
|----------|-----------|-----------|----------------|
| **Python** | `pyright` | `black`, `isort` | `ruff` |
| **Go** | `gopls` | `goimports`, `gofmt` | `golangci-lint` |
| **Terraform / HCL** | `terraform-ls` | `terraform_fmt` | `tflint` |
| **C** | `clangd` | `clang-format` | clang-tidy (via clangd) |
| **C++** | `clangd` | `clang-format` | clang-tidy (via clangd) |
| **C#** | `omnisharp` | `csharpier` | Roslyn analysers |
| **Java** | `jdtls` | `google-java-format` | — |
| **Lua** | `lua_ls` | `stylua` | — |
| **TypeScript / JS** | `ts_ls` | `prettierd` | — |
| **JSON / JSONC** | `jsonls` | `prettierd` | — |
| **YAML** | `yamlls` | `prettierd` | `yamllint` |
| **TOML** | `taplo` | taplo | — |
| **Markdown** | `marksman` | `prettierd` | `markdownlint` |
| **Docker** | `dockerls` | — | `hadolint` |
| **SQL** | `sqlls` | — | — |
| **Rust** | `rust_analyzer` | `rustfmt` | — |
| **Shell / Bash** | `bashls` | `shfmt` | `shellcheck` |
| **Nix** | `nil_ls` | — | — |
| **Svelte** | `svelte` | `prettierd` | — |
| **Vue** | `volar` | `prettierd` | — |
| **Tailwind CSS** | `tailwindcss` | — | — |
| **Git** | — | — | commit lint |

### Treesitter parsers

All languages above have Treesitter parsers installed automatically for:
syntax highlighting · indentation · code folding · text objects · incremental selection

---

## GitHub Copilot

Copilot is powered by **Claude Opus 4.6** via the GitHub Copilot API.

### Setup

```sh
# Inside Neovim
:Copilot auth
# Follow the browser prompt to authenticate with your GitHub account
```

### Two modes

| Mode | Description |
|------|-------------|
| **Ghost-text** | Inline suggestions appear as you type. Accept with `Alt+l`. |
| **Chat** | Full conversational AI in a vertical split. Open with `<leader>aa`. |

See the [Copilot keymaps section](#github-copilot-keymaps) for all shortcuts.

---

## Keymaps Reference

> **`<leader>` = `Space`**  
> `<C-x>` = Ctrl+x · `<M-x>` = Alt+x · `<S-x>` = Shift+x

---

### General

| Key | Mode | Description |
|-----|------|-------------|
| `<C-s>` | n/i/v | Save file |
| `<leader>qq` | n | Quit all |
| `<Esc>` | n | Clear search highlights |
| `<leader>l` | n | Open lazy.nvim plugin manager |
| `<leader>cm` | n | Open Mason |
| `<leader>e` | n | Toggle file explorer (neo-tree) |
| `<leader>E` | n | Open file explorer at cwd |

---

### Motion & Navigation

#### Basic movement

| Key | Description |
|-----|-------------|
| `h / j / k / l` | Left / down / up / right |
| `w / W` | Forward word (word / WORD) |
| `b / B` | Backward word |
| `e / E` | End of word |
| `0` | Start of line (column 0) |
| `^` | First non-blank character |
| `$` | End of line |
| `gg` | Go to first line |
| `G` | Go to last line |
| `{N}G` | Go to line N |
| `{N}%` | Go to N% of file |
| `H / M / L` | Top / Middle / Bottom of visible screen |

#### Scrolling

| Key | Description |
|-----|-------------|
| `<C-d>` | Scroll down half-page (cursor centred) |
| `<C-u>` | Scroll up half-page (cursor centred) |
| `<C-f>` | Scroll forward full page |
| `<C-b>` | Scroll backward full page |
| `<C-e>` | Scroll down one line |
| `<C-y>` | Scroll up one line |
| `zz` | Centre cursor on screen |
| `zt` | Cursor to top of screen |
| `zb` | Cursor to bottom of screen |

#### Marks & jumps

| Key | Description |
|-----|-------------|
| `m{a-z}` | Set mark {a-z} |
| `` `{a-z} `` | Jump to exact mark position |
| `'{a-z}` | Jump to mark line |
| `<C-o>` | Jump backward in jump list |
| `<C-i>` | Jump forward in jump list |
| `''` | Jump to last position |
| `gi` | Go to last insert position |

#### Flash (fast motion)

| Key | Mode | Description |
|-----|------|-------------|
| `s` | n/x/o | Flash jump — type label to teleport |
| `S` | n/x/o | Flash Treesitter — jump to AST node |
| `r` | o | Remote flash (operator + flash) |
| `R` | o/x | Treesitter remote flash |
| `<C-s>` | c | Toggle flash search mode |

#### Search

| Key | Description |
|-----|-------------|
| `/` | Search forward |
| `?` | Search backward |
| `n` | Next result (centred) |
| `N` | Previous result (centred) |
| `*` | Search word under cursor (forward) |
| `#` | Search word under cursor (backward) |
| `g*` | Search partial word forward |
| `g#` | Search partial word backward |

---

### Windows & Splits

| Key | Mode | Description |
|-----|------|-------------|
| `<C-h>` | n | Move to left window |
| `<C-j>` | n | Move to lower window |
| `<C-k>` | n | Move to upper window |
| `<C-l>` | n | Move to right window |
| `<leader>-` | n | Split window horizontally |
| `<leader>\|` | n | Split window vertically |
| `<leader>wd` | n | Delete window |
| `<leader>wm` | n | Maximise / restore window |
| `<C-Up>` | n | Increase window height |
| `<C-Down>` | n | Decrease window height |
| `<C-Left>` | n | Decrease window width |
| `<C-Right>` | n | Increase window width |

---

### Buffers & Tabs

| Key | Mode | Description |
|-----|------|-------------|
| `<S-h>` | n | Previous buffer |
| `<S-l>` | n | Next buffer |
| `<leader>bd` | n | Delete (close) current buffer |
| `<leader>bD` | n | Delete buffer + window |
| `<leader>bo` | n | Delete other buffers |
| `<leader>bl` | n | Delete buffers to the left |
| `<leader>br` | n | Delete buffers to the right |
| `<leader>bb` | n | Switch to other/last buffer |
| `<leader>bf` | n | Format buffer |
| `<leader><tab>l` | n | Last tab |
| `<leader><tab>f` | n | First tab |
| `<leader><tab><tab>` | n | New tab |
| `<leader><tab>d` | n | Close tab |
| `<leader><tab>]` | n | Next tab |
| `<leader><tab>[` | n | Previous tab |

---

### File Explorer (neo-tree)

Open with `<leader>e` (root dir) or `<leader>E` (cwd).

| Key | Description |
|-----|-------------|
| `<CR>` / `l` | Open file / expand dir |
| `h` | Close dir / go to parent |
| `a` | Add file or directory (`dir/` for dirs) |
| `d` | Delete |
| `r` | Rename |
| `c` | Copy |
| `m` | Move / cut |
| `p` | Paste |
| `y` | Copy filename to clipboard |
| `Y` | Copy path to clipboard |
| `q` | Close neo-tree |
| `R` | Refresh |
| `H` | Toggle hidden files |
| `/` | Fuzzy search in tree |
| `?` | Show help |
| `<` / `>` | Switch source (files / git / buffers) |
| `i` | Show file info |
| `s` | Open in vertical split |
| `S` | Open in horizontal split |
| `t` | Open in new tab |

---

### Fuzzy Finder (fzf-lua)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ff` | n | Find files (root) |
| `<leader>fF` | n | Find files (cwd) |
| `<leader>fg` | n | Live grep (root) |
| `<leader>fG` | n | Live grep (cwd) |
| `<leader>fb` | n | Browse open buffers |
| `<leader>fr` | n | Recent files |
| `<leader>fR` | n | Recent files (cwd) |
| `<leader>f:` | n | Command history |
| `<leader>f"` | n | Registers |
| `<leader>fh` | n | Help pages |
| `<leader>fH` | n | Highlights |
| `<leader>fk` | n | Keymaps |
| `<leader>fm` | n | Marks |
| `<leader>fo` | n | Options |
| `<leader>ft` | n | Treesitter symbols |
| `<leader>fw` | n | Grep word under cursor |
| `<leader>fW` | n | Grep WORD under cursor |
| `<leader>ss` | n | LSP document symbols |
| `<leader>sS` | n | LSP workspace symbols |
| `<leader>sd` | n | Document diagnostics |
| `<leader>sD` | n | Workspace diagnostics |

**Inside fzf-lua:**

| Key | Description |
|-----|-------------|
| `<C-j>` / `<C-k>` | Move down / up |
| `<CR>` | Open selected |
| `<C-v>` | Open in vertical split |
| `<C-s>` | Open in horizontal split |
| `<C-t>` | Open in new tab |
| `<C-q>` | Send all to quickfix |
| `<M-q>` | Send selected to quickfix |
| `<Esc>` / `<C-c>` | Close |

---

### LSP

These keymaps are active when an LSP server is attached to the buffer.

| Key | Mode | Description |
|-----|------|-------------|
| `gd` | n | Go to definition |
| `gD` | n | Go to declaration |
| `gr` | n | Go to references |
| `gI` | n | Go to implementation |
| `gy` | n | Go to type definition |
| `K` | n | Hover documentation |
| `gK` | n | Signature help |
| `<C-k>` | i | Signature help (insert mode) |
| `<leader>ca` | n/v | Code action |
| `<leader>cc` | n | Code lens run |
| `<leader>cC` | n | Refresh code lens |
| `<leader>cr` | n | Rename symbol |
| `<leader>cR` | n | Rename file (with LSP) |
| `<leader>cs` | n | Document symbols (aerial) |
| `<leader>cS` | n | Workspace symbols |
| `<leader>cf` | n/v | Format buffer / selection |
| `<leader>ci` | n | Incoming calls |
| `<leader>co` | n | Outgoing calls |
| `<leader>cR` | n | Switch source/header (C/C++) |
| `]d` | n | Next diagnostic |
| `[d` | n | Previous diagnostic |
| `]e` | n | Next error |
| `[e` | n | Previous error |
| `]w` | n | Next warning |
| `[w` | n | Previous warning |
| `<leader>cd` | n | Open diagnostic float |
| `<leader>xd` | n | Document diagnostics (Trouble) |
| `<leader>xD` | n | Workspace diagnostics (Trouble) |
| `<leader>xl` | n | Location list (Trouble) |
| `<leader>xq` | n | Quickfix list (Trouble) |

---

### Code Editing

| Key | Mode | Description |
|-----|------|-------------|
| `<A-j>` | n/i/v | Move line/selection down |
| `<A-k>` | n/i/v | Move line/selection up |
| `<` | v | Indent left (keeps selection) |
| `>` | v | Indent right (keeps selection) |
| `p` | v | Paste without overwriting register |
| `gcc` | n | Toggle line comment |
| `gc` | v | Toggle comment on selection |
| `gbc` | n | Toggle block comment |
| `<leader>cf` | n/v | Format file / selection |
| `<leader>cF` | n/v | Format injected languages |
| `<leader>ur` | n | Redraw / clear highlights |

#### Text objects (via mini.ai)

| Key | Description |
|-----|-------------|
| `va)` / `vi)` | Around/inside parentheses |
| `va]` / `vi]` | Around/inside brackets |
| `va}` / `vi}` | Around/inside braces |
| `vaf` / `vif` | Around/inside function |
| `vac` / `vic` | Around/inside class |
| `vaa` / `via` | Around/inside argument |
| `dat` / `dit` | Around/inside HTML tag |

---

### Git (gitsigns + fugitive)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gg` | n | Open lazygit |
| `<leader>gG` | n | Open lazygit (cwd) |
| `<leader>gc` | n | Git commits (fzf-lua) |
| `<leader>gC` | n | Git commits for current file |
| `<leader>gb` | n | Git branches |
| `<leader>gs` | n | Git status |
| `<leader>gf` | n | Git files |
| `<leader>gd` | n | Git diff (current file) |
| `]h` | n | Next hunk |
| `[h` | n | Previous hunk |
| `<leader>ghs` | n/v | Stage hunk |
| `<leader>ghr` | n/v | Reset hunk |
| `<leader>ghS` | n | Stage buffer |
| `<leader>ghR` | n | Reset buffer |
| `<leader>ghu` | n | Undo stage hunk |
| `<leader>ghp` | n | Preview hunk |
| `<leader>ghb` | n | Blame line |
| `<leader>ghB` | n | Blame buffer (line annotations) |
| `<leader>ghd` | n | Diff this |
| `<leader>ghD` | n | Diff this ~ (against last commit) |

---

### Diagnostics

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cd` | n | Open diagnostic float for line |
| `]d` | n | Next diagnostic |
| `[d` | n | Previous diagnostic |
| `]e` | n | Next error |
| `[e` | n | Previous error |
| `]w` | n | Next warning |
| `[w` | n | Previous warning |
| `<leader>xd` | n | Document diagnostics (Trouble) |
| `<leader>xD` | n | Workspace diagnostics (Trouble) |
| `<leader>xl` | n | Location list (Trouble) |
| `<leader>xq` | n | Quickfix list (Trouble) |
| `<leader>xt` | n | Toggle Trouble |

---

### Debug (DAP)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>da` | n | Run with args |
| `<leader>db` | n | Toggle breakpoint |
| `<leader>dB` | n | Set conditional breakpoint |
| `<leader>dc` | n | Continue / start |
| `<leader>dC` | n | Run to cursor |
| `<leader>dd` | n | Run last |
| `<leader>de` | n/v | Evaluate expression |
| `<leader>dg` | n | Go to line (no execute) |
| `<leader>di` | n | Step into |
| `<leader>dj` | n | Down (in call stack) |
| `<leader>dk` | n | Up (in call stack) |
| `<leader>dl` | n | Run last |
| `<leader>do` | n | Step out |
| `<leader>dO` | n | Step over |
| `<leader>dp` | n | Pause |
| `<leader>dr` | n | Toggle REPL |
| `<leader>ds` | n | Session |
| `<leader>dt` | n | Terminate |
| `<leader>dw` | n | Widgets |
| `<leader>du` | n | Toggle DAP UI |

---

### GitHub Copilot Keymaps

> All Copilot Chat keymaps use the `<leader>a` prefix.

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>aa` | n/v | Toggle Copilot Chat panel |
| `<leader>ac` | n/v | Open Copilot Chat |
| `<leader>ar` | n | Reset chat history |
| `<leader>ae` | n/v | Explain selected code |
| `<leader>af` | n/v | Fix diagnostics / bugs |
| `<leader>at` | n/v | Generate tests |
| `<leader>ao` | n/v | Optimize selected code |
| `<leader>ad` | n/v | Generate documentation |
| `<leader>aR` | n/v | Review code |
| `<leader>am` | n | Generate commit message |
| `<leader>aM` | n | Generate commit message (staged only) |
| `<leader>ai` | n/v | Inline chat (replace selection) |
| `<leader>aq` | n/v | Quick chat (freeform prompt) |

**Inside the chat window:**

| Key | Description |
|-----|-------------|
| `<Tab>` | Autocomplete `@context` / `/command` |
| `<CR>` | Submit prompt |
| `<C-s>` | Submit (insert mode) |
| `<C-y>` | Accept diff |
| `<C-l>` | Reset / clear chat |
| `gy` | Yank diff |
| `gd` | Show diff |
| `gp` | Show system prompt |
| `gs` | Show user selection |
| `q` / `<C-c>` | Close chat |

---

### Copilot Ghost-text

> Active whenever you are typing in insert mode.

| Key | Mode | Description |
|-----|------|-------------|
| `<M-l>` (Alt+l) | i | Accept full suggestion |
| `<M-w>` (Alt+w) | i | Accept one word |
| `<M-j>` (Alt+j) | i | Accept one line |
| `<M-]>` (Alt+]) | i | Next suggestion |
| `<M-[>` (Alt+[) | i | Previous suggestion |
| `<C-]>` | i | Dismiss suggestion |
| `<M-CR>` | n | Open Copilot suggestions panel |

---

### Terminal

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ft` | n | Terminal (root dir) |
| `<leader>fT` | n | Terminal (cwd) |
| `<C-/>` | n | Toggle floating terminal |
| `<Esc><Esc>` | t | Exit terminal mode back to normal |

---

### Aerial (Symbol Outline)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cs` | n | Toggle aerial sidebar |
| `{` | n | Jump to prev symbol |
| `}` | n | Jump to next symbol |
| `[[` | n | Jump to prev symbol (same kind) |
| `]]` | n | Jump to next symbol (same kind) |
| `<CR>` | n (aerial) | Jump to symbol in source |
| `<C-v>` | n (aerial) | Open in vertical split |
| `<C-s>` | n (aerial) | Open in horizontal split |
| `q` | n (aerial) | Close aerial |

---

## LazyVim Extras Enabled

Configured in `lazyvim.json`:

| Extra | Provides |
|-------|---------|
| `coding.copilot` | copilot.lua ghost-text |
| `coding.copilot-chat` | CopilotChat.nvim |
| `dap.core` | nvim-dap + nvim-dap-ui |
| `dap.nlua` | DAP for Lua/Neovim |
| `editor.aerial` | Symbol outline sidebar |
| `lang.clangd` | C/C++ — clangd LSP |
| `lang.docker` | Dockerfile LSP + Treesitter |
| `lang.git` | Git — Treesitter + gitsigns extras |
| `lang.go` | Go — gopls + DAP |
| `lang.java` | Java — jdtls + DAP |
| `lang.json` | JSON — jsonls + SchemaStore |
| `lang.markdown` | Markdown — marksman + render |
| `lang.nix` | Nix — nil_ls |
| `lang.omnisharp` | C# — OmniSharp + Roslyn |
| `lang.python` | Python — pyright + ruff |
| `lang.rust` | Rust — rust_analyzer + crates |
| `lang.sql` | SQL — sqlls |
| `lang.svelte` | Svelte — svelte LSP |
| `lang.tailwind` | Tailwind CSS |
| `lang.terraform` | Terraform — terraform-ls + tflint |
| `lang.toml` | TOML — taplo |
| `lang.typescript` | TypeScript/JS — ts_ls |
| `lang.vue` | Vue — volar |
| `lang.yaml` | YAML — yamlls + SchemaStore |
| `util.dot` | Dotfiles editing helpers |

---

## Mason Tools

All tools below are auto-installed on first launch (`lua/plugins/lsp.lua`):

```
stylua          shfmt           shellcheck
pyright         ruff            black           isort
gopls           goimports       golangci-lint
terraform-ls    tflint
clangd          clang-format
omnisharp       csharpier
jdtls           google-java-format
yamllint        jsonlint
hadolint        markdownlint    prettierd
```

---

## Customising

### Add a new plugin

Create a file in `lua/plugins/`:

```lua
-- lua/plugins/my-plugin.lua
return {
  "author/plugin-name",
  event = "VeryLazy",
  opts = {},
}
```

### Enable/disable LazyVim extras

Edit `lazyvim.json` and add/remove entries from the `extras` array, then restart Neovim.

### Override LSP settings

Add or modify server entries in `lua/plugins/lsp.lua` under `nvim-lspconfig → opts → servers`.

### Change Copilot model

Edit `lua/plugins/copilot.lua`:

```lua
opts = {
  model = "claude-opus-4.6",  -- or "gpt-4o", "claude-sonnet-4.6", etc.
}
```

### Add formatters

Edit `lua/plugins/lsp.lua` under `conform.nvim → opts → formatters_by_ft`.

### Local overrides

For machine-specific config that shouldn't be committed, create:
```
~/.config/nvim/lua/local.lua
```
and `require("local")` from the bottom of `lua/config/options.lua`.
