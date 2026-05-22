#
# zshenv
#

# Skip the not really helping Ubuntu global compinit
skip_global_compinit=1

# XDG Base Directories
export XDG_BIN_HOME=${XDG_BIN_HOME:-$HOME/.local/bin}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

# ZDOTDIR
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Local configuration file.
export LOCALRC="$ZDOTDIR/.local"
export PATH=$PATH:/opt/homebrew/bin:~/.local/bin:"/Applications/Visual Studio Code.app/Contents/Resources/app/bin":"/Applications/Meld.app/Contents/MacOS"
meld() {
	"/Applications/Meld.app/Contents/MacOS/Meld" "$@"
}
alias kn4j="kubectl -n ns-kcl-ap-edhpro-soi-neo4j"
alias kl="kubectl -n ns-kcl-ap-edhpro-soi-linkurious"
