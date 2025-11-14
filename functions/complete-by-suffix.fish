# Autocompletion helper: complete candidates by suffix(es)
# Usage: complete-by-suffix .ext1 .ext2 ...

# Example:
#   complete -c unzip-to-dir -f \
#       -n 'test (count (commandline -opc)) -eq 1' \
#       -a '(complete-by-suffix .zip .tar.gz)'
# should suggest only files ending with .zip or .tar.gz

function complete-by-suffix
    set -l exts $argv
    set -l token (commandline -ct)

    complete -C "__fish_command_without_completions $token" | while read -l cand
        for ext in $exts
            if string match -r -- ".*$ext\$" -- "$cand"
                echo "$cand"
                break
            end
        end
    end
end
