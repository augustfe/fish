# Clear any old completions (optional but nice when iterating)
complete -c unzip-to-dir -e

# Command description (shows when completing the command name)
complete -c unzip-to-dir -d 'Unzip <file.zip> into a directory with the same base name'

# Flags (these appear when you type: unzip-to-dir --<TAB>)
complete -c unzip-to-dir -s f -l force -d 'Overwrite existing target directory' -n 'not __fish_seen_argument -s f -l force'
complete -c unzip-to-dir -s q -l quiet -d 'Quiet unzip output' -n 'not __fish_seen_argument -s q -l quiet'
complete -c unzip-to-dir -s h -l help -d 'Show usage' -n 'not __fish_seen_argument -s h -l help'

# Use only our filtered candidates for the first argument
complete -c unzip-to-dir \
    -f \
    -n 'test (count (commandline -opc)) -eq 1' \
    -a '(complete-by-suffix .zip .tar.gz)'
