# Disable default file completions and provide our own
complete -c make-script-venv -e

complete -c make-script-venv -d 'Create <script>.venv for a Python script using uv'

# First (and only) argument: Python scripts (*.py)
complete -c make-script-venv \
    -f \
    -n 'test (count (commandline -opc)) -eq 1' \
    -a '(complete-by-suffix .py)'
