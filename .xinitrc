#!/bin/sh

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

# Enable window manager key bindings
sxhkd &

# Start window manager
exec bspwm
