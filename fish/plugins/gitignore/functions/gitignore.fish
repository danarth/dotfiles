function gitignore --description "Edit .gitignore files"
  if not set -q argv[1]
    set -f scope ""
  else
    set -f scope $argv[1]
  end

  if contains $scope public private nearest; and not __gitignore.is_git_repo;
    echo "Must be inside git repo for $scope"
    return 1
  end

  switch $scope
    case global
      set global_git_config $HOME/.config/git
      if not test -d $global_git_config
        mkdir -p $global_git_config
      end
      $EDITOR (path normalize "$global_git_config/ignore")
    case public
      set repo_dir (git rev-parse --show-toplevel; or echo ".")
      $EDITOR (path normalize "$repo_dir/.gitignore")
    case private
      set repo_dir (git rev-parse --show-toplevel; or echo ".")
      $EDITOR (path normalize "$repo_dir/.git/info/exclude")
    case nearest
      $EDITOR (__gitignore.nearest_gitignore)
    case '*'
      if __gitignore.is_git_repo
        gitignore nearest
      else
        gitignore global
      end
  end
end

function __gitignore.is_git_repo
  if not git rev-parse --is-inside-work-tree &>/dev/null
    return 1
  end
  return 0
end

function __gitignore.nearest_gitignore
  set filename ".gitignore"
  if __gitignore.is_git_repo
    set repo_dir (path resolve (git rev-parse --show-toplevel; or echo "."))
    set -l dir (pwd)
    while test "$dir" != "$repo_dir"
      if test -e "$dir/$filename"
        echo "$dir/$filename"
        return 0
      end
      set dir (path dirname $dir)
    end
    # Check repo root too
    if test -e "$repo_dir/$filename"
      echo (path normalize "$repo_dir/$filename")
      return 0
    end
  end
  return 1
end
