if [ "$KUBE_PS1_ENABLED"x == "x" ]; then
    # kube_ps1 has not been initialized. like initial login.. but kube-ps1.sh does exist
    #source $HOME/.kube/kube-ps1.sh && echo "sourced $HOME/.kube/kube-ps1.sh"
    source $HOME/.bashrc_custom/addons//kube-ps1.sh
    if [ "$KUBE_PS1_ENABLED"x == "x" ]  ; then
      # We have to do some trickery here due to how kube-ps1 is writting.. we must
      # set some vars by running kubeon, sourcethe file again, then turn kube-ps1 off to set
      # a standard prompt
      kubeon
      source $HOME/.bashrc_custom/addons/kube-ps1.sh
      kubeoff
      PS1='$(kube_ps1)\[\e[1;32m\]\u@\H (\W)${PROMPT_SFX}\[\e[m\]'
      #PROMPT_COMMAND='_kube_ps1_update_cache;echo -ne "\033]0; ${KUBE_PS1_SYMBOL_DEFAULT} ${KUBE_PS1_CONTEXT} ${KUBE_PS1_SEPARATOR} ${KUBE_PS1_NAMESPACE} (${HOSTNAME}:$(basename $PWD))\007"'
      PROMPT_COMMAND='echo -ne "\033]0; ${KUBE_PS1_SYMBOL_DEFAULT} ${KUBE_PS1_CONTEXT} ${KUBE_PS1_SEPARATOR} ${KUBE_PS1_NAMESPACE} (${HOSTNAME}:$(basename $PWD))\007"'
    else
      # kube_ps1 has been initialized
      PS1='$(kube_ps1)\[\e[1;32m\]\u@\H (\W)${PROMPT_SFX}\[\e[m\]'
      #PROMPT_COMMAND='_kube_ps1_update_cache;echo -ne "\033]0; ${KUBE_PS1_SYMBOL_DEFAULT} ${KUBE_PS1_CONTEXT} ${KUBE_PS1_NAMESPACE} (${HOSTNAME}:$(basename $PWD))\007"'
      PROMPT_COMMAND='echo -ne "\033]0; ${KUBE_PS1_SYMBOL_DEFAULT} ${KUBE_PS1_CONTEXT} ${KUBE_PS1_NAMESPACE} (${HOSTNAME}:$(basename $PWD))\007"'
    fi
elif [ "$KUBE_PS1_ENABLED" == "on" -o "$KUBE_PS1_ENABLED" == "off" ]; then
  # kube_ps1 is either on or off, so it is initialized
  PS1='$(kube_ps1)\[\e[1;32m\]\u@\H (\W)${PROMPT_SFX}\[\e[m\]'
  #PROMPT_COMMAND='_kube_ps1_update_cache;echo -ne "\033]0; ${KUBE_PS1_SYMBOL_DEFAULT} ${KUBE_PS1_CONTEXT} ${KUBE_PS1_NAMESPACE} (${HOSTNAME}:$(basename $PWD))\007"'
  PROMPT_COMMAND='echo -ne "\033]0; ${KUBE_PS1_SYMBOL_DEFAULT} ${KUBE_PS1_CONTEXT} ${KUBE_PS1_NAMESPACE} (${HOSTNAME}:$(basename $PWD))\007"'
  source $HOME/.bashrc_custom/addons//kube-ps1.sh
fi
