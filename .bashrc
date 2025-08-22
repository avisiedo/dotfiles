# .bashrc

VERBOSE=0

trace_file() {
    local filename="$1"
    if tty -s && [ "${VERBOSE}" == "1" ]; then
        printf "info:processing '%s'\n" "${filename}"
    fi
    return 0
}

# Source global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific environment
if [ -d ~/.profile.d ]; then
    for rc in ~/.profile.d/*.sh; do
        if [ -f "$rc" ]; then
            trace_file "$rc"
            source "$rc"
        fi
    done
fi
unset rc

