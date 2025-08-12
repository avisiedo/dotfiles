if tty -s &>/dev/null; then
    if which arp &>/dev/null; then
        case "$(uname -o)" in
            Darwin )
                [ $(arp -n -l -a | grep -v Address | wc -l) -eq 0 ] \
                    || curl "https://wttr.in"
                ;;
            Linux )
                [ $(arp -n | grep -v "Linklayer Address" | wc -l) -eq 0 ] \
                    || curl "https://wttr.in"
                ;;
            * )
                :
                ;;
        esac
    fi
fi
