
if test -d /opt/homebrew/bin
    fish_add_path /opt/homebrew/bin
end

fish_add_path /Applications/WezTerm.app/Contents/MacOS

starship init fish | source

abbr --add lg lazygit
abbr --add dotdot --regex '^\.\.+$' --function multicd
