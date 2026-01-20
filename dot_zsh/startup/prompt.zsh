#! zsh

# vim: ts=4 sw=4 et ai

# set prompt, programmatically
#
# See 'EXPANSION OF PROMPT SEQUENCES' and following sections
#  at the end of zshmisc(1)
#
# things it should have:
#  - colored per-machine and highlighted for root
#  - directory %~
#  - time
#  - # of running jobs %j
#  - parser status (i.e. in an if loop) %_ %^
#  - runtime of last command (if above some threshold?)
#      https://github.com/popstas/zsh-command-time
#      https://tomfromberlin.github.io/zsh-cmd-time/
#      https://tau.gr/posts/2021-06-08-zsh-command-time/
#      https://kevinlui.org/posts/alerting_long_commands_in_zsh/
#      https://gist.github.com/knadh/123bca5cfdae8645db750bfb49cb44b0
#  - exit code of last command
#  - plenv
#    - is there a global Perl version set? (maybe, but prolly there always will be...)
#    - is there a local (per-directory) Perl version set?
#    - is there a shell-specific Perl version set?
#  - maybe something similar for Rakubrew?
#  - mail?
#  - git
#      https://github.com/zimfw/duration-info
#    - branch
#    - clean/dirty
#  - docker? kubernetes?
#  - exotic stuff
#    - system load? 
#    - (on remote hosts) latency?!? (could this be possible?)

# The following is taken from "PARAMETERS USED BY THE SHELL" in zshparam(1):
# PS1    The  primary prompt string, printed before a command is read.  It undergoes a special form of expansion
#        before being displayed; see EXPANSION OF PROMPT SEQUENCES in zshmisc(1).  The default is `%m%# '.
#
# PS2    The secondary prompt, printed when the shell needs more information to complete a command.  It  is  ex‐
#        panded in the same way as PS1.  The default is `%_> ', which displays any shell constructs or quotation
#        marks which are currently being processed.
#
# PS3    Selection prompt used within a select loop.  It is expanded in the same way as PS1.  The default is `?#
#        '.
#
# PS4    The execution trace prompt.  Default is `+%N:%i> ', which displays the name of the current shell struc‐
#        ture and the line number within it.  In sh or ksh emulation, the default is `+ '.
#
# RPS1   This prompt is displayed on the right-hand side of the screen when the primary  prompt  is  being  dis‐
#        played  on  the  left.  This does not work if the SINGLE_LINE_ZLE option is set.  It is expanded in the
#        same way as PS1.
#
# RPS2   This prompt is displayed on the right-hand side of the screen when the secondary prompt is  being  dis‐
#        played  on  the  left.  This does not work if the SINGLE_LINE_ZLE option is set.  It is expanded in the
#        same way as PS2.

source $ZDOTDIR/startup/basic.zsh
source $ZDOTDIR/startup/identify-machine.zsh

REPORTTIME=5

# return status
left=$'\U2983'
right=$'\U2984'
error_status="%F{#DB1F36}$left%B%?%b$right%f"
return_status="%0(?::$error_status )"

# time
pale_yellow='#FFFFBB'  # might be interesting to select color based on time of day
time="%F{$pale_yellow}%D{%-k;%-M,%-S}%f"

# jobs
jobs='%1(j:%j:) '

# shell level (recursive depth)
integral=$'\U222b'
double_integral=$'\U222c'
triple_integral=$'\U222d'
vivid_cyan='#1FD2DB'
shell_level="%F{$vivid_cyan}%2(L:%3(L:$triple_integral:$double_integral):$integral)%f"

# directory
directory='%~'

PS1="$return_status$jobs$time $directory $shell_level "


# https://vincent.bernat.ch/en/blog/2019-zsh-async-vcs-info
#autoload -Uz vcs_info
#zstyle ':vcs_info:*' disable cdv cvs tla mtn p4 svk
#
#parse_git_dirty() {
#  git_status="$(git status 2> /dev/null)"
#  [[ "$git_status" =~ "Changes to be committed:" ]] && echo -n "%F{green}·%f"
#  [[ "$git_status" =~ "Changes not staged for commit:" ]] && echo -n "%F{yellow}·%f"
#  [[ "$git_status" =~ "Untracked files:" ]] && echo -n "%F{red}·%f"
#}
#
#setopt prompt_subst
#setopt prompt_percent
#
#NEWLINE=$'\n'
#
#autoload -Uz vcs_info # enable vcs_info
#precmd () { vcs_info } # always load before displaying the prompt
#zstyle ':vcs_info:git*' formats ' ↣ (%F{254}%b%F{245})' # format $vcs_info_msg_0_
#
#PS1='%F{254}%n%F{245} ↣ %F{153}%(5~|%-1~/⋯/%3~|%4~)%F{245}${vcs_info_msg_0_} $(parse_git_dirty)$NEWLINE%F{254}$%f '
