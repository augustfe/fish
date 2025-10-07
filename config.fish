
if test -d /opt/homebrew/bin
    fish_add_path /opt/homebrew/bin
end

fish_add_path /Applications/WezTerm.app/Contents/MacOS

starship init fish | source

# Make starship prompt transient
function starship_transient_prompt_func
    starship module character
end

function starship_transient_rprompt_func
    starship module time
end

enable_transience

abbr --add lg lazygit
abbr --add dotdot --regex '^\.\.+$' --function multicd
