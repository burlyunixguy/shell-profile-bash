# Setup k8s environment
#
alias k='kubectl'
alias kgp='k get pods $@'
alias kgpw='k get pods -o wide $@'
alias kd='k describe $@'


function kc() { context=$1; if [ $context"x" != "x" ]; then kubechc $context; else kubectl config get-contexts; fi ; }
function kn() { namespace=$1; if [ $namespace"x" != "x" ]; then kubechn $namespace; else k get ns; fi ; }


## echo "source <(kubectl completion bash)" >> ~/.bashrc-kube
## echo "source <(kubectl completion zsh)" >> ~/.oh-my-zsh/custom/kubectl.sh
## source $HOME/.oh-my-zsh/custom/kubectl.sh
#source $HOME/.kubectl.bash
#

source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
$(echo $PS1 | grep -q kube_ps1 ) || PS1='$(kube_ps1)'$PS1

source ~/.kubech/kubech

complete -F __start_kubectl k
complete -F __start_kubectl kgp
complete -F __start_kubectl kd



