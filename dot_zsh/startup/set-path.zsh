#! zsh

# vim: ts=4 sw=4 et ai

# set PATH, programmatically

[[ -n $ptolemarch_INCLUDE_set_path__ ]] && return 0
ptolemarch_INCLUDE_set_path__=$(date +%s)

source $ZDOTDIR/startup/basic.zsh
source $ZDOTDIR/startup/identify-machine.zsh

# ======================================================================
#   Discussion
# ----------------------------------------------------------------------

# I wonder whether it's overkill to build the PATH programmatically, but I'm
# going to do it anyway.
#
# The argument for "overkill" goes as follows:
#  - If an item is not present, it'll just be skipped and ignored by the shell.
#  - If on the other hand the item is present, presumably it should be used,
#    and in the order given, right?
# For example: On my work server, I want to include early in my PATH the proper
# perl binary to use:
#   /opt/perl/perls/perl-5.28.1/bin/
# but since this directory isn't present on, for example, my work laptop, it
# does no harm there. And what if it were present? Presmably it would still be
# the perl I'd want to run, right?
#
# But, no, I don't think that follows, now that I think on it further. Indeed,
# I could even imagine having accounts on multiple work machines, each of which
# possibly requiring a different path to its preferred perl, yet having the
# un-preferred perls installed. I'm not saying this is likely, but it's
# entirely possible.
#
# The situation that makes me think this is worthwhile, though, is that of
# Termux on Android. There, the entire system is installed in a subdirectory,
# the location of which is given in the $PREFIX environment variable. For
# example, vim is located at $PREFIX/bin/vim. If we're not in Termux, $PREFIX
# would be empty or, worse, could mean something else entirely. In this
# particular case, adding $PREFIX/bin to my path would just mean, if $PREFIX is
# empty, that /bin appears twice in the path, probably one right after the
# other. That is, it wouldn't cause much trouble. But still.

# ======================================================================
#   Functions
# ----------------------------------------------------------------------

# Since I'm going to be replacing the PATH, not adding to it, let's
# encode the default path, and then check it here. Report to the user
# if it's different since last we looked.
has_path_changed()
{
    local expected=$1

    [[ $expected = $PATH ]] \
    || warn_ 'The default PATH has changed.' \
             'the last time we recorded it, it was:' \
             "  $expected" \
             'but now it is:' \
             "  $PATH"
}

# ======================================================================
#   Documentation of default PATHs on various machines
# ----------------------------------------------------------------------

# MacOS sets path by running /usr/libexec/path_helper (in /etc/csh.login,
# /etc/profile, or /etc/zprofile), which claims (in path_helper(8)) to
# get its configuration from
#   /etc/paths, /etc/paths.d/*, /etc/manpaths, and /etc/manpaths.d/*
# As of macOS Ventura 13.3, the default seems to be, for PATH:
#   - /usr/local/bin
#   - /System/Cryptexes/App/usr/bin
#   - /usr/bin
#   - /bin
#   - /usr/sbin
#   - /sbin
#   - /Library/Apple/usr/bin
#   - /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin
#   - /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin
#   - /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin
# for MANPATH:
#   - /usr/share/man
#   - /usr/local/share/man
# (no INFOPATH)
[[ -n $ptolemarch_HOST_perceptyx_laptop ]] \
&& has_path_changed \
  '/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin'
# the above came in with macOS Ventura 13.3. Before that, it had been
#  '/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin'

# At Perceptyx, using the default Bash installation, PATH is:
#   - /opt/perl/perls/perl-5.28.1/bin/
#   - /opt/perl/bin
#   - /sbin
#   - /bin
#   - /usr/sbin
#   - /usr/bin
#   - /usr/games
#   - /usr/local/sbin
#   - /usr/local/bin
#   - /home/dhand/bin
# (indeed, they put my ~/bin at the end)
# but using zsh as my login shell, it is:
#  - /sbin
#  - /bin
#  - /usr/sbin
#  - /usr/bin
#  - /usr/local/sbin
#  - /usr/local/bin
#  - /home/dhand/bin
# and MANPATH is:
#   - /opt/perl/perls/perl-5.28.1/man/
#   - /usr/share/man
#   - /usr/local/man
#   - /usr/local/share/man
#   - /usr/share/openssl/man
#   - /usr/local/lib/perl5/site_perl/man
#   - /usr/local/lib/perl5/5.28/perl/man
#   - /usr/local/lib/perl5/5.30/perl/man
# note that I had to add the first element (the path to the correct perl)
# (no INFOPATH)
# NOTE this below is how PATH is reported to zsh
[[ -n $ptolemarch_HOST_perceptyx_jail ]] \
&& has_path_changed \
  '/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:/home/dhand/bin'

# on Patrick, my personal Gentoo laptop, PATH seems to be:
# - /usr/local/sbin
# - /usr/local/bin
# - /usr/sbin
# - /usr/bin
# - /sbin
# - /bin
# - /opt/bin
# - /usr/lib/llvm/10/bin
# MANPATH seems to be:
# - /usr/share/gcc-data/x86_64-pc-linux-gnu/9.3.0/man
# - /usr/share/binutils-data/x86_64-pc-linux-gnu/2.33.1/man
# - /usr/local/share/man
# - /usr/share/man
# - /usr/share/rust-1.45.2/man
# - /usr/lib/llvm/10/share/man
# INFOPATH seems to be:
# - /usr/share/gcc-data/x86_64-pc-linux-gnu/9.3.0/info
# - /usr/share/binutils-data/x86_64-pc-linux-gnu/2.33.1/info
# - /usr/share/info
# These are set in /etc/profile.env, which is written by env-update(1), which
# "is run by emerge(1) automatically after each package merge."
# 
[[ -n $ptolemarch_HOST_patrick ]] \
&& has_path_changed \
  '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:/usr/lib/llvm/10/bin'

# on Chromebook, PATH seems to be:
# - /usr/local/sbin
# - /usr/local/bin
# - /usr/local/games
# - /usr/sbin
# - /usr/bin
# - /usr/games
# - /sbin
# - /bin
# (no MANPATH)
# (no INFOPATH)
[[ -n $ptolemarch_HOST_chromebook ]] \
&& has_path_changed \
  '/usr/local/sbin:/usr/local/bin:/usr/local/games:/usr/sbin:/usr/bin:/usr/games:/sbin:/bin'

# on Termux, PATH is:
# - /data/data/com.termux/files/usr/bin
# - /data/data/com.termux/files/usr/bin/applets
# (no MANPATH)
# (no INFOPATH)
[[ -n $ptolemarch_HOST_phone ]] \
&& has_path_changed \
  '/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/bin/applets'

# ======================================================================
#   Now set the PATH
# ----------------------------------------------------------------------

# save the old PATH
ptolemarch_PATH_default=($path)

# these things are always first in line
path=(
    $HOME/bin 
    $HOME/.local/kitty.app/bin
    $HOME/.local/bin
    $HOME/.yadm-project
    # also rakubrew
)

if ! [[ -n $ptolemarch_HOST_perceptyx_jail ]]; then
    # perceptyx jail uses perlbrew, so don't use plenv
    path+=(
        $HOME/.perl5/plenv/bin
    )
fi

if [[ -n $ptolemarch_HOST_perceptyx_laptop ]]; then
    # should this test for the presence of homebrew?
    # what about the presence of these particular formulae?
    path+=(
        # curl is installed keg-only, but I want to use it
        # ( but I'll skip the LDFLAGS and CPPFLAGS stuff )
        /usr/local/opt/curl/bin

        # OSX has an old, broken grep, so use homebrew's instead
        /usr/local/opt/grep/libexec/gnubin

        # mysql@5.7 is keg-only
        /usr/local/opt/mysql@5.7/bin

        # mysql-client@5.7 is keg-only
        /usr/local/opt/mysql-client@5.7/bin

        # Docker cask
        /Users/davidhand/Applications/Docker.app/Contents/Resources/bin
    )
fi

if [[ -n $ptolemarch_HOST_perceptyx_jail ]]; then
    # next, at work only, the version of perl that the application uses
    path+=(
        /opt/perl/bin
        /opt/perl/perls/perl-5.28.1/bin/
        $path
    )
fi

# the core of the PATH
if [[ -n $ptolemarch_HOST_phone ]]; then
    path+=(
        /data/data/com.termux/files/usr/bin
        /data/data/com.termux/files/usr/bin/applets
    )
else
    path+=(
        /usr/local/games
        /usr/games
        /usr/local/bin
        /usr/bin
        /bin
        /usr/local/sbin
        /usr/sbin
        /sbin
    )
fi

# Gentoo adds some weird stuff to the PATH and I'll have to keep
#  up with that
if [[ -n $ptolemarch_HOST_patrick ]]; then
    path+=(
        /opt/bin
        /usr/lib/llvm/10/bin
    )
fi

# - I think I want ~/bin to be first, always
# - after that, the various dot-directories used for
#   - YADM
#   - plenv
#   - rakubrew
#   - (etc.)
# - certain things in /opt
#   - especially perl at work
# - homebrew: curl
#    /usr/local/opt/curl/bin
#    ( but I'll skip the LDFLAGS and CPPFLAGS stuff )
# - homebrew: grep
#    /usr/local/opt/grep/libexec/gnubin

# This is a way to get a list of the keg-only installed homebrew formulae:
#   for formula in $(brew list); do
#     brew info $formula | head -n 1
#   done | grep keg-only

# /usr/local/games
# /usr/games
# /usr/local/bin
# /usr/bin
# /bin
# /usr/local/sbin
# /usr/sbin
# /sbin

# ======================================================================
#   Don't forget to export it!
# ----------------------------------------------------------------------
export PATH
