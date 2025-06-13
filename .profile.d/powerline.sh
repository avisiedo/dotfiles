# https://github.com/justjanne/powerline-go
# Require: dnf install powerline-go powerline-font
function _update_ps1() {
    # For podman we can check if the context is a container by checking
    # /run/.containerenv
    PS1="$(powerline-go -error $? -jobs $(jobs -p | wc -l) -cwd-max-depth 3 -numeric-exit-codes -theme default)"

    # Uncomment the following line to automatically clear errors after showing
    # them once. This not only clears the error for powerline-go, but also for
    # everything else you run in that shell. Don't enable this if you're not
    # sure this is what you want

    #set "?"
}

if [ "${TERM}" != "linux" ] && [ -f "$(which powerline-go 2>/dev/null)" ]; then
    PROMPT_COMMAND="_update_ps1; ${PROMPT_COMMAND}"
fi
