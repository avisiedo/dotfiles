#!/bin/bash

set -e

if ! pgrep opensnitch-ui &>/dev/null; then
    if which opensnitch-ui &>/dev/null; then
        swaymsg "exec /usr/local/bin/opensnitch-ui"
    fi
fi

if ! pgrep rhythmbox &>/dev/null; then
    if which rhythmbox &>/dev/null; then
        swaymsg "exec /usr/bin/rhythmbox"
    fi
fi

