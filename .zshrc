
# zstyle ':completion:*' completer _list _expand _complete _ignored _match
# zstyle ':completion:*' completions 1
# zstyle ':completion:*' glob 1
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' list-colors ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename '/home/banana/.zshrc'

autoload -Uz compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
PROMPT='%F{068}%n%f%F{029}@%f%F{134}%m%f %F{029}%~%f %F{068}%#%f '
setopt appendhistory autocd extendedglob
bindkey -e

export GDK_SCALE=2
export EDITOR='vim'
export VISUAL='vim'

# Aliases
alias brightness="sudo tee /sys/class/backlight/intel_backlight/brightness <<<"
alias feh="feh --fullscreen --auto-zoom --image-bg black --quiet"
alias lemonbar="~/bin/bar.sh | lemonbar -f \"Source Code Pro-20\" -p &"
alias lock="xscreensaver-command -lock"
alias ls="ls --almost-all --classify --color=always"
alias makepkg="makepkg -Acs"
alias netcampus="sudo netctl stop-all; sudo netctl start wlp58s0-campus"
alias nethome="sudo netctl stop-all; sudo netctl start wlp58s0-home"
alias pacdl="sudo pacman -S"
alias pacinstall="sudo pacman -U"
alias paclist="sudo pacman -Qe"
alias pacrm="sudo pacman -Rs"
alias pacsearch="sudo pacman -Ss"
alias play="mplayer -speed 1.40 -af scaletempo -volume"
alias rm="rm -i"
alias rtime="sudo ntpdate -s time.nist.gov"
alias rxres="xrdb ~/.Xresources"
alias rzsh="source ~/.zshrc"
alias wallpaper="/usr/bin/feh --bg-fill ~/pics/wallpaper.jpg"
alias ydl="youtube-dl --format bestaudio --output \"~/music/%(playlist)s/%(autonumber)s %(title)s.%(ext)s\""
