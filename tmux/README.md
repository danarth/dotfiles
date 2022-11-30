# Tmux Setup

Create a file under user home called  `.tmux.conf` with the following contents:

```tmux
# Set tmux terminal and enable True Colour
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"

# General tmux config and key bindings
source-file ~/dotfiles/tmux/tmux.conf

# Optional Nightfox theme to match tmux theme with Neovim
source-file ~/dotfiles/tmux/nightfox.tmux
```
