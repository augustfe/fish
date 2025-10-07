function reload_fish --description "Reload the main fish configuration"
    set --local config_path ~/.config/fish/config.fish

    if not test -f $config_path
        printf "reload_fish: config not found at %s\n" $config_path >&2
        return 1
    end

    source $config_path
    echo "fish configuration reloaded"
end
