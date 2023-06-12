#! zsh

# vim: ts=4 sw=4 et ai

# functions I consider fairly basic, even for my other functions

[[ -n $ptolemarch_INCLUDE_basic__ ]] && return 0
ptolemarch_INCLUDE_basic__=$(date +%s)

# TODO: replace with startup/functional/function.plugin.zsh
source $ZDOTDIR/startup/lists.zsh

# echo the name of the current function or script or whatever. Mostly for
#  warn_ and die_

not_underscored_()
{
    local subject=$1

    [[ $subject =~ _$ ]] && return 1
    return 0
}

self_()
{
    setopt posix_argzero

    # skip helper functions (ending with _)
    local funcname=$(first_ not_underscored_ $funcstack)

    # if in a (non-helper) function, use that
    if [[ -n $funcname && $funcname != main ]]; then
        print -- $funcname
        return 0
    fi

    if [[ $0 =~ ^- ]]; then
        print -- $0
    else
        print -- $(basename $0)
    fi
    return 0
}

warn_()
{
    # weird syntax necessary to prevent array "elision". See zshexpn(1)
    for line in "${(@)argv}"; do
        print -u 2 $line
    done
}

die_()
{
    errno=$1
    warn_ "${(@)argv[2,-1]}"
    exit $errno
}
