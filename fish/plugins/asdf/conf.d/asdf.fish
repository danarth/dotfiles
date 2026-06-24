if command -q asdf
  if test -z "$ASDF_DATA_DIR"
      set _asdf_shims "$HOME/.asdf/shims"
  else
      set _asdf_shims "$ASDF_DATA_DIR/shims"
  end

  if not contains $_asdf_shims $PATH
      fish_add_path --move --path $_asdf_shims
  end
  set -e _asdf_shims

  asdf completion fish > $__fish_config_dir/completions/asdf.fish
end
