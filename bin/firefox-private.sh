#!/usr/bin/sh

if [[ "$#" -eq 0 ]]; then
    bspc rule -a "Firefox Beta" --one-shot desktop=4
else
    if [[ "$1" -eq 0 ]]; then
	bspc rule -a "Firefox Beta" --one-shot hidden=on desktop=$1
    else
	bspc rule -a "Firefox Beta" --one-shot desktop=$1
    fi
fi
firefox-beta --private-window
