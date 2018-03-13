# alias e
# alias h
# alias i
# alias j
# alias n
# alias o
# alias q
# alias s
# alias t
# alias x
alias audioinfo="mediainfo"
alias brightness="sudo tee /sys/class/backlight/intel_backlight/brightness <<<"
alias cd="custom_cd"
alias clear="/usr/bin/clear; echo Please use C-l"
alias cp="cp -i"
alias customcd="custom_cd"
alias diskusage="disk_usage"
alias disconnect="sudo netctl stop-all"
alias firefoxprivate="$HOME/bin/firefox-private.sh"
alias fm="pcmanfm"
alias gitamend="git commit --amend"
alias gitcommitdiff="git_commit_diff"
alias gitlist="git ls-tree --full-tree -r HEAD"
alias kblight="$HOME/bin/kb-light.py"
alias lemonbar="$HOME/bin/bar.sh | lemonbar -f \"Source Code Pro-24\" -p &"
alias lock="xscreensaver-command -lock"
alias lowerbar="xdo lower -a bar"
alias ls="ls --almost-all --classify --color=always"
alias lsdir="find -type d -printf '%d\t%P\n' | sort -r -nk1 | cut -f2-"
alias makepkg="makepkg -Acs"
alias mpv="mpv --input-ipc-server=/tmp/mpvsocket"
alias pacdl="sudo pacman -S"
alias pacinstall="sudo pacman -U"
alias paclist="pacman -Qqe"
alias pacrecent="expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n"
alias pacrm="sudo pacman -Rs"
alias pacsearch="pacman -Ss"
alias pacupdate="sudo pacman -Syy"
alias pacupgrade="sudo pacman -Su"
alias playh="play 24"
alias plays="play 50"
alias poweroff="systemctl hibernate"
alias psqlh="gpg --decrypt $HOME/.config/postgres/passphrase.gpg > $HOME/.pgpass; psql --host=$PGHOST --port=$PGPORT --dbname=$PGDATABASE --username=$PGUSER; cat /dev/null > $HOME/.pgpass"
alias raisebar="xdo raise -a bar"
alias recregex="rec_regex"
alias rm="rm -i"
alias rtime="sudo ntpdate -s time.nist.gov"
alias rxres="xrdb $HOME/.Xresources"
alias rzsh="source $HOME/.zshrc"
alias setwallpaper="feh --bg-fill"
alias sshrpi="ssh pi@192.168.1.100"
alias updateconfig="update_config"
alias updatemusic="rsync -ru --info=progress2 $HOME/music/sped-up/* volumio@192.168.1.100:/mnt/INTERNAL"
alias videoinfo="mediainfo"
alias viewf="view -f"
alias viewall="view_all"
alias viewallsort="view_all --sort mtime"
alias viewsort="view --sort mtime"
alias viewsortf="view --sort mtime -f"
alias volume="amixer -q sset Master"
alias vpnactivate="sudo echo &> /dev/null; gpg --decrypt $HOME/.config/vpn/credentials.gpg | sudo openconnect $VPN"
alias vpncheck="ip tuntap list"
alias wallpaper="setwallpaper $HOME/pics/wallpaper.jpg"
alias ydl="youtube-dl --format bestaudio --output \"$HOME/music/%(playlist)s/%(autonumber)s %(title)s.%(ext)s\""
alias zd="z -r"
