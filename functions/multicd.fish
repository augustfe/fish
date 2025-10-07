function multicd --description "Change directory multiple levels up using dots"
    if test (count $argv) -eq 0
        return 0
    end

    set --local dots $argv[1]
    set --local depth (string length -- $dots)

    if test $depth -lt 2
        return 0
    end

    set --local target (string repeat -n (math $depth - 1) ../)
    cd $target
end
