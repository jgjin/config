#!/usr/bin/sh

# Start clipmenu dameon
clipmenud &

# Load config params for X
xrdb ~/.Xresources

# Start xscreensaver daemon
xscreensaver &

# Lock on suspend
xss-lock -- /usr/bin/xscreensaver-command -lock &

# Start emacs daemon
/usr/bin/emacs --daemon

# Try to turn off system beep
xset b off

# Start redshift
pgrep redshift &> /dev/null || redshift &> /dev/null &

# Start RescueTime
rescuetime &

# Enable window manager key bindings
sxhkd &

# Start window manager
exec bspwm -c $HOME/.config/bspwm/bspwmrc

