#! zsh

# vim: ts=4 sw=4 et ai

# set aliases

[[ -n $ptolemarch_INCLUDE_set_aliases__ ]] && return 0
ptolemarch_INCLUDE_set_aliases__=$(date +%s)

source $ZDOTDIR/startup/identify-machine.zsh

# === ls ====================================================================
if [[ -n $ptolemarch_HOST_perceptyx_laptop ]]; then
    # MacOS
    ls_opts='-hF'
    export CLICOLOR=yes
else
    # Linux
    ls_opts='--sort=version --human-readable --classify --color=auto'
fi
alias l="ls $ls_opts"
alias la="ls $ls_opts -A"
alias ll="ls $ls_opts -l"
alias lal="ls $ls_opts -Al"
alias l.="ls $ls_opts -d .*"
alias lltr="ls $ls_opts -ltr"

# === grep ==================================================================
grep_opts='--color=auto'
alias grep="grep $grep_opts"
alias fgrep="fgrep $grep_opts"
alias egrep="egrep $grep_opts"

# === ( misc. ) =============================================================
alias r~m='find . -name "*~" -delete -print'
