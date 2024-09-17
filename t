[1mdiff --git a/tmux/tmux.conf b/tmux/tmux.conf[m
[1mindex 95bdd7b..2114460 100644[m
[1m--- a/tmux/tmux.conf[m
[1m+++ b/tmux/tmux.conf[m
[36m@@ -2,6 +2,10 @@[m [mset-option -g default-shell /bin/zsh[m
 set -g default-terminal "tmux-256color"[m
 set -ag terminal-overrides ",xterm-256color:RGB"[m
 [m
[32m+[m[32m# Requires tmux 3.3 or later but provides image support with Kitty and icat[m
[32m+[m[32mset -g allow-passthrough on[m
[32m+[m[32mbind-key P display-popup -b rounded[m
[32m+[m
 # Double press Ctrl-B to clear the screen[m
 bind-key 'C-b' send-keys 'C-l'[m
 [m
