# yazi file manager
function ya() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                cd -- "$cwd"
        fi
        rm -f -- "$tmp"
}


# https://github.com/Sonico98/yazi-prompt.sh
YAZI_TERM=""
if [ -n "$YAZI_LEVEL" ]; then
        YAZI_TERM="|  Yazi terminal: "
fi
PS1="$PS1$YAZI_TERM"
