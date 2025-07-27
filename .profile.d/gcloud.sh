##
# Initialize gcloud
# This expect to be installed at $HOME/opt/google-cloud-sdk
##
if tty -s &>/dev/null && [ -d "$HOME/opt/google-cloud-sdk" ]; then
    # The next line updates PATH for the Google Cloud SDK.
    # [ ! -f "${HOME}/opt/google-cloud-sdk/path.bash.inc" ] || {
    #     source "${HOME}/opt/google-cloud-sdk/path.bash.inc"
    # }
    if [[ ! "$PATH" =~ ":$HOME/opt/google-cloud-sdk/bin:" ]] \
        && [[ ! "$PATH" =~ ^"$HOME/opt/google-cloud-sdk/bin:" ]] \
        && [[ ! "$PATH" =~ ":$HOME/opt/google-cloud-sdk/bin"$ ]]; then
        export PATH="$PATH:$HOME/opt/google-cloud-sdk/bin"
    fi

    # The next line enables shell command completion for gcloud.
    [ ! -f "${HOME}/opt/google-cloud-sdk/completion.bash.inc" ] || {
        source "${HOME}/opt/google-cloud-sdk/completion.bash.inc"
    }
fi

