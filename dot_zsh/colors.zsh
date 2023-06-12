#! zsh

# vim: ts=4 sw=4 et ai

# functions involving colors

[[ -n $ptolemarch_INCLUDE_colors__ ]] && return 0
ptolemarch_INCLUDE_colors__=$(date +%s)

# thoughts:
#  - iTerm2 and Termux both set COLORTERM
#  - does COLORTERM follow you through ssh?
#    - not by default
#      - on the client, you'd need to set SendEnv {var-pattern}
#      - on the server, you'd need to set AcceptEnv {var-pattern}
#  - there are two promising things on github that seem to do about what I want:
#    https://github.com/philFernandez/printc
#    https://github.com/zpm-zsh/colors
#  - it would be massively cool if I could use terminal escape codes to query
#    color support, but that looks unlikely
#    - that said, here's iTerm2's docs on the subject: https://iterm2.com/documentation-escape-codes.html
#
#  - an interesting "generic colorizer" exists in the form of `grc`:
#    https://korpus.juls.savba.sk/~garabik/software/grc.html
#    - see also `brew info grc`
