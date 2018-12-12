command_not_found_handle () {
    echo "$1: command not found"
    awk -F"\t" -v cmd="$1" '$1 == cmd { print "To install " $1 " use:  swupd bundle-add " $2; exit }' /usr/share/clear/commandlist.csv
    return 127
}
