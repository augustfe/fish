# Equivalent to:
#   uv venv main.venv && uv export --script main.py | uv pip install -r - -p main.venv

function make-script-venv --description "Create <script>.venv for a Python script using uv"
    if test (count $argv) -ne 1
        echo "Usage: make-script-venv <script.py>" >&2
        return 1
    end

    set script $argv[1]

    if not test -f "$script"
        echo "Error: file not found: $script" >&2
        return 1
    end

    set base (basename "$script")
    if test -z (string match -r '.*\.py$' -- "$base")
        echo "Error: script must have a .py extension (got: $base)" >&2
        return 1
    end

    if not command -qs uv
        echo "Error: 'uv' is not installed or not in PATH." >&2
        return 127
    end

    set script_name (basename "$script" .py)
    set venv_path "$script_name.venv"

    uv venv "$venv_path"
    if test $status -ne 0
        echo "Error: 'uv venv' failed for $venv_path" >&2
        return 1
    end

    set requirements_file (mktemp)
    if test -z "$requirements_file"
        echo "Error: failed to create temporary requirements file." >&2
        return 1
    end

    uv export --script "$script" >"$requirements_file"
    set export_status $status
    if test $export_status -ne 0
        echo "Error: 'uv export --script' failed for $script" >&2
        rm -f "$requirements_file"
        return $export_status
    end

    uv pip install -r "$requirements_file" -p "$venv_path"
    set install_status $status
    rm -f "$requirements_file"

    if test $install_status -ne 0
        echo "Error: failed to install dependencies into $venv_path" >&2
        return $install_status
    end

    echo "Done. Virtual environment created at '$venv_path'."
end
