#!/usr/bin/env bash
# Nightfox colors for Tmux
# Style: nightfox
# Upstream: https://github.com/edeneast/nightfox.nvim/raw/main/extra/nightfox/nightfox_tmux.tmux

set -g mode-style "fg=#131a24,bg=#aeafb0"
set -g message-style "fg=#131a24,bg=#ffffff"
set -g message-command-style "fg=#131a24,bg=#ffffff"
set -g pane-border-style "fg=#ffffff"
set -g pane-active-border-style "fg=#719cd6"
set -g status "on"
set -g status-justify "left"
set -g status-style "fg=#ffffff,bg=#131a24"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left-style NONE
set -g status-right-style NONE

# Session Name
set -g status-left "#[fg=#131a24,bg=#719cd6] #S #[fg=#719cd6,bg=#131a24]"

# Device Name, Time and Date
set -g status-right "#[fg=#71839b,bg=#131a24]#[fg=#131a24,bg=#71839b] %Y-%m-%d #[fg=#ffffff,bg=#71839b]#[fg=#192330,bg=#ffffff] %I:%M %p #[fg=#131a24,bg=#ffffff]#[fg=#719cd6,bg=#131a24]#[fg=#131a24,bg=#719cd6] #h "

setw -g window-status-activity-style "underscore,fg=#71839b,bg=#131a24"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#71839b,bg=#131a24"

setw -g window-status-format "#[fg=#131a24,bg=#131a24] #[fg=#71839b]#I #[fg=#131a24] #[fg=#71839b]#W #F #[fg=#131a24]"

setw -g window-status-current-format "#[fg=#131a24,bg=#ffffff]#[fg=#131a24,bg=#ffffff] #I #[fg=#ffffff,bg=#71839b] #[fg=#192330]#W #F #[fg=#71839b,bg=#131a24]"
