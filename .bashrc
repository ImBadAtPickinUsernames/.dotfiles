#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

BLACK=$'\e[0;30m'
RED=$'\e[0;31m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
BLUE=$'\e[0;34m'
MAGENTA=$'\e[0;35m'
CYAN=$'\e[0;36m'
WHITE=$'\e[0;37m'
NC=$'\e[0m' # No Color (resets attributes)

# PS1='[\u@\h \W]\$ '
PS1=' \[${BLUE}\]\w\[${NC}\] > '

echo
fastfetch 
echo

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/lopi/.lmstudio/bin"
