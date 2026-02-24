export_path() {
    ! tty -s &>/dev/null && return 0
    [ ! -e /opt/homebrew/bin/ssh ] && return 0

    export PATH="/opt/homebrew/bin:$PATH"
    return 0
}

export_path
