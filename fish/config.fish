if set -q NVIM; and command -q nvr
  set -gx GIT_EDITOR "nvr -cc split --remote-wait"
end

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

fish_config theme choose duskfox

function get_python_run_prefix
  if test -r uv.lock
    echo -n "uv run "
  else if test -r poetry.lock
    echo -n "poetry run "
  else if test -r Pipfile.lock
    echo -n "pipenv run "
  else if test -d .venv; and not set -q VIRTUAL_ENV
    echo "Error: manual venv detected, run $(set_color blue)source .venv/bin/activate.fish$(set_color normal)" >&2
    commandline -r "source .venv/bin/activate.fish"
  end
end

function ide
  eval $(get_python_run_prefix) nvim -c ":Neotree"
end
