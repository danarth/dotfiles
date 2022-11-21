# Oh My ZSH Settings
ZSH_TMUX_FIXTERM_WITH_256_COLOR=xterm-256color
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOQUIT=false

export TERM=xterm-256color

antigen use oh-my-zsh

antigen bundle git
antigen bundle lpass
antigen bundle kubectl
antigen bundle docker
antigen bundle tmux

antigen bundle nyquase/vi-mode
antigen bundle b4b4r07/zsh-vimode-visual

# fzf needs to be applied after vi-mode
antigen bundle fzf

antigen bundle spaceship-prompt/spaceship-prompt

antigen apply

EDITOR="nvim"
