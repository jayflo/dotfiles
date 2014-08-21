#! /bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# {{{
if [[ -n "$PS1" ]] ; then

    # don't put duplicate lines in the history. See bash(1) for more options
    # ... or force ignoredups and ignorespace
    HISTCONTROL=ignoredups:erasedups:ignorespace
    export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    HISTSIZE=10000
    HISTFILESIZE=2000

    # Shell Options
    shopt -s checkwinsize
    shopt -s histappend
    shopt -s histverify
    shopt -s cmdhist

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi

    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi

    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        . /etc/bash_completion
    fi
fi

# RVM location
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# }}}

##################################################################
# Variables
##################################################################

source /usr/share/git/completion/git-prompt.sh
# prompt
PS1='┌─[\e[0;33m$(__git_ps1 "%s\e[m|")\e[0;34m\w\e[m]
└─╼ '

# Add RVM to PATH for scripting
# export PATH=$PATH:$HOME/.rvm/bin 
export PATH=$PATH:$HOME/.gem/ruby/2.1.0/bin
# export GEM_HOME=$HOME/.gem/ruby/2.0.0

# vim/less
export EDITOR=vim

# texlive
export PATH=$PATH:/usr/local/texlive/2014/bin/x86_64-linux
export INFOPATH=$INFOPATH:/usr/local/texlive/2014/texmf-dist/doc/info
export MANPATH=$MANPATH:/usr/local/texlive/2014/texmf-dist/doc/man

# gpg-agent
# if [ -f "${HOME}/.gpg-agent-info" ]; then
#   . "${HOME}/.gpg-agent-info"
#   export GPG_AGENT_INFO
#   export SSH_AUTH_SOCK
# fi

####################################################################
# My aliases
####################################################################
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# general convenience
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ../'
alias ...='cd ../../'
alias sudo='sudo '

# usage: `some output` | paste
alias paste="curl -F 'sprunge=<-' http://sprunge.us"

# version control
alias dtfl="git --work-tree=$HOME/ --git-dir=$HOME/dotfiles.git"
alias etcfl="git --work-tree=/etc/ --git-dir=/etc/etcfiles.git"

alias browse="feh -g 1920x1080 -d"

# vim
alias v='vim'
alias vs='vim --servername VIM --remote-silent "$@"'
alias g='gvim --remote-silent "$@"' #implicit servername GVIM[n], n=number of servers

# other programs
alias chrome="chromium --disk-cache-dir='/home/jayflo/.config/chromium' --allow-file-access-from-files"
alias irc='weechat-curses'

# systemd
alias syc='systemctl'
alias reboot='sudo systemctl reboot'
alias hibernate='sudo systemctl hibernate'
alias suspend='sudo systemctl suspend'
alias poweroff='sudo systemctl poweroff'

# btrfs
alias defrag_root='sudo find / -xdev \( -type f -o -type d \) -exec btrfs filesystem defragment -v -clzo -- {} +'

# update pacman mirrors
alias pacmiru='sudo reflector --verbose -l 50 -p http --sort rate --save /etc/pacman.d/mirrorlist'

# ssh/tmux
# function ssht(){
#   ssh $* -t '/opt/bin/tmux a || /opt/bin/tmux || /bin/ash'
# }

## package management
alias pac="sudo pacmatic -S"        #install
alias pacu="pacman -Syyu"	        #update system
alias pacr="sudo pacman -Rnsc"		#remove
alias pacs="pacman -Ss"	            #search	
alias paci="pacman -Si"		        #info
alias paclf="pacman -Ql"	        #files owned
alias pacexpl="pacman -D --asexp"	#mark as explicit
alias pacimpl="pacman -D --asdep"	#mark as implicit

#locate orphans
alias paclo="pacman -Qdt"
#remove orphans
alias pacro="pacman -Qtdq > /dev/null && sudo pacman -Rs \$(pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')"

#List installed packages by name and size
#pacsysclean

# backup installed packages list
alias pacbak='pacman -Qqne > ~/.config/pkg.log && pacman -Qqme > ~/.config/pkg_aur.log'

#Find package(s) that depend on <package-name>
alias pacdep='pacman -Qi "$@" | grep "Required By"'

#############################################################################
#Useful functions
########################################################################
# {{{
# Color man
man() {
    env LESS_TERMCAP_mb=$(printf "\e[1;31m") \
	LESS_TERMCAP_md=$(printf "\e[1;31m") \
	LESS_TERMCAP_me=$(printf "\e[0m") \
	LESS_TERMCAP_se=$(printf "\e[0m") \
	LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
	LESS_TERMCAP_ue=$(printf "\e[0m") \
	LESS_TERMCAP_us=$(printf "\e[1;32m") \
	man "$@"
}

#Make extracting easy
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1        ;;
            *.tar.gz)    tar xzf $1     ;;
            *.tar.xz)    tar xJf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       rar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xf $1        ;;
            *.tbz2)      tar xjf $1      ;;
            *.tgz)       tar xzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
 }

 #dirsize - finds directory sizes and lists them for the current directory
 dirsize() {
     du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
         egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
     egrep '^ *[0-9.]*M' /tmp/list
     egrep '^ *[0-9.]*G' /tmp/list
     rm -rf /tmp/list
 }

 #displays the named directory and subdirectories in a tree
 tree() {
    if [ $# -eq 0 ] ; then
        ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
    elif [ -d $1 ] ; then
        cd $1
        ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
        cd - 2> /dev/null
    else
        echo "'$1' is not a directory"
        echo "Correct usage: tree path/to/directory/"
    fi
 }
# }}}

#########################################################################
# Remap TTY colors
#########################################################################
# {{{
if [ "$TERM" = "linux" ]; then
  echo -en "\e]P0002b36" # console background (dark blue)
  echo -en "\e]P7839496" # console foreground text (light grey)
  echo -en "\e]PC2aa198" # ls directory color, vim message color (cyan)
  echo -en "\e]P593a1a1" # xresources keywords
  echo -en "\e]P3268bd2" # xresources key names
  echo -en "\e]P9cb4b16" # vim variables
  echo -en "\e]P62aa198" # xresources values, vim strings, search bg color
  echo -en "\e]PA586e75" # vim comments
  echo -en "\e]P2859900" # vim keywords, selection bg, bracket matching bg
  echo -en "\e]P1dc322f" # vim escape characters, whitespace in git show, untracked files in git status
  echo -en "\e]PB657b83" # vim empty line markers ~
  echo -en "\e]P4cb4b16" # vim constants, cursor, mode indicator, sqbracket match fg
  echo -en "\e]P8073642" # vim selection fg
  echo -en "\e]PF859900" # command executed in git show
  echo -en "\e]PDd33682" # magenta
  echo -en "\e]PE0000ff" # debug blue

  clear #hmm, yeah we need this or else we get funky background collisions
fi
# }}}



