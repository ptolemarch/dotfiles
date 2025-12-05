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
autoload -Uz vcs_info
zstyle ':vcs_info:*' disable cdv cvs tla mtn p4 svk

parse_git_dirty() {
  git_status="$(git status 2> /dev/null)"
  [[ "$git_status" =~ "Changes to be committed:" ]] && echo -n "%F{green}·%f"
  [[ "$git_status" =~ "Changes not staged for commit:" ]] && echo -n "%F{yellow}·%f"
  [[ "$git_status" =~ "Untracked files:" ]] && echo -n "%F{red}·%f"
}

setopt prompt_subst

NEWLINE=$'\n'

autoload -Uz vcs_info # enable vcs_info
precmd () { vcs_info } # always load before displaying the prompt
zstyle ':vcs_info:git*' formats ' ↣ (%F{254}%b%F{245})' # format $vcs_info_msg_0_

#PS1='%F{254}%n%F{245} ↣ %F{153}%(5~|%-1~/⋯/%3~|%4~)%F{245}${vcs_info_msg_0_} $(parse_git_dirty)$NEWLINE%F{254}$%f '

#PS1='%(?..
