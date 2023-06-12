#! zsh

# vim: ts=4 sw=4 et ai

# set prompt, programmatically
#
# things it should have:
#  - colored per-machine and highlighted for root
#  - directory
#  - time
#  - runtime of last command (if above some threshold?)
#  - exit code of last command
#  - plenv
#    - is there a global Perl version set? (maybe, but prolly there always will be...)
#    - is there a local (per-directory) Perl version set?
#    - is there a shell-specific Perl version set?
#  - maybe something similar for Rakubrew?
#  - mail?
#  - git
#    - branch
#    - clean/dirty
#  - docker? kubernetes?
#  - exotic stuff
#    - system load? 
#    - (on remote hosts) latency?!? (could this be possible?)

[[ -n $ptolemarch_INCLUDE_set_prompt__ ]] && return 0
ptolemarch_INCLUDE_set_prompt__=$(date +%s)

source $ZDOTDIR/startup/basic.zsh
source $ZDOTDIR/startup/identify-machine.zsh

# https://vincent.bernat.ch/en/blog/2019-zsh-async-vcs-info
#autoload -Uz vcs_info
