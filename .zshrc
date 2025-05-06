# Oh My ZSH Settings
ZSH_TMUX_FIXTERM_WITH_256_COLOR=xterm-256color
ZSH_TMUX_AUTOSTART=false
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOQUIT=false

# ZVM Settings
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

antigen use oh-my-zsh

antigen bundle git
antigen bundle taskwarrior
antigen bundle kubectl
antigen bundle docker
antigen bundle terraform
antigen bundle aliases
antigen bundle jump
antigen bundle eza
antigen bundle asdf

antigen bundle jeffreytse/zsh-vi-mode

antigen bundle fzf

antigen bundle spaceship-prompt/spaceship-prompt
antigen bundle spaceship-prompt/spaceship-vi-mode@main
antigen bundle danarth/spaceship-taskwarrior@main

antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

# Spaceship Prompt
spaceship remove taskwarrior
spaceship add taskwarrior

spaceship remove vi_mode
spaceship add --before char vi_mode
eval spaceship_vi_mode_enable

EDITOR="nvim"

# If we're in an integrated nvim terminal, use it for git messages
if [[ -n "$NVIM" && -x "$(command -v nvr)" ]]; then
  export GIT_EDITOR="nvr -cc split --remote-wait"
fi

DISABLE_AUTO_TITLE=true
