############
# Deteremine what type of system we are running on
############
    export HOME=/users/dearlneal/unix
    export systemtype=`uname -s`
    export CALLINGSHELL="$0"
    export BASHRC_ADDONS=${HOME}/.bashrc_addons
    export BASHRC_CUSTOM=${HOME}/.bashrc_custom

    source ${BASHRC_ADDONS}
 
 
############
# Let's setup a history file based on our SHELL
############
    case $CALLINGSHELL in
        *bash*)
            HISTFILE=$HOME/.bash_history_$USER
            HISTSIZE=10000
        ;;
        *zsh*)
            HISTFILE=$HOME/.zsh_history_$USER
            HISTSIZE=-1               # keep all entries forever
        ;;
        '-sh') # Command history not available
        ;;
    esac
    HISTTIMEFORMAT="%F_%R "   # Keep time information. If  want the time, comment this out
    [ -z $HISTFILE ] ||  touch $HISTFILE
    export HISTFILE HISTSIZE
 

## Source files in .bashrc_custom
for f in $(ls -1d ${BASHRC_CUSTOM}/rc_files/*); do
  source $f && echo "SOURCED $f" || echo "sourcing file had failure"
done 
 
###################################################################
# Set up environment per system
# This file used to be for  redhat, suse, solaris, irix and aix.
# Now only linux and and something generic for other systems.
###################################################################
 
    case $systemtype in
      Darwin|Linux)
        ### Set Paths
          PATH=${PATH}:$HOME/.local/bin
 
          ## You may want to set these
          #MANPATH=/usr/share/man:/usr/local/man:/usr/X11R6/man:/opt/gnome/share/man
          #LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/gnome/lib
          #LD_LIBRARY_PATH_64=${LD_LIBRARY_PATH_6}:/opt/gnome/lib64
          # Append the 64 bit libraries to the path
          #LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LD_LIBRARY_PATH_64
 
        ### Set some VARS
          HN=`/usr//bin/uname -n`        # We use these for setting the prompt and titlebar
          MYID=`/usr/bin/id -u`     # We use these for setting the prompt and titlebar
          MYUN=`/usr/bin/id -un`    # We use these for setting the prompt and titlebar
 
 
          # If EDITOR is not set, use vi/vim for default editor.  User can override and use
          # nano if they prefer
          # EDITOR=nano
          if [ -z $EDITOR ]; then
            if [ -f /usr/bin/vim ]; then
               export EDITOR=vim
            fi
          fi
          set -o emacs              # Set command line editing mode to emacs
          PAGER="less"              # Common Pagers are more or less
          LESS="ieFRX"
          [ -f /usr/bin/src-hilite-lesspipe.sh ] && export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
          export PAGER LESS
      ;;
      *)   # Something Different
        ## Set paths
        if [ "$PATH"x = "x" ]; then
            PATH=/bin:/usr/bin:/usr/local/bin:/usr/X11R6/bin
            PATH=${PATH}:/sbin:/usr/sbin
        fi
 
        if [ "$MANPATH"x = "x" ]; then
            MANPATH=$MANPATH:/usr/share/man:/usr/local/share/man
        fi
 
        if [ "$LD_LIBRARY_PATH"x = "x" ]; then
            LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:/usr/local/lib:/usr/openwin/lib
        fi
 
        ## Set Vars
        HN=`uname -n`
        MYID=`id -u`
        if ! [ $? ]; then
            echo "unable to determine user id on this platform"
        fi
        MYID=`id -un`
        if ! [ $? ]; then
            echo "unable to determine user name on this platform"
        fi
     ;;
   esac
 
   export PATH MANPATH LD_LIBRARY_PATH
 
 

  #function psjson=' { ps -ef | jq -sR '[sub("\n$";"") | splits("\n") | sub("^ +";"") | [splits(" +")]] | .[0] as $header | .[1:] | [.[] | [. as $x | range($header | length) | {"key": $header[.], "value": $x[.]}] | from_entries]' ; }'
# ps -ef|grep "kube-apiserver "|egrep -v "grep| sed "| sed 's/.* kube-apiserver /kube-apiserver /g'|awk '{for(x=1;x<=NF;x++) printf "\t%s\n", $x; printf "\n" }'
 
 
    if [ "$MYID" = "0" ]; then  # root but can be anyone else
        TTLBR_PRX="## "    # Title Bar Prefix
        PROMPT_SFX="#"     # Prompt Suffix
    else
        TTLBR_PRX=">> "
        PROMPT_SFX=">"
    fi
    case "$CALLINGSHELL" in
      *bash*|*zsh*)
        # Higlighted prompt wraps around same line and not next line
        # Keep it commented until fixed.
        #PS1="\u@\H (\W) \!${PROMPT_SFX}${TITLEBAR}"
        #PS1=${TITLEBAR}'\e[1;32m\u\e[m@\e[1;33m\H\e[m \e[1;32m(\W)${PROMPT_SFX}\e[m'
        PS1=${TITLEBAR}'\[\e[1;32m\]\u@\H (\W)${PROMPT_SFX}\[\e[m\]'
        PROMPT_COMMAND='echo -ne "\033]0;${TTLBR_PRX}${HN}: ${PWD}/\007"'
      ;;
      *sh) # Only gets here if not bash or ksh
        case $TERM in
          dtterm* | xterm* | rxvt* | iris-ansi-net | winterm)
            # ksh syntax
            TITLEBAR=""
          ;;
 
          *)
            TITLEBAR=''
          ;;
        esac
        PS1="${MYUN}@${HN} ${PROMPT_SFX}${TITLEBAR}"
      ;;
    esac
 
