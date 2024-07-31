# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi


# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

# Set environment
export GREP_COLOR='1;36'
export HISTCONTROL='ignoredups'

#Alias

alias ..='echo "cd .."; cd ..'
alias c='clear; echo'
alias du='du -Sh | sort -n -r |more'

# Enable color support of ls
if ls --color=auto &>/dev/null; then
        alias ls='ls -p --group-directories-first --color=auto'
else
        alias ls='ls -p --group-directories-first'
fi

# Git Aliases
alias nb='git checkout -b "$USER-$(date +%s)"' # new branch
alias ga='git add . --all'
alias gb='git branch'
alias gc='git clone'
alias gci='git commit -a'
alias gco='git checkout'
alias gd="git diff ':!*lock'"
alias gdf='git diff' # git diff (full)
alias gi='git init'
alias gl='git log'
alias gp='git push origin HEAD'
alias gr='git rev-parse --show-toplevel' # git root
alias gs='git status'
alias gt='git tag'
alias gu='git pull' # gu = git update

#Functions

wait() {
while true
do
        echo -n "-"
        sleep 1
done
}

# Create a new directory and enter it
mkd() {
        mkdir -p "$@"
        cd "$@" || exit
}

#Finds 5 newest files - non-hidden
newest() {
        find . -type f \( ! -regex '.*/\..*' \) -print0 | xargs -0 stat -c "%Y:%n" | sort -n| tail -n 5 | cut -d ':' -f2-
}

ssh-asap() {
until nc -vzw 2 $1 22 > /dev/null 2>&1; do sleep 1; done
ssh  $1;
}

#extract everything
ex () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1                  ;;
            *.tar.gz)    tar xvzf $1                  ;;
            *.bz2)       bunzip2 $1                   ;;
            *.rar)       unrar x $1                   ;;
            *.gz)        gunzip $1                    ;;
            *.tar)       tar xvf $1                   ;;
            *.tbz2)      tar xvjf $1                  ;;
            *.tgz)       tar xvzf $1                  ;;
            *.zip)       unzip $1                     ;;
            *.Z)         uncompress $1                ;;
            *.7z)        7z x $1                      ;;
            *)           echo "can't extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

