set fish_greeting

if command -q asdf
  starship init fish | source
end

fish_vi_key_bindings

function fish_mode_prompt; end

bind -M insert -m default j,k cancel repaint-mode
set -g fish_sequence_key_delay_ms 200

