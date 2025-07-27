# .bashrc

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
            source "$rc"
        fi
    done
fi
unset rc

