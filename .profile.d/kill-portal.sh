#!/bin/bash
(exec 0</dev/null; exec 1>/dev/null; exec 2>/dev/null; while [ 1 -eq 1 ]; do pkill -f xdg-desktop-portal; sleep 0.5; done) &
