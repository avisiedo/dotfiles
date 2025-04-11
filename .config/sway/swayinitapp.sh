#!/bin/bash

set -e

if ! pgrep opensnitch-ui &>/dev/null; then
    if which opensnitch-ui &>/dev/null; then
        swaymsg "exec /usr/local/bin/opensnitch-ui"
    fi
fi

