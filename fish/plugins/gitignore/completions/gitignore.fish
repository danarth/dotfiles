complete -c gitignore -f -n "test (count (commandline -opc)) -eq 1" -a "global" -d "Edit global .gitignore file"
complete -c gitignore -f -n "test (count (commandline -opc)) -eq 1" -a "public" -d "Edit current project's committed .gitignore file"
complete -c gitignore -f -n "test (count (commandline -opc)) -eq 1" -a "private" -d "Edit your private .gitignore file for this current project"
complete -c gitignore -f -n "test (count (commandline -opc)) -eq 1" -a "nearest" -d "Edit your nearest .gitignore file, traversing up the file tree"

