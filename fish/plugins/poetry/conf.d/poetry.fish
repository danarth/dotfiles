if command -q poetry
  poetry completions fish > $__fish_config_dir/completions/poetry.fish
end
