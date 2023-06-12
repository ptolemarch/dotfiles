# ~/.bashrc: executed by bash(1) for interactve, non-login shells.
#   (also sourced at the beginning of my .profile)

# BASH_ENV is used to initialize non-interactive shells
BASH_ENV=~/.bash/env

# If not running interactively, don't do anything
# This is less ridiculous than it seemed to me at first:
#   - this file is sourced by ~/.profile
#   - ~/.profile is executed when "bash is invoked as an interactive login
#     shell, or as a non-interactive shell with the --login option
case $- in
    *i*) ;;
      *) return;;
esac

# I should remember to do various useful things with stty(1)
# AND NOW I HAVE
stty \
    stop undef \
    start undef

# I want to run this on work machines,
#   BUT NOT HERE AT HOME:
#ssh-add -L | perl -anE '$F[2] =~ s{^.*/.ssh/}{$ENV{HOME}/.ssh/}; $FH=">$F[2].pub"; open FH or die; $,=" "; say FH @F; close FH or die'

# == Termux ==================================================================
if [[ $PREFIX =~ com.termux ]]; then
    for i in $PREFIX/etc/profile.d/*.sh; do
        if [ -r $i ]; then
            . $i
        fi
    done
    unset i

    command_not_found_handle() {
        /data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
    }
fi

# == functions ===============================================================
# functions I might use here
# see end of .bashrc for .aliases
if [[ -f ~/.bash/functions ]]; then
    source ~/.bash/functions
fi
# functions for work
# (see also EXPORTS FOR WORK, below)
if [[ -f ~/.bash/functions.work ]]; then
    source ~/.bash/functions.work
fi

# == paths ===================================================================
export PATH="\
$HOME/bin\
:$PREFIX/bin:$PREFIX/bin/applets\
:$HOME/bin/work\
:$HOME/.yadm-project/\
:$HOME/.perl5/plenv/bin\
:$HOME/.rakudobrew/bin\
:$HOME/.go/bin\
:$HOME/.swift/usr/bin\
:/usr/lib/go-1.10/bin\
:/opt/sqldeveloper\
:/opt/ghc/bin\
:/opt/kubernetes/platforms/linux/amd64\
:/opt/android-sdk-update-manager/tools\
:/opt/android-sdk-update-manager/platform-tools\
:/usr/local/perl-trdc/bin\
:/usr/local/bin\
:/usr/local/sbin\
:/usr/games/\
:/usr/games/bin\
:/opt/X11/bin\
:/usr/X11/bin\
:/usr/bin\
:/usr/sbin\
:/bin\
:/sbin\
"
# it would be nice to interpolate $GOROOT above

# seems to do more harm than good on OSX
#export MANPATH="\
#$HOME/share/man\
#:/usr/local/share/man\
#:/usr/games/man\
#:/opt/X11/share/man\
#:/usr/X11/man\
#:/usr/share/man\
#"

export INFOPATH="\
$HOME/share/info\
:/usr/local/share/info\
:/usr/games/info\
:/usr/X11/info\
:/usr/share/info\
"

export LIBRARY_PATH="\
$HOME/lib\
:/usr/local/lib\
:/usr/games/lib\
"

export INCLUDE="\
$HOME/include\
:/usr/local/include\
:/usr/games/include\
"
export CPATH="$INCLUDE"

# == work environment ========================================================
# clearbuilt
clearbuilt_env=/srv/efab/DAVID/ENV 
[[ -r "$clearbuilt_env" ]] && source "$clearbuilt_env" 

# == mail ====================================================================
MAILCHECK=10
newmail="\e[97;41mNEW MAIL\e[m"
MAILPATH="\
~/Mail/_INCOMING?$newmail (main):\
~/Mail/IN-S-pm_to?$newmail (ThousandOaks.pm):\
~/Mail/IN-S-pm_la?$newmail (LosAngeles.pm):\
~/Mail/IN-O-cpan?$newmail (CPAN):\
~/Mail/IN-O-sigh?$newmail (DreamHost alternate):\
~/Mail/IN-O-webmaster?$newmail (webmaster):\
~/Mail/IN-O-wow?$newmail (World of Warcraft)\
"

MAIL=~/Mail/_INCOMING
MAILREADER='/usr/local/bin/mutt'
export MAIL MAILREADER

EMAIL='davidhand@davidhand.com'
REPLYTO='davidhand@davidhand.com'
PGPPATH="$HOME/.gnupg"
export EMAIL REPLYTO PGPPATH

# == configuration for Bash itself ===========================================

shopt -u dotglob  # don't include dotfiles in pathname expansion
shopt -s globstar # ** matches through subdirectories
shopt -s extglob  # turn on extended pattern matching 
am_case_sensitive || shopt -s nocaseglob # on a case-insensitive system

# filename completion ignore list
FIGNORE='.*.sw?:*~:#*#:.o:.class:.:.c.html:.java.html:.html.html:.DB_Store:._:CVS:.svn'
GLOBIGNORE="$FIGNORE"

# \e[36m : cyan (Theophany)
# TODO: for dhand, 33m (orange)
PS1='\[\e[36m\]\D{%k;%M,%S} \W \$\[\e[m\] '
PS2='\[\e[36m\]\D{%k;%M,%S} >\[\e[m\] '

#PROMPT_COMMAND=__ptolemarch_prompt_command

HISTSIZE=10000  # why the hell not
HISTIGNORE='&:##*:*(k):cd:exit:ls:ll:la:lal:uptime:from:frm:fm:fm;tfm:tfm:fmq:fmq;efm:efm:mutt:finger:users:clear:date:sb:dh.c'
HISTFILE=~/.bash/history
shopt -s histappend  # append history; don't overwrite

# ^D doesn't log you out (unless you do it 50 times in a row)
IGNOREEOF=50

# == color ===================================================================
# I think CLICOLOR is/was used in OS X?  Otherwise not sure why I have this.
export CLICOLOR='yessir'  # ls and such

if type dircolors > /dev/null 2>&1 ; then
        [[ -r ~/.bash/dircolors ]] && eval "$(dircolors -b ~/.bash/dircolors)" || eval "$(dircolors -b)"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# == general options =========================================================
## Locale stuff that perl wants set
#LANG='en_US.UTF-8'
#export LANG

EDITOR='vim'
VISUAL="$EDITOR"
PAGER='less'
LESS='-R'
HACKPAGER='less'  # for nethack
#MANPAGER='manpager'
export EDITOR VISUAL PAGER LESS HACKPAGER #MANPAGER

GTK_IM_MODULE='xim' 
export GTK_IM_MODULE

HUGSFLAGS='-E"vim +%d %s"'
export HUGSFLAGS

GOPATH="$HOME/.go"
GOROOT='/usr/lib/go-1.10'
export GOPATH GOROOT

# make less more friendly for non-text input files
#   see lesspipe(1) or read /usr/bin/lesspipe
[ -x /usr/bin/lesspipe ] && export LESSOPEN="|lesspipe %s"

# == development =============================================================

# from homebrew: The OpenSSL provided by OS X is too old for some software.
#
# Generally there are no consequences of this for you. If you build your
# own software and it requires this formula, you'll need to add to your
# build variables:
# LDFLAGS:  -L/usr/local/opt/openssl/lib
# CPPFLAGS: -I/usr/local/opt/openssl/include

# == Homebrew ================================================================
if type -p brew > /dev/null 2>&1; then
    homebrew_present="yes";
    homebrew_prefix="$(brew --prefix)"

    # allows hitting the GitHub API way harder, 'cuz signed-in
    export HOMEBREW_GITHUB_API_TOKEN=91d3c97f56952a4e4dd7de62b60c19d5196201c5

    # otherwise it's /opt/homebrew-cask/Caskroom ?!?
    export HOMEBREW_CASK_OPTS="--caskroom=$homebrew_prefix/Caskroom"
fi

# bash completion
if [ -v homebrew_prefix ]; then
    brew_bash_cmpl="$homebrew_prefix/share/bash-completion/bash_completion"
    if [ -f "$brew_bash_cmpl" ]; then
        source "$brew_bash_cmpl"
    fi
fi

# == Perl ====================================================================
perl5_root="$HOME/.perl5"
export PLENV_ROOT="$perl5_root/plenv"
# documenting this here because not sure where else
# plenv install 5.28.0 --as=teapot --test -j 8 -Doptimize=-O2 -Dusequadmath

cpanm_cpan_mirror="file://$perl5_root/minicpan/"
export PERL_CPANM_OPT="--mirror $cpanm_cpan_mirror --mirror-only"
# also there's an alias (in ~/.bash/aliases) so cpan-outdated respects the
#   $cpanm_cpan_mirror

eval "$(plenv init -)"

# == Rakudobrew ==============================================================
# for now, Gentoo seems to be tracking Rakudo quite nicely
# but maybe I'll play with rakudobrew some more
if [[ -e ~/.rakudobrew/bin/rakudobrew ]]; then
    eval "$(~/.rakudobrew/bin/rakudobrew init Bash)"
fi

# == NVM =====================================================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# == git-hub (by Ingy döt Net) ===============================================
#[[ -s ~/Code/_/git-hub/init ]] && source ~/Code/_/git-hub/init

# == rlwrap (readline command wrapper) =======================================
export RLWRAP_HOME="$HOME/.rlwrap"

# == Android SDK Update Manager ==============================================
export ANDROID_SWT='/usr/share/swt-3.7/lib'

# == EXPORTS FOR WORK ========================================================
# (see also functions for work, above)
if [[ -f ~/.bash/exports.work ]]; then
    source ~/.bash/exports.work
fi

# == aliases =================================================================
if [[ -f ~/.bash/aliases ]]; then
    source ~/.bash/aliases
fi

# == command completion ======================================================
# (straight from Ubuntu's .bashrc)
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif [ -f $PREFIX/etc/bash_completion ]; then
    . $PREFIX/etc/bash_completion
  fi
fi

# == Extraterm ===============================================================
if [[ "$CHROME_DESKTOP" == "extraterm.desktop" ]]; then
    extraterm_bin_dir="$(dirname "$(readlink -f /proc/$PPID/exe)")"
    extraterm_command_dir="${extraterm_bin_dir%%-linux*}"
    extraterm_command_dir="${extraterm_command_dir/extraterm-/extraterm-commands-}"
    if [[ -f "$extraterm_command_dir"/setup_extraterm_bash.sh ]]; then
        . "$extraterm_command_dir"/setup_extraterm_bash.sh
    fi
fi

# == yadm: Yet Another Dotfiles Manager ======================================
#export YADM_COMPATIBILITY=1  # until we've finished transitioning to YADM 2
