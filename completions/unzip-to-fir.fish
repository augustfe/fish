# Show a description when completing the command name
complete -c unzip-to-dir -d 'Unzip <file.zip> into a directory with the same base name'

# Flags
complete -c unzip-to-dir -s f -l force -d 'Overwrite existing target directory'
complete -c unzip-to-dir -s q -l quiet -d 'Quiet unzip output'
complete -c unzip-to-dir -s h -l help  -d 'Show usage'

# Positional arg: only suggest *.zip files
complete -c unzip-to-dir -a '(__fish_complete_suffix .zip)' -d 'ZIP archive'
