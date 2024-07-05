# Oh My ZSH Settings
ZSH_TMUX_FIXTERM_WITH_256_COLOR=xterm-256color
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOQUIT=false

# ZVM Settings
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

export TERM=xterm-256color

antigen use oh-my-zsh

antigen bundle git
antigen bundle lpass
antigen bundle kubectl
antigen bundle docker
antigen bundle tmux
antigen bundle terraform
antigen bundle aliases
antigen bundle nvm

antigen bundle jeffreytse/zsh-vi-mode
antigen bundle danarth/azure-cli.zsh

antigen bundle fzf

antigen bundle spaceship-prompt/spaceship-prompt

antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

EDITOR="nvim"
