function fresh --description "Reload the shell configuration and rerun the greeting"
    reload_fish
    and clear
    and fish_greeting
end
