function unzip-to-dir --description "Unzip <file.zip> into a directory with the same base name"
    # Flags: --force to overwrite target dir, --quiet for less output, --help for usage
    argparse -n unzip-to-dir 'h/help' 'f/force' 'q/quiet' -- $argv
    or return 1

    if set -q _flag_help
        echo "Usage: unzip-to-dir [-f|--force] [-q|--quiet] <file.zip>"
        return 0
    end

    if test (count $argv) -ne 1
        echo "Usage: unzip-to-dir [-f|--force] [-q|--quiet] <file.zip>"
        return 1
    end

    if not command -qs unzip
        echo "Error: 'unzip' is not installed."
        return 127
    end

    set zipfile $argv[1]
    if not test -f "$zipfile"
        echo "Error: file does not exist: $zipfile"
        return 1
    end

    # Require .zip (case-insensitive)
    if not string match -r -i -q '.*\.zip$' -- "$zipfile"
        echo "Error: not a .zip file: $zipfile"
        return 1
    end

    # Derive target dir from the basename without .zip (case-insensitive)
    set base (basename -- "$zipfile")
    set dirname (string replace -r -i '\.zip$' '' -- "$base")

    if test -e "$dirname"
        if not set -q _flag_force
            echo "Error: target directory '$dirname' already exists. Use --force to overwrite."
            return 1
        end
        rm -rf "$dirname"
    end

    mkdir -p "$dirname"

    set unzip_flags
    if set -q _flag_quiet
        set unzip_flags -q
    end
    # -n: never overwrite, -o: overwrite without prompting
    if set -q _flag_force
        set -a unzip_flags -o
    else
        set -a unzip_flags -n
    end

    command unzip $unzip_flags -- "$zipfile" -d "$dirname"
end
