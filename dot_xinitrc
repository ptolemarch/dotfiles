# source systemwide .xinitrc? Or something?

# Turns out you gotta do this manually.
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# looks like it doesn't actually hurt anything to just run this,
#  even if not everything's there
# work office
#xrandr \
#	--output eDP1	--auto --primary		\
#	--output VGA1	--auto --left-of	eDP1	\
#	--output HDMI1	--auto --right-of	eDP1	

# home office
#xrandr \
#	--output VGA1	--auto --primary		\
#	--output eDP1	--auto --left-of	VGA1	

# pairing station
#xrandr \
#	--output HDMI1	--auto --primary		\
#	--output eDP1	--auto --right-of	HDMI1	

# straight from http://www.incenp.org/notes/2014/gnupg-for-ssh-authentication.html
#if test -f $XDG_RUNTIME_DIR/gpg-agent-info && kill -0 $(head -n 1 $XDG_RUNTIME_DIR/gpg-agent-info | cut -d: -f2) 2>/dev/null ; then
#    eval $(< $XDG_RUNTIME_DIR/gpg-agent-info)
#else
#    eval $(gpg-agent --daemon --enable-ssh-support --write-env-file $XDG_RUNTIME_DIR/gpg-agent-info)
#fi
#export GPG_AGENT_INFO
#export SSH_AUTH_SOCK

# wanna set up dbus explicitly
# xmobar
# mpd ?
# ssh agent for whole session (not just per-terminal)
# better notifications
#  - hexchat notifications?

# start things up
#eval $(ssh-agent -s)
#xscreensaver -no-splash &

#exec $HOME/Sources/wtftw/target/debug/wtftw
/usr/bin/xmonad

# shut things down
#ssh-agent -k
#xscreensaver-command -exit
