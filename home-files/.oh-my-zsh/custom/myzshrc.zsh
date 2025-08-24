# Set my PATH
#PATH=.:${PATH}
HISTFILE=$HOME/.zsh_history
SAVEHIST=10000
setopt inc_append_history

set -o emacs
setopt no_hist_verify


# Ansible  aliases
alias a='ansible'
alias av='ansible-vault'
alias ad='ansible-doc'
alias ag='ansible-galaxy'
alias ap='ansible-playbook'
alias apsc='ansible-playook --syntax-check' 

alias t1='tail -f $HOME/logs/monitoring/$(date +%Y)/$(date +%m)/$(date +%d)/dnsGoogle.txt'
alias t2='tail -f $HOME/logs/monitoring/$(date +%Y)/$(date +%m)/$(date +%d)/dnsCloudFare.txt'
alias t3='tail -f $HOME/logs/monitoring/$(date +%Y)/$(date +%m)/$(date +%d)/dnsMediaRouter0.txt'
alias t4='tail -f $HOME/logs/monitoring/$(date +%Y)/$(date +%m)/$(date +%d)/dnsMediaRouter.txt'
alias t5='tail -f $HOME/logs/monitoring/$(date +%Y)/$(date +%m)/$(date +%d)/dnsMediaCom.txt'
alias t6='tail -f $HOME/logs/monitoring/$(date +%Y)/$(date +%m)/$(date +%d)/dnsPrivateRouter.txt'
alias t7='tail -f $HOME/logs/monitoring/$(date +%Y)/$(date +%m)/$(date +%d)/dnsPrivateRouterEAX20.txt'



# system aliases
unalias ls 2>/dev/null  
alias lsd='ls -ld'
alias ll='ls -l'
alias la='ls -la'
alias latr='ls -latr'
alias psg='ps -ef| grep  $@'
alias l='less'
alias m='more'
alias h='history'
alias hg='history|grep $@'

alias ugit='git config oh-my-zsh.hide-info 1'
alias agit='git config oh-my-zsh.hide-info 0'

sumcols() {
 set -x
 c=$1
 file=$2
 awk '{sum+='"\$$c"';print sum}' $file
}
function .() { [[ ! -r "$1" && -r "./$1" ]] && builtin . "./$1" || builtin . $@ }
#function agit() { sed 's/\( .*plugins.*\)/\1\a git

autoload -U compinit && compinit
