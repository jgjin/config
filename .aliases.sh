# alias e
# alias h
# alias i
# alias j
# alias n
# alias o
# alias q
# alias s
# alias x
# alias z
alias audioinfo="mediainfo"
alias brightness="sudo tee /sys/class/backlight/intel_backlight/brightness <<<"
alias cd="custom_cd"
alias connect="sudo netctl stop-all; sudo netctl start"
alias customcd="custom_cd"
alias disconnect="sudo netctl stop-all"
alias feh="feh --fullscreen --auto-zoom --image-bg black --quiet"
alias gitcommitdiff="git_commit_diff"
alias kblight="$HOME/bin/kb-light.py"
alias lemonbar="$HOME/bin/bar.sh | lemonbar -f \"Source Code Pro-20\" -p &"
alias lock="xscreensaver-command -lock"
alias ls="ls --almost-all --classify --color=always"
alias lsdir="find -type d -printf '%d\t%P\n' | sort -r -nk1 | cut -f2-"
alias makepkg="makepkg -Acs"
alias pacdl="sudo pacman -S"
alias pacinstall="sudo pacman -U"
alias paclist="pacman -Qqe"
alias pacrm="sudo pacman -Rs"
alias pacsearch="pacman -Ss"
alias pacupdate="sudo pacman -Syy"
alias pacupgrade="sudo pacman -Su"
alias play="mplayer -slave -input file=$HOME/.mplayer/cmd-fifo -speed 1.40 -af scaletempo -volume"
alias poweroff="systemctl hibernate"
alias recregex="rec_regex"
alias rm="rm -i"
alias rtime="sudo ntpdate -s time.nist.gov"
alias rxres="xrdb $HOME/.Xresources"
alias rzsh="source $HOME/.zshrc"
# Need to fix
alias tocmdarg="sed 's/ /\\ /g' | tr '\n' ' '"
alias updateconfig="update_config"
alias videoinfo="mediainfo"
alias volume="amixer -q sset Master"
alias wallpaper="/usr/bin/feh --bg-fill $HOME/pics/wallpaper.jpg"
alias ydl="youtube-dl --format bestaudio --output \"$HOME/music/%(playlist)s/%(autonumber)s %(title)s.%(ext)s\""
