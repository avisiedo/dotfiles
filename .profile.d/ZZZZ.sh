if tty -s &>/dev/null; then
    printf "Welcome to the Workstation\n"
    printf "Date: %s\n" "$(date +%d-%b-%Y)"
    printf -- "--------------------------\n"
    alias
    printf -- "--------------------------\n"
    printf "PATH=%s\n" "${PATH}"
fi
