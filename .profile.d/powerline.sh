# https://github.com/justjanne/powerline-go
# Require: dnf install powerline-go powerline-font
function _update_ps1() {
    # For podman we can check if the context is a container by checking
    # /run/.containerenv
    #
    # (valid choices: aws, bzr, cwd, direnv, docker, docker-context, dotenv,
    # duration, exit, fossil, gcp, git, gitlite, goenv, hg, host, jobs, kube,
    # load, newline, nix-shell, node, perlbrew, perms, plenv, rbenv, root, rvm,
    # shell-var, shenv, ssh, svn, termtitle, terraform-workspace, time, user,
    # venv, vgo, vi-mode, wsl)
    # Unrecognized modules will be invoked as 'powerline-go-MODULE' executable
    # plugins and should output a (possibly empty) list of JSON objects that
    # unmarshal to powerline-go's Segment structs.
    # (default "venv,user,host,ssh,cwd,perms,git,hg,jobs,exit,root")
    local MODULES="direnv,venv,user,host,ssh,cwd,perms,git,jobs,exit,root"
    PS1="$(powerline-go -error $? -newline -jobs "$(jobs -p | wc -l)" -modules "${MODULES}" -cwd-max-depth 3 -numeric-exit-codes -theme default)"

    # Uncomment the following line to automatically clear errors after showing
    # them once. This not only clears the error for powerline-go, but also for
    # everything else you run in that shell. Don't enable this if you're not
    # sure this is what you want

    #set "?"
}

if [ "${TERM}" != "linux" ] && [ -f "$(which powerline-go 2>/dev/null)" ]; then
    PROMPT_COMMAND="_update_ps1; ${PROMPT_COMMAND}"
fi
