ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_FIXTERM_WITH_256_COLOR=xterm-256color

antigen use oh-my-zsh

antigen bundle git
antigen bundle fzf
antigen bundle kubectl
antigen bundle docker
antigen bundle tmux

antigen bundle spaceship-prompt/spaceship-prompt

antigen apply

EDITOR="vim"
