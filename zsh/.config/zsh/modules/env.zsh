#
# Environment variables
#

# Term
# export TERM='xterm-256color'

# Editor
export EDITOR='vim'

# Pager
export PAGER='less'

# less status line.
export LESS='-R -f -X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESSCHARSET='utf-8'

# Local binaries
export -U PATH="$HOME/.local/bin${PATH:+:$PATH}"

# Poetry
export POETRY_HOME="$XDG_DATA_HOME/poetry"
export -U PATH="$POETRY_HOME/bin${PATH:+:$PATH}"

# pipx
export PIPX_HOME="$XDG_DATA_HOME/pipx"

# Yarn
if (( $+commands[yarn] )); then
  export -U PATH="$HOME/.yarn/bin${PATH:+:$PATH}"
fi

# Go
export GOENV_GOPATH_PREFIX="$XDG_DATA_HOME/go"

# Rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export -U PATH="$CARGO_HOME/bin${PATH:+:$PATH}"

# fzf
typeset -AU __FZF
if (( $+commands[fd] )); then
  __FZF[CMD]='fd --hidden --no-ignore-vcs --exclude ".git/*" --exclude "node_modules/*"'
  __FZF[DEFAULT]="${__FZF[CMD]} --type f"
  __FZF[ALT_C]="${__FZF[CMD]} --type d ."
elif (( $+commands[rg] )); then
  __FZF[CMD]='rg --no-messages --no-ignore-vcs'
  __FZF[DEFAULT]="${__FZF[CMD]} --files"
else
  __FZF[DEFAULT]='git ls-tree -r --name-only HEAD || find .'
fi

export FZF_DEFAULT_COMMAND="${__FZF[DEFAULT]}"
export FZF_CTRL_T_COMMAND="${__FZF[CMD]}"
export FZF_ALT_C_COMMAND="${__FZF[ALT_C]}"
export FZF_DEFAULT_OPTS="\
  --prompt='» '
  --pointer='▶'
  --marker='✓ '
  --min-height 30 \
  --height 50% \
  --reverse \
  --tabstop 2 \
  --multi \
  --exit-0 \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
  --color=bg+:#283457 \
  --color=bg:#16161e \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"

export FZF_CTRL_T_OPTS='
--preview-window right:50%
--preview "(bat --style=numbers,changes --wrap never --color always {} || highlight -O ansi -l {} || cat {} || tree -C {}) 2> /dev/null | head -200"
--bind "?:toggle-preview"
'

# Set clipboard command.
if (( $+commands[xclip] )); then
  __FZF[CPCMD]='xclip -selection clipboard'
elif (( $+commands[wl-copy] )); then
  __FZF[CPCMD]='wl-copy'
elif (( $+commands[xsel] )); then
  __FZF[CPCMD]='xsel --clipboard --input'
elif [[ "$OSTYPE" == darwin* ]]; then
  __FZF[CPCMD]='pbcopy'
fi

export FZF_CTRL_R_OPTS="
--preview 'echo {}'
--preview-window down:3:hidden:wrap
--bind '?:toggle-preview'
--bind 'ctrl-y:execute-silent(echo -n {2..} | ${__FZF[CPCMD]})+abort'
--header 'Press CTRL-Y to copy command into clipboard'
--border
"

export FZF_ALT_C_OPTS="
--preview 'tree -C {} 2> /dev/null | head -200'
--bind='alt-w:toggle-preview-wrap'
--bind='alt-k:preview-up,alt-p:preview-up'
--bind='alt-j:preview-down,alt-n:preview-down'
"

# LSCOLORS
export LSCOLORS='Gxfxcxdxbxegedabagacad'

# LS_COLORS
if [[ -z "$LS_COLORS" ]]; then
  (( $+commands[dircolors] )) && eval "$(dircolors -b)"
fi
