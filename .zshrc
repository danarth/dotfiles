# Oh My ZSH Settings
ZSH_TMUX_FIXTERM_WITH_256_COLOR=xterm-256color

# ZVM Settings
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

function is-macos() {
  [[ $OSTYPE == darwin* ]]
}

antidote bundle getantidote/use-omz
antidote bundle ohmyzsh/ohmyzsh path:lib
antidote bundle ohmyzsh/ohmyzsh path:plugins/git
antidote bundle ohmyzsh/ohmyzsh path:plugins/docker
antidote bundle ohmyzsh/ohmyzsh path:plugins/aliases
antidote bundle ohmyzsh/ohmyzsh path:plugins/jump
antidote bundle ohmyzsh/ohmyzsh path:plugins/eza
antidote bundle ohmyzsh/ohmyzsh path:plugins/asdf

antidote bundle jeffreytse/zsh-vi-mode

antidote bundle ohmyzsh/ohmyzsh path:plugins/fzf

antidote bundle zsh-users/zsh-syntax-highlighting
antidote bundle zsh-users/zsh-autosuggestions

# MacOS Specific
antidote bundle ohmyzsh/ohmyzsh path:plugins/brew conditional:is-macos
antidote bundle ohmyzsh/ohmyzsh path:plugins/macos conditional:is-macos

eval "$(starship init zsh)"

EDITOR="nvim"

# If we're in an integrated nvim terminal, use it for git messages
if [[ -n "$NVIM" && -x "$(command -v nvr)" ]]; then
  export GIT_EDITOR="nvr -cc split --remote-wait"
fi

DISABLE_AUTO_TITLE=true
