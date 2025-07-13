if tty -s &>/dev/null; then
    if which arp &>/dev/null; then
        [ $(arp -n | grep -v Address | wc -l) -eq 0 ] || curl "https://wttr.in"
    fi
fi
