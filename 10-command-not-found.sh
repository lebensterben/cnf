command_not_found_handle () {
    echo "$1: command not found"
    if [ "`id -u`" == "0" ]; then
        MSG='$1 == cmd { print "To install " $1 " use:  swupd bundle-add " $2; exit }'
    elif groups | grep -q -w -e wheel -e wheelnopw ; then
        MSG='$1 == cmd { print "To install " $1 " use:  sudo swupd bundle-add " $2; exit }'
    else
        MSG='$1 == cmd { print "To install " $1 " your system administrator needs to do:  swupd bundle-add " $2; exit }'
    fi
    R=`awk -F"\t" -v cmd="$1" "$MSG" /usr/share/clear/commandlist.csv`
    if [ -n "$R" ]; then
        echo $R
    else
        MSG='$1 == cmd { print "The command " $1 " is not available, consider using: " $2; exit }'
        awk -F"\t" -v cmd="$1" "$MSG" /usr/share/clear/alternatives.csv
    fi
    return 127
}
