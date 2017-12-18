#!/usr/bin/sh

if [[ "$#" -eq 0 ]]; then
    bspc rule -a "Firefox Beta" --one-shot desktop=4
else
    bspc rule -a "Firefox Beta" --one-shot desktop=$1
fi
firefox-beta --private-window
