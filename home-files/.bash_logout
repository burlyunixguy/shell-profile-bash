##############################################################################
#### Capture exit signal and dump the history file an all file..to keep it around forever
#### Doing this will also allow the main history file to reset and numbers to start over
#### at 0
##############################################################################
case "$CALLINGSHELL" in
    *bash*|*zsh*)
        trap "
            if [ ! -z $HISTFILE ]; then
                echo "-----DATE_SAVED-----`date +%Y%m%d-%T`-----------" >> ${HISTFILE}
                history -a
                cat $HISTFILE >> ${HISTFILE}.all
                cat /dev/null > $HISTFILE
                chmod 600 ${HISTFILE}.all
            fi" 0
    ;;
esac
