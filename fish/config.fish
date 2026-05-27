if status is-interactive
  set fish_greeting
  starship init fish | source

  # ASDF configuration code
  if test -z $ASDF_DATA_DIR
      set _asdf_shims "$HOME/.asdf/shims"
  else
      set _asdf_shims "$ASDF_DATA_DIR/shims"
  end

  # Do not use fish_add_path (added in Fish 3.2) because it
  # potentially changes the order of items in PATH
  if not contains $_asdf_shims $PATH
      set -gx --prepend PATH $_asdf_shims
  end
  set --erase _asdf_shims

  fish_vi_key_bindings

  function fish_mode_prompt; end

  bind -M insert -m default j,k cancel repaint-mode
  set -g fish_sequence_key_delay_ms 200

  asdf completion fish > ~/.config/fish/completions/asdf.fish
end
