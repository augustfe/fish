function fish_greeting --description "Run fastfetch on shell start when available"
    if type -q fastfetch
        fastfetch
    else
        printf "Welcome back, %s\n" $USER
    end
end
