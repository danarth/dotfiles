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

set -g @prefix_highlight_output_prefix " "
set -g @prefix_highlight_output_suffix " "
set -g @prefix_highlight_bg "#719cd6"
set -g @prefix_highlight_fg "#131a24"

set -g status-left "#[fg=#131a24,bg=#719cd6] #S #[fg=#719cd6,bg=#131a24]"

# TODO: Need to clean this up and extract keyboard layout to a separate script
set -g status-right "#{prefix_highlight}#[fg=#71839b,bg=#131a24]#[fg=#131a24,bg=#71839b] %Y-%m-%d %I:%M%p #[fg=#ffffff,bg=#71839b]#[fg=#192330,bg=#ffffff] 󰌌 #(setxkbmap -query | awk '/layout/ {print $2}') #[fg=#131a24,bg=#ffffff]#[fg=#719cd6,bg=#131a24]#[fg=#131a24,bg=#719cd6] #h "

setw -g window-status-activity-style "underscore,fg=#71839b,bg=#131a24"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#71839b,bg=#131a24"

setw -g window-status-format "#[fg=#131a24,bg=#131a24] #[fg=#71839b]#I #[fg=#131a24] #[fg=#71839b]#W #F #[fg=#131a24]"

setw -g window-status-current-format "#[fg=#131a24,bg=#ffffff]#[fg=#131a24,bg=#ffffff] #I #[fg=#ffffff,bg=#71839b] #[fg=#192330]#W #F #[fg=#71839b,bg=#131a24]"
