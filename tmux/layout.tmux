#!/usr/bin/env bash

set -g mode-style "fg=${theme_bg0},bg=${theme_fg2}"
set -g message-style "fg=${theme_bg0},bg=${theme_fg0}"
set -g message-command-style "fg=${theme_bg0},bg=${theme_fg0}"
set -g pane-border-style "fg=${theme_fg0}"
set -g pane-active-border-style "fg=${theme_oceanblue}"
set -g status "on"
set -g status-justify "left"
set -g status-style "fg=${theme_fg0},bg=${theme_bg0}"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left-style NONE
set -g status-right-style NONE

set -g @prefix_highlight_output_prefix " "
set -g @prefix_highlight_output_suffix " "
set -g @prefix_highlight_bg "${theme_oceanblue}"
set -g @prefix_highlight_fg "${theme_bg0}"

set -g status-left "#[fg=${theme_bg0},bg=${theme_oceanblue}] #S #[fg=${theme_oceanblue},bg=${theme_bg0}]"

# TODO: Need to clean this up and extract keyboard layout to a separate script
set -g status-right "#{prefix_highlight}#[fg=${theme_fg3},bg=${theme_bg0}]#[fg=${theme_bg0},bg=${theme_fg3}] %Y-%m-%d %I:%M%p #[fg=${theme_fg0},bg=${theme_fg3}]#[fg=#192330,bg=${theme_fg0}] 󰌌 #(setxkbmap -query | awk '/layout/ {print $2}') #[fg=${theme_bg0},bg=${theme_fg0}]#[fg=${theme_oceanblue},bg=${theme_bg0}]#[fg=${theme_bg0},bg=${theme_oceanblue}] #h "

setw -g window-status-activity-style "underscore,fg=${theme_fg3},bg=${theme_bg0}"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=${theme_fg3},bg=${theme_bg0}"

setw -g window-status-format "#[fg=${theme_bg0},bg=${theme_bg0}] #[fg=${theme_fg3}]#I #[fg=${theme_bg0}] #[fg=${theme_fg3}]#W #F #[fg=${theme_bg0}]"

setw -g window-status-current-format "#[fg=${theme_bg0},bg=${theme_fg0}]#[fg=${theme_bg0},bg=${theme_fg0}] #I #[fg=${theme_fg0},bg=${theme_fg3}] #[fg=#192330]#W #F #[fg=${theme_fg3},bg=${theme_bg0}]"

