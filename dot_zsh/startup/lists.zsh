#! zsh

# vim: ts=4 sw=4 et ai

# Took some hints from 
#  http://yannesposito.com/Scratch/en/blog/Higher-order-function-in-zsh/
# and
#  https://github.com/Tarrasch/zsh-functional
# in fact, maybe I should just be using the latter.
# -- And, in fact, yes I should. zsh-functional seems to be using some
#    interesting tricks to "return" arrays, for example by putting individual
#    elements on multiple lines.

[[ -n $ptolemarch_INCLUDE_lists__ ]] && return 0
ptolemarch_INCLUDE_lists__=$(date +%s)

# echo the first element that matches and return true
#  if no match, return false
first_()
{
    local predicate=$1

    for subject in $argv[2,-1]; do
        # can also use $subject in $predicate
        if eval $predicate $subject > /dev/null ; then
            print -- $subject
            return
        fi
    done

    return 1
}

filter_()
{
    local predicate=$1
    local result=()

    for subject in $argv[2,-1]; do
        # can also use $subject in $predicate
        if eval $predicate $subject > /dev/null ; then
            result=( $result $subject )
        fi
    done

    print -- $result
    return 0
}

