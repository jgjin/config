#!/usr/bin/sh

# Start clipmenu dameon
clipmenud &

# Start xscreensaver daemon
xscreensaver &

# Lock on suspend
xss-lock -- /usr/bin/xscreensaver-command -lock &

# Start emacs daemon
/usr/bin/emacs --daemon

# Load config params for X
xrdb ~/.Xresources

# Try to turn off system beep
xset b off

# Enable window manager key bindings
sxhkd &

# Start window manager
exec bspwm -c $HOME/.config/bspwm/bspwmrc

