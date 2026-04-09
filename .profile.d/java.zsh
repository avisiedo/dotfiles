if tty -s; then
    if [ "Darwin" == "$(uname -s)" ]; then
        if [ -e "/opt/homebrew/opt/openjdk" ]; then
            export JAVA_HOME="/opt/homebrew/opt/openjdk"
            export PATH="$PATH:${JAVA_HOME}/bin"
        fi
    fi
fi
