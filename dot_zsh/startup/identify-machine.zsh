#! zsh
# vim: ts=4 sw=4 et ai

# intended to be sourced by startup files

[[ -n $ptolemarch_INCLUDE_identify_machine__ ]] && return 0
ptolemarch_INCLUDE_identify_machine__=$(date +%s)

() { # anonymous function
    local hostname=$(hostname -s)  # hostname without domain name
    local uname=$(uname -o || uname) 2> /dev/null

    export ptolemarch_HOST_name="$hostname"
    export ptolemarch_HOST_uname="$uname"

    if [[ $uname = 'Darwin' && $hostname = 'David-Hand' ]]; then
        export ptolemarch_HOST_perceptyx_laptop=true
    elif [[ $uname = 'FreeBSD' && $hostname = 'dhand' ]]; then
        export ptolemarch_HOST_perceptyx_jail=true
    elif [[ $uname = 'GNU/Linux' && $hostname = 'patrick' ]]; then
        export ptolemarch_HOST_patrick=true
    elif [[ $uname = 'GNU/Linux' && $hostname = 'penguin' ]]; then
        export ptolemarch_HOST_chromebook=true
    elif [[ $uname = 'Android' ]]; then
        export ptolemarch_HOST_phone=true
    fi
}
