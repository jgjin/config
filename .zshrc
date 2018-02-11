# Change and add
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=35;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=33:*.jpeg=33:*.gif=33:*.bmp=33:*.pbm=33:*.pgm=33:*.ppm=33:*.tga=33:*.xbm=33:*.xpm=33:*.tif=33:*.tiff=33:*.png=33:*.svg=33:*.svgz=33:*.mng=33:*.pcx=33:*.mov=33:*.mpg=33:*.mpeg=33:*.m2v=33:*.mkv=33:*.webm=33:*.ogm=33:*.mp4=33:*.m4v=33:*.mp4v=33:*.vob=33:*.qt=33:*.nuv=33:*.wmv=33:*.asf=33:*.rm=33:*.rmvb=33:*.flc=33:*.avi=33:*.fli=33:*.flv=33:*.gl=33:*.dl=33:*.xcf=33:*.xwd=33:*.yuv=33:*.cgm=33:*.emf=33:*.ogv=33:*.ogx=33:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*.org=45;36:*.log=30'

fpath=(~/.config/zsh/completions $fpath)

zstyle ':completion:*' completer _expand _complete _ignored _match
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename '/home/banana/.zshrc'

autoload -Uz compinit
compinit

# Shell variables
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
HISTORY_IGNORE="(cd*|ls*|clear|view*|gimp*|play*|man *|type *|rzsh|exit)"
PROMPT='%F{068}%n%f%F{029}@%f%F{134}%m%f %F{029}%~%f %F{068}%#%f '
# PINENTRY_USER_DATA="USE_CURSES=1"
setopt appendhistory autocd extendedglob HIST_EXPIRE_DUPS_FIRST HIST_FIND_NO_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_DUPS
bindkey -e

# Ignore duplicates when going back in history 
# https://github.com/zsh-users/zsh-history-substring-search/issues/19
if [[ -o HIST_FIND_NO_DUPS ]]; then
    local -A unique_matches
    for n in $_history_substring_search_matches; do
        unique_matches[${history[$n]}]="$n"
    done
    _history_substring_search_matches=(${(@no)unique_matches})
fi

# Environment variables
export CM_LAUNCHER='rofi'
export EDITOR='vim'
export GDK_SCALE=2
# export LS_COLORS
# export PATH="/home/banana/.cask/bin:$PATH"
export VISUAL='vim'
export _Z_DATA="$HOME/.dir_history"

# Support history-based cd
. /usr/share/z/z.sh
# cd if directory in current directory, otherwise move to directory based on history
custom_cd() {
    if [[ "$#" -eq 0 ]]; then
    	chdir $HOME
    else
	if [[ -d "$1" ]] || [[ "$1" = '-' ]]; then
	    chdir $1
	else
	    z -r $@
	fi
    fi
}

# Custom functions
connect() {
    sudo netctl stop-all
    ESTABLISHED=0
    sudo netctl start $@ && ESTABLISHED=1
    while [ "$ESTABLISHED" -le 60 ]; do
	ping -c 1 8.8.8.8 &>/dev/null
	if [ "$?" -eq 0 ]; then
            ESTABLISHED=61
	fi
	ESTABLISHED=$(($ESTABLISHED + 1))
	sleep 0.5
    done
    if [ "$ESTABLISHED" -eq 62 ]; then
	gpg --decrypt $HOME/.config/vpn/credentials.gpg | sudo openconnect $VPN
    fi
}

count() {
    NUM_FILES=`find $PWD -maxdepth 1 -type f | wc -l`
    NUM_DIRECTORIES=`find $PWD -maxdepth 1 -type d | wc -l`
    echo $NUM_FILES "files," $NUM_DIRECTORIES "directories"
}

# https://superuser.com/questions/611538/is-there-a-way-to-display-a-countdown-or-stopwatch-timer-in-a-terminal
# Start countdown from $1 seconds
countdown() {
    date1=$((`date +%s` + $1)); 
    while [ "$date1" -ge `date +%s` ]; do 
	echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
	sleep 0.1
    done
}

# Git commit files with changes
git_commit_diff() {
    COMMIT_FILES=$(git diff --name-only HEAD | tr '\n' ' ')
    eval "git commit $COMMIT_FILES"
}

# Play audio at 1.40x speed
play() {
    amixer -q sset Master $1%
    mpv --speed=1.40 --hwdec=auto --volume=100 --gapless-audio=yes ${@:2} --input-ipc-server=/tmp/mpvsocket
}

# Perform command $2 on arguments matching regex $1
rec_regex() {
    ARGS=$(ag --smart-case -g $1 | sed 's/ /\\ /g' | tr '\n' ' ')
    eval "$2 $ARGS"
}

# Start stopwatch with hours, minutes, and seconds
stopwatch() {
    date1=`date +%s`; 
    while true; do 
	echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r"; 
	sleep 0.1
    done
}

# Update essential configuration at $HOME
update_config() {
    /usr/bin/ls ~/music > ~/album_list.txt
    pacman -Qqe > ~/package_list.txt
    python -m json.tool ~/.mozilla/firefox/sdqomrpy.default/addons.json |
	ag "\"name\"" | sed '0~2d' |
	cut -d\" -f4 > ~/.mozilla/firefox/sdqomrpy.default/addons.txt
    chdir ~
    git_commit_diff
    chdir -
}

# View pictures sorted by name in fullscreen without bar
view() {
    xdo lower -a "bar"
    feh --fullscreen --auto-zoom --image-bg black --quiet $@
    xdo raise -a "bar"
}

# # View pictures sorted by modification timestamp in fullscreen without bar
# view_sort() {
#     xdo lower -a "bar"
#     feh --fullscreen --auto-zoom --image-bg black --quiet --sort mtime $@
#     xdo raise -a "bar"
# }

# Aliases and other configurations
source $HOME/.config/postgres/config.sh
source $HOME/.config/vpn/config.sh
source $HOME/.aliases.sh
